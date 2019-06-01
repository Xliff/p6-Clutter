use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Transition;

class Clutter::PropertyTransition is Clutter::Transition {
  has ClutterPropertyTransition $!cpt;

  # REALLY needs ancestry logic!
  submethod BUILD (:$propertytransition) {
    self.setTransition( cast(ClutterTransition, $!cpt, $propertytransition) );
  }

  method new (Str() $property_name) {
    self.bless(
      propertytransition => clutter_property_transition_new($property_name)
    );
  }

  method property_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_property_transition_get_property_name($!cpt);
      },
      STORE => sub ($, Str() $property_name is copy) {
        clutter_property_transition_set_property_name($!cpt, $property_name);
      }
    );
  }

  method get_type is also<get-type> {
    clutter_property_transition_get_type();
  }

}

sub clutter_property_transition_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_property_transition_new (Str $property_name)
returns ClutterTransition
is native(clutter)
is export
{ * }

sub clutter_property_transition_get_property_name (
  ClutterPropertyTransition $transition
)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_property_transition_set_property_name (
  ClutterPropertyTransition $transition,
  Str $property_name
)
  is native(clutter)
  is export
{ * }
