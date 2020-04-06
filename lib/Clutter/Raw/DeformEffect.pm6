use v6.c;

use NativeCall;


use Clutter::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::DeformEffect;

sub clutter_deform_effect_get_n_tiles (
  ClutterDeformEffect $effect,
  guint $x_tiles,
  guint $y_tiles
)
  is native(clutter)
  is export
{ * }

sub clutter_deform_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_deform_effect_invalidate (ClutterDeformEffect $effect)
  is native(clutter)
  is export
{ * }

sub clutter_deform_effect_set_n_tiles (
  ClutterDeformEffect $effect,
  guint $x_tiles,
  guint $y_tiles
)
  is native(clutter)
  is export
{ * }

sub clutter_deform_effect_get_back_material (ClutterDeformEffect $effect)
  returns CoglHandle
  is native(clutter)
  is export
{ * }

sub clutter_deform_effect_set_back_material (
  ClutterDeformEffect $effect,
  CoglHandle $material
)
  is native(clutter)
  is export
{ * }
