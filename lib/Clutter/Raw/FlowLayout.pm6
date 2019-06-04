use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::FlowLayout;

sub clutter_flow_layout_get_column_width (
  ClutterFlowLayout $layout,
  gfloat $min_width is rw,
  gfloat $max_width is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_row_height (
  ClutterFlowLayout $layout,
  gfloat $min_height is rw,
  gfloat $max_height is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_new (
  guint $orientation  # sClutterFlowOrientation $orientation
)
  returns ClutterFlowLayout
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_column_width (
  ClutterFlowLayout $layout,
  gfloat $min_width,
  gfloat $max_width
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_row_height (
  ClutterFlowLayout $layout,
  gfloat $min_height,
  gfloat $max_height
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_column_spacing (ClutterFlowLayout $layout)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_homogeneous (ClutterFlowLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_orientation (ClutterFlowLayout $layout)
  returns guint # ClutterFlowOrientation
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_row_spacing (ClutterFlowLayout $layout)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_get_snap_to_grid (ClutterFlowLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_column_spacing (
  ClutterFlowLayout $layout,
  gfloat $spacing
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_homogeneous (
  ClutterFlowLayout $layout,
  gboolean $homogeneous
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_orientation (
  ClutterFlowLayout $layout,
  guint $orientation # ClutterFlowOrientation $orientation
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_row_spacing (
  ClutterFlowLayout $layout,
  gfloat $spacing
)
  is native(clutter)
  is export
{ * }

sub clutter_flow_layout_set_snap_to_grid (
  ClutterFlowLayout $layout,
  gboolean $snap_to_grid
)
  is native(clutter)
  is export
{ * }
