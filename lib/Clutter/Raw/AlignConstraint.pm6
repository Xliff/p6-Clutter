use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::AlignConstraint;

sub clutter_align_constraint_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_new (
  ClutterActor $source, 
  guint $axis, # ClutterAlignAxis $axis, 
  gfloat $factor
)
  returns ClutterAlignConstraint
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_get_align_axis (ClutterAlignConstraint $align)
  returns guint # ClutterAlignAxis
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_get_factor (ClutterAlignConstraint $align)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_get_source (ClutterAlignConstraint $align)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_set_align_axis (
  ClutterAlignConstraint $align, 
  guint $axis # ClutterAlignAxis $axis
)
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_set_factor (
  ClutterAlignConstraint $align, 
  gfloat $factor
)
  is native(clutter)
  is export
{ * }

sub clutter_align_constraint_set_source (
  ClutterAlignConstraint $align, 
  ClutterActor $source
)
  is native(clutter)
  is export
{ * }
