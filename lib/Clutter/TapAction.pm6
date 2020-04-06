use v6.c;

use NativeCall;

use Clutter::Raw::Types;

use Clutter::GestureAction;

use Clutter::Roles::Signals::Generic;

our subset ClutterTapActionAncestry is export of Mu
  where ClutterTapAction | ClutterGestureActionAncestry;

class Clutter::TapAction is Clutter::GestureAction {
  also does Clutter::Roles::Signals::Generic;

  has ClutterTapAction $!cta;

  submethod BUILD (:$tapaction) {
    given $tapaction {
      when ClutterTapActionAncestry {
        my $to-parent;
        $!cta = do {
          when ClutterTapAction {
            $to-parent = cast(ClutterGestureAction, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterTapAction, $_);
          }
        }
        self.setGestureAction($to-parent);
      }

      when Clutter::TapAction {
      }

      default {
      }
    }
  }

  multi method new (ClutterTapActionAncestry $tapaction) {
    $tapaction ?? self.bless(:$tapaction) !! Nil;
  }
  multi method new {
    my $tapaction = clutter_tap_action_new();

    $tapaction ?? self.bless(:$tapaction) !! Nil;
  }

  # Is originally:
  # ClutterTapAction, ClutterActor, gpointer --> void
  method tap {
    self.connect-actor($!cta, 'tap');
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_tap_action_get_type, $n, $t );
  }

}

sub clutter_tap_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_tap_action_new ()
  returns ClutterTapAction
  is native(clutter)
  is export
{ * }
