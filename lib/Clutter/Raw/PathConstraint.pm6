use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::PathConstraint;

sub clutter_path_constraint_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_path_constraint_new (ClutterPath $path, gfloat $offset)
  returns ClutterConstraint
  is native(clutter)
  is export
{ * }

sub clutter_path_constraint_get_offset (ClutterPathConstraint $constraint)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_path_constraint_get_path (ClutterPathConstraint $constraint)
  returns ClutterPath
  is native(clutter)
  is export
{ * }

sub clutter_path_constraint_set_offset (
  ClutterPathConstraint $constraint, 
  gfloat $offset
)
  is native(clutter)
  is export
{ * }

sub clutter_path_constraint_set_path (
  ClutterPathConstraint $constraint, 
  ClutterPath $path
)
  is native(clutter)
  is export
{ * }
