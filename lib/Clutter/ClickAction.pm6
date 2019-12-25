use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::ClickAction;

use GLib::Value;
use Clutter::Action;

use Clutter::Roles::Signals::ClickAction;

class Clutter::ClickAction is Clutter::Action {
  also does Clutter::Roles::Signals::ClickAction;

  has ClutterClickAction $!cca;

  # Needs ancestry logic
  submethod BUILD (:$clickaction) {
    self.setAction( cast(ClutterAction, $!cca = $clickaction) );
  }

  method Clutter::Raw::Types::ClutterClickAction
    is also<ClutterClickAction>
  { $!cca }

  method new {
    self.bless( clickaction => clutter_click_action_new() );
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
    my ($px, $py) = (0, 0);
    samewith($px, $py);
  }
  multi method get_coords (Num() $press_x is rw, Num() $press_y is rw) {
    my gfloat ($px, $py) = ($press_x, $press_y);
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
