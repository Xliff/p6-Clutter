use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Transition;

use GTK::Roles::Properties;
use GTK::Roles::Protection;

use Clutter::Timeline;

class Clutter::Transition is Clutter::Timeline {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Protection;

  has ClutterTransition $!ct;

  submethod BUILD (:$transition) {
    self.setTransition($transition) if $transition.defined;
  }

  method setTransition (ClutterTransition $transition) {
    self.IS-PROTECTED;
    self.setTimeline( cast(ClutterTimeline, $!ct = $transition) );
  }

  method Clutter::Raw::Types::ClutterTransition
    is also<ClutterTransition>
  { $!ct }

  method new (ClutterTransition $transition) {
    self.bless(:$transition);
  }

  method animatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Animatable.new( clutter_transition_get_animatable($!ct) );
      },
      STORE => sub ($, ClutterAnimatable() $animatable is copy) {
        clutter_transition_set_animatable($!ct, $animatable);
      }
    );
  }

  method interval is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Interval.new( clutter_transition_get_interval($!ct) );
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
        my gboolean $rc = resolve-bool($remove_complete);
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
