use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::GridLayout;

sub clutter_grid_layout_attach (
  ClutterGridLayout $layout,
  ClutterActor $child,
  gint $left,
  gint $top,
  gint $width,
  gint $height
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_attach_next_to (
  ClutterGridLayout $layout,
  ClutterActor $child,
  ClutterActor $sibling,
  guint $side,  # ClutterGridPosition $side,
  gint $width,
  gint $height
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_child_at (
  ClutterGridLayout $layout,
  gint $left,
  gint $top
)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_insert_column (
  ClutterGridLayout $layout,
  gint $position
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_insert_next_to (
  ClutterGridLayout $layout,
  ClutterActor $sibling,
  uint32 $side # ClutterGridPosition $side
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_insert_row (ClutterGridLayout $layout, gint $position)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_new ()
  returns ClutterGridLayout
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_column_homogeneous (ClutterGridLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_column_spacing (ClutterGridLayout $layout)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_orientation (ClutterGridLayout $layout)
  returns guint32 # ClutterOrientation
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_row_homogeneous (ClutterGridLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_get_row_spacing (ClutterGridLayout $layout)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_set_column_homogeneous (
  ClutterGridLayout $layout,
  gboolean $homogeneous
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_set_column_spacing (
  ClutterGridLayout $layout,
  guint $spacing
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_set_orientation (
  ClutterGridLayout $layout,
  guint $orientation # ClutterOrientation $orientation
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_set_row_homogeneous (
  ClutterGridLayout $layout,
  gboolean $homogeneous
)
  is native(clutter)
  is export
{ * }

sub clutter_grid_layout_set_row_spacing (
  ClutterGridLayout $layout,
  guint $spacing
)
  is native(clutter)
  is export
{ * }
