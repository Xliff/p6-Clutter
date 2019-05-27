use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::GestureAction;

use Clutter::Action;

class Clutter::GestureAction is Clutter::Action {
  has ClutterGestureAction $!cga;
  
  # Needs ancestry logic
  submethod BUILD (:$gestureaction) {
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
      STORE => sub ($, $nb_points is copy) {
        clutter_gesture_action_set_n_touch_points($!cga, $nb_points);
      }
    );
  }

  method threshold_trigger_edge is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_gesture_action_get_threshold_trigger_edge($!cga);
      },
      STORE => sub ($, $edge is copy) {
        clutter_gesture_action_set_threshold_trigger_edge($!cga, $edge);
      }
    );
  }
  
  method cancel {
    clutter_gesture_action_cancel($!cga);
  }

  method get_device (guint $point) {
    clutter_gesture_action_get_device($!cga, $point);
  }

  method get_last_event (guint $point) {
    clutter_gesture_action_get_last_event($!cga, $point);
  }

  method get_motion_coords (guint $point, gfloat $motion_x, gfloat $motion_y) {
    clutter_gesture_action_get_motion_coords($!cga, $point, $motion_x, $motion_y);
  }

  method get_motion_delta (guint $point, gfloat $delta_x, gfloat $delta_y) {
    clutter_gesture_action_get_motion_delta($!cga, $point, $delta_x, $delta_y);
  }

  method get_n_current_points {
    clutter_gesture_action_get_n_current_points($!cga);
  }

  method get_press_coords (guint $point, gfloat $press_x, gfloat $press_y) {
    clutter_gesture_action_get_press_coords($!cga, $point, $press_x, $press_y);
  }

  method get_release_coords (guint $point, gfloat $release_x, gfloat $release_y) {
    clutter_gesture_action_get_release_coords($!cga, $point, $release_x, $release_y);
  }

  method get_sequence (guint $point) {
    clutter_gesture_action_get_sequence($!cga, $point);
  }

  method get_threshold_trigger_distance (gfloat $x, gfloat $y) {
    clutter_gesture_action_get_threshold_trigger_distance($!cga, $x, $y);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_gesture_action_get_type, $n, $t );
  }

  method get_velocity (guint $point, gfloat $velocity_x, gfloat $velocity_y) {
    clutter_gesture_action_get_velocity($!cga, $point, $velocity_x, $velocity_y);
  }

  method set_threshold_trigger_distance (gfloat $x, gfloat $y) {
    clutter_gesture_action_set_threshold_trigger_distance($!cga, $x, $y);
  }

}
