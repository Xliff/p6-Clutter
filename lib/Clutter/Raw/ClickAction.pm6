use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::ClickAction;

sub clutter_click_action_get_button (ClutterClickAction $action)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_click_action_get_coords (
  ClutterClickAction $action,
  gfloat $press_x is rw,
  gfloat $press_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_click_action_get_state (ClutterClickAction $action)
  returns guint # ClutterModifierType
  is native(clutter)
  is export
{ * }

sub clutter_click_action_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_click_action_new ()
  returns ClutterClickAction
  is native(clutter)
  is export
{ * }

sub clutter_click_action_release (ClutterClickAction $action)
  is native(clutter)
  is export
{ * }
