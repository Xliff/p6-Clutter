use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::GestureAction;

use Clutter::Action;

our subset ClutterGestureActionAncestry is export of Mu
  where ClutterGestureAction | ClutterActionAncestry;

class Clutter::GestureAction is Clutter::Action {
  has ClutterGestureAction $!cga;

  # Needs ancestry logic
  submethod BUILD (:$gestureaction) {
    self.setGestureAction($gestureaction) if $gestureaction;
  }

  method setGestureAction(ClutterGestureActionAncestry $_) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!cga = do {
      when ClutterGestureAction {
        $to-parent = cast(ClutterAction, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterGestureAction, $_);
      }
    }
    self.setAction($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterGestureAction
    is also<ClutterGestureAction>
  { $!cga }

  multi method new (ClutterGestureActionAncestry $gestureaction) {
    $gestureaction ?? self.bless(:$gestureaction) !! Nil;
  }
  multi method new {
    my $gestureaction = clutter_gesture_action_new();

    $gestureaction ?? self.bless(:$gestureaction) !! Nil;
  }

  method n_touch_points is rw is also<n-touch-points> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_gesture_action_get_n_touch_points($!cga);
      },
      STORE => sub ($, Int() $nb_points is copy) {
        my gint $nb = $nb_points;

        clutter_gesture_action_set_n_touch_points($!cga, $nb);
      }
    );
  }

  method threshold_trigger_edge is rw is also<threshold-trigger-edge> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterGestureTriggerEdgeEnum(
          clutter_gesture_action_get_threshold_trigger_edge($!cga)
        );
      },
      STORE => sub ($, Int() $edge is copy) {
        my guint $e = $edge;

        clutter_gesture_action_set_threshold_trigger_edge($!cga, $e);
      }
    );
  }

  method cancel {
    clutter_gesture_action_cancel($!cga);
  }

  method get_device (guint $point) is also<get-device> {
    my guint $p = $point;

    clutter_gesture_action_get_device($!cga, $p);
  }

  method get_last_event (guint $point) is also<get-last-event> {
    my guint $p = $point;

    clutter_gesture_action_get_last_event($!cga, $p);
  }

  proto method get_motion_coords (|)
    is also<get-motion-coords>
  { * }

  multi method get_motion_coords (Int() $p) {
    samewith($p, $, $);
  }
  multi method get_motion_coords (
    Int() $point,
    $motion_x is rw,
    $motion_y is rw
  ) {
    my gint $p = $point;
    my gfloat ($mx, $my) = 0e0 xx 2;

    clutter_gesture_action_get_motion_coords($!cga, $p, $mx, $my);
    ($motion_x, $motion_y) = ($mx, $my);
  }

  proto method get_motion_delta (|)
    is also<get-motion-delta>
  { * }

  multi method get_motion_delta (Int() $p) {
    samewith($p, $, $);
  }
  multi method get_motion_delta (
    Int() $point,
    $delta_x is rw,
    $delta_y is rw
  ) {
    my guint $p = $point;
    my gfloat ($dx, $dy) = 0e0 xx 2;

    clutter_gesture_action_get_motion_delta($!cga, $p, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  method get_n_current_points is also<get-n-current-points> {
    clutter_gesture_action_get_n_current_points($!cga);
  }

  proto method get_press_coords (|)
    is also<get-press-coords>
  { * }

  multi method get_press_coords (Int() $p) {
    samewith($p, $, $);
  }
  multi method get_press_coords (
    Int() $point,
    $press_x is rw,
    $press_y is rw
  ) {
    my gint $p = $point;
    my gfloat ($px, $py) = 0e0 xx 2;

    clutter_gesture_action_get_press_coords($!cga, $p, $px, $py);
    ($press_x, $press_y) = ($px, $py);
  }

  proto method get_release_coords (|)
    is also<get-release-coords>
  { * }

  multi method get_release_coords (Int() $p) {
    samewith($p, $, $);
  }
  multi method get_release_coords (
    Int() $point,
    $release_x,
    $release_y
  ) {
    my gint $p = $point;
    my gfloat ($rx, $ry) = 0e0 xx 2;

    clutter_gesture_action_get_release_coords($!cga, $p, $rx, $ry);
    ($release_x, $release_y) = ($rx, $ry);
  }

  method get_sequence (Int() $point) is also<get-sequence> {
    my gint $p = $point;

    clutter_gesture_action_get_sequence($!cga, $p);
  }

  proto method get_threshold_trigger_distance (|)
    is also<get-threshold-trigger-distance>
  { * }

  multi method get_threshold_trigger_distance {
    samewith($, $);
  }
  multi method get_threshold_trigger_distance (
    $x is rw,
    $y is rw
  ) {
    my gfloat ($xx, $yy) = 0e0 xx 2;

    clutter_gesture_action_get_threshold_trigger_distance($!cga, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_gesture_action_get_type, $n, $t );
  }

  proto method get_velocity (|)
    is also<get-velocity>
  { * }

  multi method get_velocity (Int() $p) {
    samewith($p, $, $);
  }
  multi method get_velocity (
    Int() $point,
    $vel_x is rw,
    $vel_y is rw
  ) {
    my gint $p = $point;
    my gfloat ($vx, $vy) = 0e0 xx 2;

    clutter_gesture_action_get_velocity($!cga, $point, $vx, $vy);
    ($vel_x, $vel_y) = ($vx, $vy);
  }

  method set_threshold_trigger_distance (Num() $x, Num() $y)
    is also<set-threshold-trigger-distance>
  {
    my gfloat ($xx, $yy) = ($x, $y);
    
    clutter_gesture_action_set_threshold_trigger_distance($!cga, $xx, $yy);
  }

}
