use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::DragAction;

use Clutter::Action;
use Clutter::Actor;

class Clutter::DragAction is Clutter::Action {
  has ClutterDragAction $!cda;

  # Needs ancestry logic
  submethod BUILD (:$dragaction) {
    self.setAction( cast(ClutterAction, $!cda = $dragaction) );
  }

  method Clutter::Raw::Types::ClutterDragAction
    is also<ClutterDragAction>
  { $!cda }

  method new {
    self.bless( dragaction => clutter_drag_action_new() );
  }

  method drag_axis is rw is also<drag-axis> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterDragAxis( clutter_drag_action_get_drag_axis($!cda) );
      },
      STORE => sub ($, Int() $axis is copy) {
        my guint $a = resolve-uint($axis);
        clutter_drag_action_set_drag_axis($!cda, $a);
      }
    );
  }

  method drag_handle is rw is also<drag-handle> {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Actor.new( clutter_drag_action_get_drag_handle($!cda) );
      },
      STORE => sub ($, ClutterActor() $handle is copy) {
        clutter_drag_action_set_drag_handle($!cda, $handle);
      }
    );
  }

  method get_drag_area (ClutterRect() $drag_area) is also<get-drag-area> {
    clutter_drag_action_get_drag_area($!cda, $drag_area);
  }

  # Move back to coercive if that ever gets fixed.
  proto method get_drag_threshold (|)
    is also<get-drag-threshold>
  { * }

  multi method get_drag_threshold {
    my ($xt, $yt) = (0, 0);
    samewith($xt, $yt);
  }
  multi method get_drag_threshold (
    $x_threshold is rw,
    $y_threshold is rw
  ) {
    for $x_threshold, $y_threshold {
      $_ .= Int if .^can('Int').elems;
    }
    my gint ($xt, $yt) = resolve-int($x_threshold, $y_threshold);
    clutter_drag_action_get_drag_threshold($!cda, $xy, $yt);
    ($x_threshold, $y_threshold) = ($xt, $yt);
  }

  proto method get_motion_coords (|)
    is also<get-motion-coords>
  { * }

  multi method get_motion_coords {
    my ($mx, $my) = (0, 0);
    samewith($mx, $my);
  }
  multi method get_motion_coords ($motion_x is rw, $motion_y is rw) {
    for $motion_x, $motion_y {
      $_ .= Num if .^can('Num').elems;
    }
    my gfloat ($mx, $my) = ($motion_x, $motion_y);
    clutter_drag_action_get_motion_coords($!cda, $mx, $my);
    ($motion_x, $motion_y) = ($mx, $my);
  }

  proto method get_press_coords (|)
    is also<get-press-coords>
  { * }

  multi method get_press_coords {
    my ($px, $py) = (0, 0);
    samewith($px, $py);
  }
  multi method get_press_coords ($press_x is rw, $press_y is rw) {
    my gfloat ($px, $py) = ($press_x, $press_y);
    clutter_drag_action_get_press_coords($!cda, $px, $py);
    ($press_x, $press_y) = ($px, $py)
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_drag_action_get_type, $n, $t );
  }

  method set_drag_area (ClutterRect() $drag_area) is also<set-drag-area> {
    clutter_drag_action_set_drag_area($!cda, $drag_area);
  }

  method set_drag_threshold (Int() $x_threshold, Int() $y_threshold)
    is also<set-drag-threshold>
  {
    my gint ($xt, $yt) = resolve-int($x_threshold, $y_threshold);
    clutter_drag_action_set_drag_threshold($!cda, $xt, $yt);
  }

}
