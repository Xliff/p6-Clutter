use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::GestureAction;

sub clutter_gesture_action_get_device (
  ClutterGestureAction $action, 
  guint $point
)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_last_event (
  ClutterGestureAction $action, 
  guint $point
)
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_motion_coords (
  ClutterGestureAction $action, 
  guint $point, 
  gfloat $motion_x is rw, 
  gfloat $motion_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_motion_delta (
  ClutterGestureAction $action, 
  guint $point, 
  gfloat $delta_x is rw, 
  gfloat $delta_y is rw
)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_n_current_points (ClutterGestureAction $action)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_press_coords (
  ClutterGestureAction $action, 
  guint $point, 
  gfloat $press_x is rw, 
  gfloat $press_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_release_coords (
  ClutterGestureAction $action, 
  guint $point, 
  gfloat $release_x is rw, 
  gfloat $release_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_sequence (
  ClutterGestureAction $action, 
  guint $point
)
  returns ClutterEventSequence
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_threshold_trigger_distance (
  ClutterGestureAction $action, 
  gfloat $x is rw, 
  gfloat $y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_velocity (
  ClutterGestureAction $action, 
  guint $point, 
  gfloat $velocity_x is rw, 
  gfloat $velocity_y is rw
)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_new ()
  returns ClutterAction
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_set_threshold_trigger_distance (
  ClutterGestureAction $action, 
  gfloat $x, 
  gfloat $y
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_n_touch_points (ClutterGestureAction $action)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_get_threshold_trigger_edge (
  ClutterGestureAction $action
)
  returns guint ClutterGestureTriggerEdge
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_set_n_touch_points (
  ClutterGestureAction $action, 
  gint $nb_points
)
  is native(clutter)
  is export
{ * }

sub clutter_gesture_action_set_threshold_trigger_edge (
  ClutterGestureAction $action, 
  guint $edge # ClutterGestureTriggerEdge $edge
)
  is native(clutter)
  is export
{ * }
