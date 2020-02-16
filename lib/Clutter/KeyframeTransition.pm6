use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;
use Clutter::Raw::KeyframeTransition;\

use GLib::Value;
use Clutter::PropertyTransition;

use GLib::Roles::TypedBuffer;

my @set-methods = <
  key_frame     key-frame
  key_frames    key-frames
  modes
  values
>;

our subset ClutterKeyframeTransitionAncestry of Mu
  where ClutterKeyframeTransition | PropertyTransitionAncestry;

class Clutter::KeyframeTransition is Clutter::PropertyTransition {
  has ClutterKeyframeTransition $!ckt;

  submethod BUILD (:$keyframe-transition) {
    given $keyframe-transition {
      when ClutterKeyframeTransitionAncestry {
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

  multi method new (ClutterKeyframeTransitionAncestry $keyframe-transition) {
    $keyframe-transition ?? self.bless(:$keyframe-transition) !! Nil;
  }
  multi method new (Str() $property_name) {
    my $keyframe-transition = clutter_keyframe_transition_new($property_name);

    $keyframe-transition ?? self.bless(:$keyframe-transition) !! Nil;
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

  # cw: Future enhancement... do we want to make this object an Iterator
  # so it can iterate over key-frames and return a tuple of:
  #   (key-frame, mode, ACTUAL value) -- return the GValue if :$gvalue.

  proto method get_key_frame (|)
    is also<get-key-frame>
  { * }

  multi method get_key_frame (Int() $index) {
    samewith($index, $, $, $);
  }
  multi method get_key_frame (
    Int() $index,
    $key   is rw,
    $mode  is rw,
    $value is rw
  )
  {
    my guint $i = 0;
    my ClutterAnimationMode $m = 0;
    my gdouble $k = 0e0;
    $value = GValue.new;

    die 'Cannot allocate GValue!' unless $value;

    clutter_keyframe_transition_get_key_frame($!ckt, $i, $k, $m, $value);
    ($key, $mode, $value) = ($k, $m, $value);
  }

  method get_n_key_frames
    is also<
      get-n-key-frames
      elems
    >
  {
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
    my guint $i = $index;
    my ClutterAnimationMode $m = $mode;
    my gdouble $k = $key;

    clutter_keyframe_transition_set_key_frame($!ckt, $i, $k, $m, $value);
  }

  proto method set_key_frames (|)
    is also<set-key-frames>
  { * }

  # cw: Why @f and $f? -- Because I CAN.
  multi method set_key_frames(*@frames) {
    samewith(@frames.elems, @frames);
  }
  multi method set_key_frames (Int() $n_key_frames, @key_frames is copy) {
    @key_frames = @key_frames.map({
      my $coercible = .^lookup('Num');

      die '@key_frames must only contain floating point values!'
        unless $_ ~~ Num || $coercible;

      $coercible ?? .Num !! $_
    });

    samewith( $n_key_frames, ArrayToCArray(gdouble, @key_frames) );
  }
  multi method set_key_frames(Int() $n_key_frames, CArray[gdouble] $key_frames) {
    clutter_keyframe_transition_set_key_frames($n_key_frames, $key_frames);
  }

  proto method set_modes (|)
    is also<set-modes>
  { * }

  multi method set_modes (*@modes) {
    samewith(@modes.elems, @modes);
  }
  multi method set_modes(Int() $n_modes, @modes) {
    @modes = @modes.map({
      my $coercible = .^lookup('Int');

      die '@key_frames must only contain Integer compatible values!'
        unless $_ ~~ Int || $coercible;

      $coercible ?? .Int !! $_
    });

    samewith($n_modes, ArrayToCArray(ClutterAnimationMode, @modes) );
  }
  multi method set_modes(Int() $n_modes, CArray[ClutterAnimationMode] $modes) {
    my guint $nm = $n_modes;

    clutter_keyframe_transition_set_modes($!ckt, $n_modes, $modes);
  }

  proto method set_values (|)
    is also<set-values>
  { * }

  # GValue is a CStruct... must use a typed buffer!
  multi method set_values (*@values) {
    samewith(@values.elems, @values);
  }
  multi method set_values (Int() $n_values, @values is copy) {
    @values = @values.map({
      my $coercible = .^lookup('GValue');

      die '@values must only contain GValue-compatible types!'
        unless $_ ~~ GValue || $coercible;

      $coercible ?? .GValue !! $_;
    });

    my $v = GLib::Roles::TypedBuffer[GValue].new(@values);

    samewith($n_values, $v.p);
  }
  multi method set_values(Int() $n_values, Pointer $vals) {
    my guint $nv = $n_values;

    clutter_keyframe_transition_set_values($!ckt, $nv, $vals);
  }

}
