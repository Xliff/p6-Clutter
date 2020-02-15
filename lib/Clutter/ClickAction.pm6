use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::ClickAction;

use GLib::Value;
use Clutter::Action;

use Clutter::Roles::Signals::ClickAction;

our subset ClutterClickActionAncestry is export of Mu
  where ClutterClickAction | ClutterActionAncestry;

class Clutter::ClickAction is Clutter::Action {
  also does Clutter::Roles::Signals::ClickAction;

  has ClutterClickAction $!cca;

  submethod BUILD (:$clickaction) {
    my $to-parent;
    $!cca = do given $clickaction {
      when ClutterClickAction {
        $to-parent = cast(ClutterAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterClickAction, $_);
      }
    }
    self.setAction($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterClickAction
    is also<ClutterClickAction>
  { $!cca }

  multi method new (ClutterClickActionAncestry $clickaction) {
    $clickaction ?? self.bless(:$clickaction) !! Nil;
  }
  multi method new {
    my $clickaction = clutter_click_action_new();

    $clickaction ?? self.bless(:$clickaction) !! Nil;
  }

  # Type: gboolean
  method held is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('held', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'held' does not allow writing" if $DEBUG;
      }
    );
  }

  # Type: gint
  method long-press-duration is rw  is also<long_press_duration> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('long-press-duration', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('long-press-duration', $gv);
      }
    );
  }

  # Type: gint
  method long-press-threshold is rw  is also<long_press_threshold> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('long-press-threshold', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('long-press-threshold', $gv);
      }
    );
  }

  # Is originally:
  # ClutterClickAction, ClutterActor, gpointer --> void
  method clicked {
    self.connect-actor($!cca, 'clicked');
  }

  # Is originally:
  # ClutterClickAction, ClutterActor, ClutterLongPressState, gpointer --> gboolean
  method long-press is also<long_press> {
    self.connect-long-press($!cca);
  }

  # Type: gboolean
  method pressed is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('pressed', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'pressed' attribute does not allow writing" if $DEBUG;
      }
    );
  }

  method get_button
    is also<
      get-button
      button
    >
  {
    clutter_click_action_get_button($!cca);
  }

  proto method get_coords (|)
    is also<get-coords>
  { * }

  multi method get_coords is also<coords> {
    samewith($, $);
  }
  multi method get_coords ($press_x is rw, $press_y is rw) {
    my gfloat ($px, $py) = 0e0 xx 2;

    clutter_click_action_get_coords($!cca, $px, $py);
    ($press_x, $press_y) = ($px, $py);
  }

  method get_state
    is also<
      get-state
      state
    >
  {
    clutter_click_action_get_state($!cca);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_click_action_get_type, $n, $t );
  }

  method release {
    clutter_click_action_release($!cca);
  }

}
