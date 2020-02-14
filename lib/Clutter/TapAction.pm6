use v6.c;

use NativeCall;


use Clutter::Raw::Types;

use Clutter::GestureAction;

use Clutter::Roles::Signals::Generic;

class Clutter::TapAction is Clutter::GestureAction {
  also does Clutter::Roles::Signals::Generic;
  
  has ClutterTapAction $!cta;
  
  submethod BUILD (:$tapaction) {
    self.setGestureAction( 
      cast(ClutterGestureAction, $!cta = $tapaction)
    )
  }
  
  method new {
    self.bless( tapaction => clutter_tap_action_new() );
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

  
