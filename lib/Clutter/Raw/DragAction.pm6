use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::DragAction;

sub clutter_drag_action_get_drag_area (
  ClutterDragAction $action,
  ClutterRect $drag_area
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_drag_threshold (
  ClutterDragAction $action,
  guint $x_threshold is rw,
  guint $y_threshold is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_motion_coords (
  ClutterDragAction $action,
  gfloat $motion_x is rw,
  gfloat $motion_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_press_coords (
  ClutterDragAction $action,
  gfloat $press_x is rw,
  gfloat $press_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_new ()
  returns ClutterDragAction
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_set_drag_area (
  ClutterDragAction $action,
  ClutterRect $drag_area
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_set_drag_threshold (
  ClutterDragAction $action,
  gint $x_threshold,
  gint $y_threshold
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_drag_axis (ClutterDragAction $action)
  returns guint # ClutterDragAxis
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_get_drag_handle (ClutterDragAction $action)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_set_drag_axis (
  ClutterDragAction $action,
  guint $axis # ClutterDragAxis $axis
)
  is native(clutter)
  is export
{ * }

sub clutter_drag_action_set_drag_handle (
  ClutterDragAction $action,
  ClutterActor $handle
)
  is native(clutter)
  is export
{ * }
