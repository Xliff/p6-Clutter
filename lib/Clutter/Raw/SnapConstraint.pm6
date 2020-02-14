use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::SnapConstraint;

sub clutter_snap_constraint_get_edges (
  ClutterSnapConstraint $constraint,
  guint $from_edge,  # ClutterSnapEdge $from_edge,
  guint $to_edge     # ClutterSnapEdge $to_edge
)
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_new (
  ClutterActor $source,
  guint $from_edge,  # ClutterSnapEdge $from_edge,
  guint $to_edge,    # ClutterSnapEdge $to_edge
  gfloat $offset
)
  returns ClutterSnapConstraint
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_set_edges (
  ClutterSnapConstraint $constraint,
  guint $from_edge,  # ClutterSnapEdge $from_edge,
  guint $to_edge     # ClutterSnapEdge $to_edge
)
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_get_offset (ClutterSnapConstraint $constraint)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_get_source (ClutterSnapConstraint $constraint)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_set_offset (
  ClutterSnapConstraint $constraint,
  gfloat $offset
)
  is native(clutter)
  is export
{ * }

sub clutter_snap_constraint_set_source (
  ClutterSnapConstraint $constraint, 
  ClutterActor $source
)
  is native(clutter)
  is export
{ * }
