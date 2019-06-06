use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

# Abstract.
# GObject.

use Clutter::ActorMeta;

our subset ActionAncestry is export of Mu
  where ClutterAction | MetaActorAncestry;

class Clutter::Action is Clutter::ActorMeta {
  has ClutterAction $!c-act;

  submethod BUILD (:$action) {
    self.setAction($action) if $action.defined;
  }

  method Clutter::Raw::Types::ClutterAction
    is also<ClutterAction>
  { $!c-act }
  
  method new (ClutterAction $action) {
    self.bless(:$action);
  }

  method setAction(ClutterAction $action) {
    self.IS-PROTECTED;
    self.setActorMeta( cast(ClutterActorMeta, $!c-act = $action) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_action_get_type, $n, $t );
  }
}

sub clutter_action_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
