use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Animatable;

sub clutter_animatable_find_property (
  ClutterAnimatable $animatable,
  Str $property_name
)
  returns GParamSpec
  is native(clutter)
  is export
  { * }

sub clutter_animatable_get_initial_state (
  ClutterAnimatable $animatable,
  Str $property_name,
  GValue $value
)
  is native(clutter)
  is export
  { * }

sub clutter_animatable_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_animatable_interpolate_value (
  ClutterAnimatable $animatable,
  Str $property_name,
  ClutterInterval $interval,
  gdouble $progress,
  GValue $value
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_animatable_set_final_state (ClutterAnimatable $animatable, Str $property_name, GValue $value)
  is native(clutter)
  is export
  { * }
