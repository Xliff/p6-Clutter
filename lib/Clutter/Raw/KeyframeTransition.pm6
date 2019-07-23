use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::KeyframeTransition;

sub clutter_keyframe_transition_clear (ClutterKeyframeTransition $transition)
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_get_key_frame (
  ClutterKeyframeTransition $transition, 
  guint $index, 
  gdouble $key, 
  guint32 $mode, # ClutterAnimationMode $mode, 
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_get_n_key_frames (
  ClutterKeyframeTransition $transition
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_new (Str $property_name)
  returns ClutterKeyframeTransition
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_set_key_frame (
  ClutterKeyframeTransition $transition, 
  guint $index, 
  gdouble $key, 
  guint32 $mode, # ClutterAnimationMode $mode, 
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_set_key_frames (
  ClutterKeyframeTransition $transition, 
  guint $n_key_frames, 
  CArray[gdouble] $key_frames
)
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_set_modes (
  ClutterKeyframeTransition $transition, 
  guint $n_modes, 
  CArray[guint32] $modes, # ClutterAnimationMode $modes
)
  is native(clutter)
  is export
{ * }

sub clutter_keyframe_transition_set_values (
  ClutterKeyframeTransition $transition, 
  guint $n_values, 
  GValue $values
)
  is native(clutter)
  is export
{ * }
