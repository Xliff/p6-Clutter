use v6.c;

use NativeCall;

use Clutter::Raw::Types;

unit package Clutter::Raw::TransitionGroup;

### /usr/include/clutter-1.0/clutter/clutter-transition-group.h

sub clutter_transition_group_add_transition (
  ClutterTransitionGroup $group,
  ClutterTransition $transition
)
  is native(clutter)
  is export
{ * }

sub clutter_transition_group_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_transition_group_new ()
  returns ClutterTransitionGroup
  is native(clutter)
  is export
{ * }

sub clutter_transition_group_remove_all (ClutterTransitionGroup $group)
  is native(clutter)
  is export
{ * }

sub clutter_transition_group_remove_transition (
  ClutterTransitionGroup $group,
  ClutterTransition $transition
)
  is native(clutter)
  is export
{ * }
