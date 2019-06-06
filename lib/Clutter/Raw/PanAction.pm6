use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::PanAction;

sub clutter_pan_action_get_constrained_motion_delta (
  ClutterPanAction $self, 
  guint $point, 
  gfloat $delta_x, 
  gfloat $delta_y
)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_interpolated_coords (
  ClutterPanAction $self, 
  gfloat $interpolated_x, 
  gfloat $interpolated_y
)
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_interpolated_delta (
  ClutterPanAction $self, 
  gfloat $delta_x, 
  gfloat $delta_y
)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_motion_coords (
  ClutterPanAction $self, 
  guint $point, 
  gfloat $motion_x, 
  gfloat $motion_y
)
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_motion_delta (
  ClutterPanAction $self, 
  guint $point, 
  gfloat $delta_x, 
  gfloat $delta_y
)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_new ()
  returns ClutterAction
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_acceleration_factor (ClutterPanAction $self)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_deceleration (ClutterPanAction $self)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_interpolate (ClutterPanAction $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_get_pan_axis (ClutterPanAction $self)
  returns guint # ClutterPanAxis
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_set_acceleration_factor (
  ClutterPanAction $self, 
  gdouble $factor
)
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_set_deceleration (
  ClutterPanAction $self, 
  gdouble $rate
)
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_set_interpolate (
  ClutterPanAction $self, 
  gboolean $should_interpolate
)
  is native(clutter)
  is export
{ * }

sub clutter_pan_action_set_pan_axis (
  ClutterPanAction $self, 
  guint $axis # ClutterPanAxis $axis
)
  is native(clutter)
  is export
{ * }
