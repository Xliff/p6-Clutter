use v6.c;

use Method::Also;


use Clutter::Raw::Types;



use Clutter::Raw::GestureAction;

use Clutter::Action;

class Clutter::GestureAction is Clutter::Action {
  has ClutterGestureAction $!cga;
  
  # Needs ancestry logic
  submethod BUILD (:$gestureaction) {
    self.setGestureAction($gestureaction) if $gestureaction.defined;
  }
  
  method setGestureAction(ClutterGestureAction $action) {
    self.IS-PROTECTED;
    self.setAction( cast(ClutterAction, $!cga = $action) );
  }
  
  method Clutter::Raw::Definitions::ClutterGestureAction
    is also<ClutterGestureAction>
  { $!cga }
  
  multi method new (ClutterGestureAction $gestureaction) {
    self.bless(:$gestureaction);
  }
  multi method new {
    self.bless( gestureaction => clutter_gesture_action_new() );
  }
  
  method n_touch_points is rw is also<n-touch-points> {
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

  method threshold_trigger_edge is rw is also<threshold-trigger-edge> {
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

  method get_device (guint $point) is also<get-device> {
    my guint $p = resolve-uint($point);
    clutter_gesture_action_get_device($!cga, $p);
  }

  method get_last_event (guint $point) is also<get-last-event> {
    my guint $p = resolve-uint($point);
    clutter_gesture_action_get_last_event($!cga, $p);
  }
  
  proto method get_motion_coords (|)
    is also<get-motion-coords>
  { * }

  multi method get_motion_coords (Int() $p) {
    my ($mx, $my) = (0, 0);
    samewith($p, $mx, $my);
  }
  multi method get_motion_coords (
    Int() $point, 
    $motion_x is rw, 
    $motion_y is rw
  ) {
    die '$motion_x must be Num-compatible' unless $motion_x.^can('Num').elems;
    die '$motion_y must be Num-compatible' unless $motion_y.^can('Num').elems;
    $_ .= Num for $motion_x, $motion_y;
    my gint $p = resolve-uint($point);
    my gfloat ($mx, $my) = ($motion_x, $motion_y);
    clutter_gesture_action_get_motion_coords($!cga, $p, $mx, $my);
    ($motion_x, $motion_y) = ($mx, $my);
  }

  proto method get_motion_delta (|)
    is also<get-motion-delta>
  { * }
  
  multi method get_motion_delta (Int() $p) {
    my ($dx, $dy) = (0, 0);
    samewith($p, $dx, $dy);
  }  
  multi method get_motion_delta (
    Int() $point, 
    $delta_x is rw, 
    $delta_y is rw
  ) {
    die '$delta_x must be Num-compatible' unless $delta_x.^can('Num').elems;
    die '$delta_y must be Num-compatible' unless $delta_y.^can('Num').elems;
    $_ .= Num for $delta_x, $delta_y;
    my guint $p = resolve-uint($point);
    my gfloat ($dx, $dy) = ($delta_x, $delta_y);
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
    my ($px, $py) = (0, 0);
    samewith($p, $px, $py);
  }
  multi method get_press_coords (
    Int() $point, 
    $press_x is rw, 
    $press_y is rw
  ) {
    die '$press_x must be Num-compatible' unless $press_x.^can('Num').elems;
    die '$press_y must be Num-compatible' unless $press_y.^can('Num').elems;
    $_ .= Num for $press_x, $press_y;
    my gint $p = resolve-uint($point);
    my gfloat ($px, $py) = ($press_x, $press_y);
    clutter_gesture_action_get_press_coords($!cga, $p, $px, $py);
    ($press_x, $press_y) = ($px, $py);
  }

  proto method get_release_coords (|)
    is also<get-release-coords>
  { * }
  
  multi method get_release_coords (Int() $p) {
    my ($rx, $ry) = (0, 0);
    samewith($p, $rx, $ry);
  }
  multi method get_release_coords (
    Int() $point, 
    $release_x, 
    $release_y
  ) {
    die '$release_x must be Num-compatible' unless $release_x.^can('Num').elems;
    die '$release_y must be Num-compatible' unless $release_y.^can('Num').elems;
    $_ .= Num for $release_x, $release_y;
    my gint $p = resolve-uint($point);
    my gfloat ($rx, $ry) = ($release_x, $release_y);
    clutter_gesture_action_get_release_coords($!cga, $p, $rx, $ry);
    ($release_x, $release_y) = ($rx, $ry);
  }

  method get_sequence (Int() $point) is also<get-sequence> {
    my gint $p = resolve-uint($point);
    clutter_gesture_action_get_sequence($!cga, $p);
  }

  proto method get_threshold_trigger_distance (|)
    is also<get-threshold-trigger-distance>
  { * }
  
  multi method get_threshold_trigger_distance {
    my ($x, $y) = (0, 0);
    samewith($x, $y);
  }
  multi method get_threshold_trigger_distance (
    $x is rw, 
    $y is rw
  ) {
    die '$x must be Num-compatible' unless $x.^can('Num').elems;
    die '$y must be Num-compatible' unless $y.^can('Num').elems;
    $_ .= Num for $x, $y;
    my gfloat ($xx, $yy) = ($x, $y);
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
    my ($vx, $vy) = (0, 0);
    samewith($p, $vx, $vy);
  }
  multi method get_velocity (
    Int() $point, 
    $vel_x is rw, 
    $vel_y is rw
  ) {
    die '$vel_x must be Num-compatible' unless $vel_x.^can('Num').elems;
    die '$vel_y must be Num-compatible' unless $vel_y.^can('Num').elems;
    $_ .= Num for $vel_x, $vel_y;
    my gint $p = resolve-uint($point);
    my gfloat ($vx, $vy) = ($vel_x, $vel_y);
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
