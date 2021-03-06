use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use Clutter::Action;

use Clutter::Roles::Signals::DropAction;

our subset DropActionAncestry is export of Mu
  where ClutterDropAction | ClutterActionAncestry;

class Clutter::DropAction is Clutter::Action {
  also does Clutter::Roles::Signals::DropAction;

  has ClutterDropAction $!cda;

  submethod BUILD (:$dropaction) {
    my $to-parent;
    $!cda = do given $dropaction {
      when ClutterDropAction {
        $to-parent = cast(ClutterAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterDropAction, $_);
      }
    }
    self.setAction($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterDropAction
    is also<ClutterDropAction>
  { * }

  multi method new (DropActionAncestry $dropaction) {
    $dropaction ?? self.bless(:$dropaction) !! Nil;
  }
  multi method new {
    my $dropaction = clutter_drop_action_new();

    $dropaction ?? self.bless(:$dropaction) !! Nil;
  }

  # Is originally:
  # ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer --> gboolean
  method can-drop is also<can_drop> {
    self.connect-can-drop($!cda);
  }

  # Is originally:
  # ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer --> void
  method drop {
    self.connect-drop($!cda);
  }

  # Is originally:
  # ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer --> void
  method drop-cancel is also<drop_cancel> {
    self.connect-drop($!cda, 'drop-cancel');
  }

  # Is originally:
  # ClutterDropAction, ClutterActor, gpointer --> void
  method over-in is also<over_in> {
    self.connect-actor($!cda, 'over-in');
  }

  # Is originally:
  # ClutterDropAction, ClutterActor, gpointer --> void
  method over-out is also<over_out> {
    self.connect-actor($!cda, 'over-out');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_drop_action_get_type, $n, $t );
  }

}

sub clutter_drop_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_drop_action_new ()
  returns ClutterDropAction
  is native(clutter)
  is export
{ * }
