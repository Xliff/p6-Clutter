use v6.c;

use NativeCall;
use Method::Also;

use Clutter::Raw::Types;
use Clutter::Transition;

our subset ClutterPropertyTransitionAncestry of Mu
  where ClutterPropertyTransition | ClutterTransition;

class Clutter::PropertyTransition is Clutter::Transition {
  has ClutterPropertyTransition $!cpt;

  # REALLY needs ancestry logic!
  submethod BUILD (:$propertytransition) {
    given $propertytransition {
      when ClutterPropertyTransitionAncestry {
        self.setPropertyTransition($propertytransition);
      }

      when Clutter::PropertyTransition {
      }

      default {
      }
    }
  }

  method setPropertyTransition(ClutterPropertyTransitionAncestry $_) {
    my $to-parent;
    $!cpt = do {
      when ClutterPropertyTransition {
        $to-parent = cast(ClutterTransition, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterPropertyTransition, $_);
      }
    };
    self.setTransition($to-parent);
  }

  method setup (*%data) {
    given %data.keys {
      when 'property-name' | 'property_name' {
        say 'property-name';
        self.property-name = %data{$_};
        %data{$_}:delete;
      }
    }

    self.Clutter::Transition::setup( |%data ) if %data.keys;
    self;
  }

  method Clutter::Raw::Definitions::ClutterPropertyTransition
    is also<ClutterPropertyTransition>
  { $!cpt }

  multi method new (ClutterPropertyTransitionAncestry $propertytransition) {
    $propertytransition ?? self.bless($propertytransition) !! Nil;
  }
  multi method new (Str() $property_name) {
    my $propertytransition = clutter_property_transition_new($property_name);

    $propertytransition ?? self.bless($propertytransition) !! Nil;
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
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &clutter_property_transition_get_type,
      $n,
      $t
    );
  }

}

sub clutter_property_transition_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_property_transition_new (Str $property_name)
  returns ClutterPropertyTransition
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
