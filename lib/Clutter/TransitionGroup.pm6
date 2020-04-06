use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::TransitionGroup;

use Clutter::Transition;

our subset ClutterTransitionGroupAncestry is export of Mu
  where ClutterTransitionGroup | ClutterTransitionAncestry;

class Clutter::TransitionGroup is Clutter::Transition {
  has ClutterTransitionGroup $!ctg;

  method Clutter::Raw::Definitions::ClutterTransitionGroup
    is also<ClutterTransitionGroup>
  { $!ctg }

  submethod BUILD (:$transition-group) {
    given $transition-group {
      when ClutterTransitionGroupAncestry {
        my $to-parent;
        $!ctg = do {
          when ClutterTransitionGroup {
            $to-parent = cast(ClutterTransition, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterTransitionGroup, $_);
          }
        }
        self.setTransition($to-parent);
      }

      when Clutter::TransitionGroup {
      }

      default {
      }
    }
  }

  multi method new (ClutterTransitionGroupAncestry $transition-group) {
    $transition-group ?? self.bless(:$transition-group) !! Nil;
  }
  multi method new {
    my $transition-group = clutter_transition_group_new();

    $transition-group ?? self.bless(:$transition-group) !! Nil;
  }

  method setup (*%data) {
    self.Clutter::Transition::setup( |%data );
    self;
  }

  method add_transition (ClutterTransition() $transition)
    is also<add-transition>
  {
    clutter_transition_group_add_transition($!ctg, $transition);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &clutter_transition_group_get_type,
      $n,
      $t
    );
  }

  method remove_all is also<remove-all> {
    clutter_transition_group_remove_all($!ctg);
  }

  method remove_transition (ClutterTransition() $transition)
    is also<remove-transition>
  {
    clutter_transition_group_remove_transition($!ctg, $transition);
  }

}
