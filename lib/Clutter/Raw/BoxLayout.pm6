use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::BoxLayout;

sub clutter_box_layout_get_alignment (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  guint $x_align, # ClutterBoxAlignment $x_align, 
  guint $y_align  # ClutterBoxAlignment $y_align
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_expand (
  ClutterBoxLayout $layout, 
  ClutterActor $actor
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_fill (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  gboolean $x_fill, 
  gboolean $y_fill
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_new ()
  returns ClutterLayoutManager
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_pack (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  gboolean $expand, 
  gboolean $x_fill, 
  gboolean $y_fill, 
  guint $x_align, # ClutterBoxAlignment $x_align, 
  guint $y_align  # ClutterBoxAlignment $y_align
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_alignment (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  guint $x_align, # ClutterBoxAlignment $x_align, 
  guint $y_align  # ClutterBoxAlignment $y_align
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_expand (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  gboolean $expand
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_fill (
  ClutterBoxLayout $layout, 
  ClutterActor $actor, 
  gboolean $x_fill, 
  gboolean $y_fill
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_easing_duration (ClutterBoxLayout $layout)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_easing_mode (ClutterBoxLayout $layout)
  returns gulong
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_homogeneous (ClutterBoxLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_orientation (ClutterBoxLayout $layout)
  returns guint # ClutterOrientation
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_pack_start (ClutterBoxLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_spacing (ClutterBoxLayout $layout)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_get_use_animations (ClutterBoxLayout $layout)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_easing_duration (
  ClutterBoxLayout $layout, 
  guint $msecs
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_easing_mode (
  ClutterBoxLayout $layout, 
  gulong $mode
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_homogeneous (
  ClutterBoxLayout $layout, 
  gboolean $homogeneous
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_orientation (
  ClutterBoxLayout $layout, 
  guint # ClutterOrientation $orientation
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_pack_start (
  ClutterBoxLayout $layout, 
  gboolean $pack_start
)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_spacing (ClutterBoxLayout $layout, guint $spacing)
  is native(clutter)
  is export
{ * }

sub clutter_box_layout_set_use_animations (
  ClutterBoxLayout $layout, 
  gboolean $animate
)
  is native(clutter)
  is export
{ * }
