use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::BindConstraint;

sub clutter_bind_constraint_get_coordinate (ClutterBindConstraint $constraint)
  returns guint # ClutterBindCoordinate
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_get_offset (ClutterBindConstraint $constraint)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_get_source (ClutterBindConstraint $constraint)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_new (
  ClutterActor $source, 
  guint $coordinate, # ClutterBindCoordinate $coordinate
  gfloat $offset
)
  returns ClutterBindConstraint
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_set_coordinate (
  guint $constraint, # ClutterBindConstraint $constraint, 
  guint $coordinate, # ClutterBindCoordinate $coordinate
)
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_set_offset (
  ClutterBindConstraint $constraint, 
  gfloat $offset
)
  is native(clutter)
  is export
{ * }

sub clutter_bind_constraint_set_source (
  ClutterBindConstraint $constraint, 
  ClutterActor $source
)
  is native(clutter)
  is export
{ * }
