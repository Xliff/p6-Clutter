use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::GestureAction;

use Clutter::Action;

class Clutter::GestureAction is Clutter::Action {
  has ClutterGestureAction $!cga;
  
  # Needs ancestry logic
  submethod BUILD (:$gestureaction) {
    self.setGestureAction($gestureaction);
  }
  
  method setGestureAction(ClutterGestureAction $action) {
    self.IS-PROTECTED;
    self.setAction( cast(ClutterAction, $!cga = $gestureaction) );
  }
  
  method Clutter::Raw::Types::ClutterGestureAction
  { $!cga }
  
  method new {
    self.bless( gestureaction => clutter_gesture_action_new() );
  }
  
  method n_touch_points is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_gesture_action_get_n_touch_points($!cga);
      },
      STORE => sub ($, Int() $nb_points is copy) {
        my gint $nb = resolve-int($nb_points);
        clutter_gesture_action_set_n_touch_points($!cga, $nb);
      }
    );
  }

  method threshold_trigger_edge is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterGestureTriggerEdge(
          clutter_gesture_action_get_threshold_trigger_edge($!cga)
        );
      },
      STORE => sub ($, Int() $edge is copy) {
        my guint $e = resolve-uint($edge);
        clutter_gesture_action_set_threshold_trigger_edge($!cga, $e);
      }
    );
  }
  
  method cancel {
    clutter_gesture_action_cancel($!cga);
  }

  method get_device (guint $point) {
    my guint $p = resolve-uint($point);
    clutter_gesture_action_get_device($!cga, $p);
  }

  method get_last_event (guint $point) {
    my guint $p = resolve-uint($point);
    clutter_gesture_action_get_last_event($!cga, $p);
  }
  
  proto method get_motion_coords (|)
  { * }

  multi method get_motion_coords (Int() $p) {
    my ($mx, $my) = (0, 0);
    samewith($p, $mx, $my);
  }
  multi method get_motion_coords (
    Int() $point, 
    Num() $motion_x is rw, 
    Num() $motion_y is rw
  ) {  
    my gint $p = resolve-uint($point);
    my gfloat ($mx, $my) = ($motion_x, $motion_y);
    clutter_gesture_action_get_motion_coords($!cga, $p, $mx, $my);
    ($motion_x, $motion_y) = ($mx, $my);
  }

  proto method get_motion_delta (|)
  { * }
  
  multi method get_motion_delta (Int() $p) {
    my ($dx, $dy) = (0, 0);
    samewith($p, $dx, $dy);
  }  
  multi method get_motion_delta (
    Int() $point, 
    Num() $delta_x is rw, 
    Num() $delta_y is rw
  ) {
    my gint $p = resolve-uint($point);
    my gfloat ($dx, $dy) = ($delta_x, $delta_y);
    clutter_gesture_action_get_motion_delta($!cga, $p, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  method get_n_current_points {
    clutter_gesture_action_get_n_current_points($!cga);
  }

  proto method get_press_coords (|)
  { * }

  multi method get_press_coords (Int() $p) {
    my ($px, $py) = (0, 0);
    samewith($p, $px, $py);
  }
  multi method get_press_coords (
    Int() $point, 
    Num() $press_x is rw, 
    Num() $press_y is rw
  ) {
    my gint $p = resolve-uint($point);
    my gfloat ($px, $py) = ($press_x, $press_y);
    clutter_gesture_action_get_press_coords($!cga, $p, $px, $py);
    ($press_x, $press_y) = ($px, $py);
  }

  proto method get_release_coords (|)
  { * }
  
  multi method get_release_coords (Int() $p) {
    my ($rx, $ry) = (0, 0);
    samewith($p, $rx, $ry);
  }
  multi method get_release_coords (
    Int() $point, 
    Num() $release_x, 
    Num() $release_y
  ) {
    my gint $p = resolve-uint($point);
    my gfloat ($rx, $ry) = ($release_x, $release_y);
    clutter_gesture_action_get_release_coords($!cga, $p, $rx, $ry);
    ($release_x, $release_y) = ($rx, $ry);
  }

  method get_sequence (Int() $point) {
    my gint $p = resolve-uint($point);
    clutter_gesture_action_get_sequence($!cga, $p);
  }

  proto method get_threshold_trigger_distance (|)
  { * }
  
  multi method get_threshold_trigger_distance {
    my ($x, $y) = (0, 0);
    samewith($x, $y);
  }
  multi method get_threshold_trigger_distance (
    Num() $x is rw, 
    Num() $y is rw
  ) {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_gesture_action_get_threshold_trigger_distance($!cga, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_gesture_action_get_type, $n, $t );
  }

  proto method get_velocity (|) 
  { * }
  
  multi method get_velocity (Int() $p) {
    my ($vx, $vy) = (0, 0);
    samewith($p, $vx, $vy);
  }
  multi method get_velocity (
    Int() $point, 
    Num() $velocity_x, 
    Num() $velocity_y
  ) {
    my gint $p = resolve-uint($point);
    my gfloat ($vx, $vy) = ($velocity_x, $velocity_y);
    clutter_gesture_action_get_velocity($!cga, $point, $vx, $vy);
    ($velocity_x, $velocity_y) = ($vx, $vy);
  }

  method set_threshold_trigger_distance (Num() $x, Num() $y) {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_gesture_action_set_threshold_trigger_distance($!cga, $xx, $yy);
  }

}
