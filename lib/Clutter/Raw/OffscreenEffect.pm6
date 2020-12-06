use v6.c;

use NativeCall;

use Clutter::Raw::Types;

unit package Clutter::Raw::OffscreenEffect;

sub clutter_offscreen_effect_create_texture (
  ClutterOffscreenEffect $effect,
  gfloat $width,
  gfloat $height
)
  returns CoglHandle
  is native(clutter)
  is export
{ * }

sub clutter_offscreen_effect_get_target (ClutterOffscreenEffect $effect)
  returns CoglMaterial
  is native(clutter)
  is export
{ * }

sub clutter_offscreen_effect_get_target_rect (
  ClutterOffscreenEffect $effect,
  ClutterRect $rect
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_offscreen_effect_get_texture (ClutterOffscreenEffect $effect)
  returns CoglHandle
  is native(clutter)
  is export
{ * }

sub clutter_offscreen_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_offscreen_effect_paint_target (ClutterOffscreenEffect $effect)
  is native(clutter)
  is export
{ * }
