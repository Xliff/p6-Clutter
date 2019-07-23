use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use Clutter::Raw::Types;
use Clutter::Raw::KeyframeTransition;

use GTK::Raw::Utils;

use Clutter::PropertyTransition;

my @set-methods = <
  key_frame     key-frame
  key_frames    key-frames
  modes
  values
>;

our subset KeyframeTransitionAncestry of Mu
  where ClutterKeyframeTransition | PropertyTransitionAncestry;

class Clutter::KeyframeTransition is Clutter::PropertyTransition {
  has ClutterKeyframeTransition $!ckt;
  
  submethod BUILD (:$keyframe-transition) {
    given $keyframe-transition {
      when KeyframeTransitionAncestry {
        my $to-parent;
        $!ckt = do {
          when ClutterKeyframeTransition {
            $to-parent = cast(ClutterPropertyTransition, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterKeyframeTransition, $_);
          }
        };
        self.setPropertyTransition($to-parent);
      }
      when Clutter::KeyframeTransition {
      }
      default {
      }
    }
  }
      
  method new (Str() $property_name) {
    self.bless(
      keyframe-transition => clutter_keyframe_transition_new($property_name)
    );
  }
  
  method setup (*%data) {
    for %data.keys -> $_ is copy {
      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "KfTSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} );
        %data{$_}:delete;
      }
    }

    self.Clutter::PropertyTransition::setup( |%data ) if %data.keys;
    self;
  }
 
  method clear {
    clutter_keyframe_transition_clear($!ckt);
  }

  method get_key_frame (
    Int() $index, 
    Num() $key, 
    Int() $mode, 
    GValue() $value
  ) 
    is also<get-key-frame> 
  {
    my guint ($i, $m) = resolve-uint($index, $mode);
    my gdouble $k = $key;
    clutter_keyframe_transition_get_key_frame($!ckt, $i, $k, $m, $value);
  }

  method get_n_key_frames is also<get-n-key-frames> {
    clutter_keyframe_transition_get_n_key_frames($!ckt);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( 
      self.^name, &clutter_keyframe_transition_get_type, $n, $t
    );
  }

  method set_key_frame (
    Int() $index, 
    Num() $key, 
    Int() $mode, 
    GValue() $value
  ) 
    is also<set-key-frame> 
  {
    my guint ($i, $m) = resolve-uint($index, $mode);
    my gdouble $k = $key;
    clutter_keyframe_transition_set_key_frame($!ckt, $i, $k, $m, $value);
  }

  method set_key_frames (Int() $n_key_frames, @key_frames) 
    is also<set-key-frames> 
  {
    my @frames = @key_frames.map({ try .Num });
    die '@key_frames must only contain floating point values!'
      unless @frames.all ~~ Num;
      
    my guint $nf = resolve-uint($n_key_frames);
    my $f = CArray[gdouble].new;
    $f[$_] = @frames[$_] for @frames.keys;
    clutter_keyframe_transition_set_key_frames($!ckt, $nf, $f);
  }

  method set_modes (Int() $n_modes, @modes) is also<set-modes> {
    die '@modes must only contain integers!'
      unless @modes.all ~~ Int;
      
    my guint $nm = resolve-uint($n_modes);
    my $m = CArray[guint].new;
    $m[$_] = @modes[$_] for @modes.keys;
    clutter_keyframe_transition_set_modes($!ckt, $n_modes, $m);
  }

  method set_values (Int() $n_values, GValue() $values) 
    is also<set-values> 
  {
    my guint $nv = resolve-uint($n_values);
    clutter_keyframe_transition_set_values($!ckt, $nv, $values);
  }

}
