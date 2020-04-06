use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

# Abstract.
# GObject.

use Clutter::ActorMeta;

our subset ClutterActionAncestry is export of Mu
  where ClutterAction | ClutterActorMetaAncestry;

class Clutter::Action is Clutter::ActorMeta {
  has ClutterAction $!c-act is implementor;

  submethod BUILD (:$action) {
    self.setAction($action) if $action.defined;
  }

  method Clutter::Raw::Definitions::ClutterAction
    is also<ClutterAction>
  { $!c-act }

  method setAction(ClutterActionAncestry $_) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!c-act = do {
      when ClutterAction {
        $to-parent = cast(ClutterActorMeta, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterAction, $_);
      }
    }
    self.setActorMeta($to-parent);
  }

  method new (ClutterActionAncestry $action) {
    $action ?? self.bless(:$action) !! Nil;
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
