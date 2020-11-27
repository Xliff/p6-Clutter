use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::Transition;

use GLib::Value;
use Clutter::Timeline;

my @attributes = <
  animatable
  interval
  remove_on_complete    remove-on-complete
>;

my @set-methods = <
  from_value            from-value
  to_value              to-value
>;

subset ClutterTransitionAncestry is export of Mu
  where ClutterTransition | ClutterTimelineAncestry;

class Clutter::Transition is Clutter::Timeline {
  has ClutterTransition $!ct;

  submethod BUILD (:$transition) {
    self.setTransition($transition) if $transition.defined;
  }

  method setTransition (ClutterTransitionAncestry $_) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!ct = do {
      when ClutterTransition {
        $to-parent = cast(ClutterTimeline, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterTimeline, $_);
      }
    }
    self.setTimeline($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterTransition
    is also<ClutterTransition>
  { $!ct }

  method new (ClutterTransitionAncestry $transition) {
    $transition ?? self.bless(:$transition) !! Nil;
  }

  method setup (*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "TrA: {$_}" if $DEBUG;
        self."$_"() = %data{$_};
        %data{$_}:delete;
      }

      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "TrSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} );
        %data{$_}:delete;
      }

      when 'from' {
        say "Tr from = { %data<from>.value }" if $DEBUG;
        my $v = %data<from>;
        $v = gv_dbl($v) unless $v ~~ (GLib::Value, GValue).any;
        self.set-from-value($v);
        %data<from>:delete;
      }

      when 'to' {
        say "Tr to = { %data<to>.value }" if $DEBUG;
        my $v = %data<to>;
        $v = gv_dbl($v) unless $v ~~ (GLib::Value, GValue).any;
        self.set-to-value($v);
        %data<to>:delete;
      }
    }

    self.Clutter::Timeline::setup( |%data ) if %data.keys;
    self;
  }

  method animatable (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = clutter_transition_get_animatable($!ct);

        $a ??
          ( $raw ?? $a !! Clutter::Animatable.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterAnimatable() $animatable is copy) {
        clutter_transition_set_animatable($!ct, $animatable);
      }
    );
  }

  method interval (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $i = clutter_transition_get_interval($!ct);

        $i ??
          ( $raw ?? $i !! Clutter::Interval.new($i) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterInterval() $interval is copy) {
        clutter_transition_set_interval($!ct, $interval);
      }
    );
  }

  method remove_on_complete is rw is also<remove-on-complete> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_transition_get_remove_on_complete($!ct);
      },
      STORE => sub ($, Int() $remove_complete is copy) {
        my gboolean $rc = $remove_complete.so.Int;

        clutter_transition_set_remove_on_complete($!ct, $rc);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_transition_get_type, $n, $t );
  }

  method set_from_value (GValue() $value) is also<set-from-value> {
    clutter_transition_set_from_value($!ct, $value);
  }

  method set_to_value (GValue() $value) is also<set-to-value> {
    clutter_transition_set_to_value($!ct, $value);
  }

}
