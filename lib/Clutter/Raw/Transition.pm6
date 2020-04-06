use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::Transition;

sub clutter_transition_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_transition_set_from_value (
  ClutterTransition $transition,
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_transition_set_to_value (
  ClutterTransition $transition,
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_transition_get_animatable (ClutterTransition $transition)
  returns ClutterAnimatable
  is native(clutter)
  is export
{ * }

sub clutter_transition_get_interval (ClutterTransition $transition)
  returns ClutterInterval
  is native(clutter)
  is export
{ * }

sub clutter_transition_get_remove_on_complete (ClutterTransition $transition)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_transition_set_animatable (
  ClutterTransition $transition,
  ClutterAnimatable $animatable
)
  is native(clutter)
  is export
{ * }

sub clutter_transition_set_interval (
  ClutterTransition $transition,
  ClutterInterval $interval
)
  is native(clutter)
  is export
{ * }

sub clutter_transition_set_remove_on_complete (
  ClutterTransition $transition,
  gboolean $remove_complete
)
  is native(clutter)
  is export
{ * }
