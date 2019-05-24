use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::VariousTypes;

sub clutter_actor_box_alloc ()
  returns ClutterActorBox
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_clamp_to_pixel (ClutterActorBox $box)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_contains (ClutterActorBox $box, gfloat $x, gfloat $y)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_copy (ClutterActorBox $box)
  returns ClutterActorBox
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_equal (ClutterActorBox $box_a, ClutterActorBox $box_b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_free (ClutterActorBox $box)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_area (ClutterActorBox $box)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_height (ClutterActorBox $box)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_origin (ClutterActorBox $box, gfloat $x, gfloat $y)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_size (
  ClutterActorBox $box, 
  gfloat $width, 
  gfloat $height
)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_width (ClutterActorBox $box)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_x (ClutterActorBox $box)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_get_y (ClutterActorBox $box)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_init (
  ClutterActorBox $box, 
  gfloat $x_1, 
  gfloat $y_1, 
  gfloat $x_2, 
  gfloat $y_2
)
  returns ClutterActorBox
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_init_rect (
  ClutterActorBox $box, 
  gfloat $x, 
  gfloat $y, 
  gfloat $width, 
  gfloat $height
)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_interpolate (
  ClutterActorBox $initial, 
  ClutterActorBox $final, 
  gdouble $progress, 
  ClutterActorBox $result
)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_new (gfloat $x_1, gfloat $y_1, gfloat $x_2, gfloat $y_2)
  returns ClutterActorBox
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_set_origin (ClutterActorBox $box, gfloat $x, gfloat $y)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_set_size (
  ClutterActorBox $box, 
  gfloat $width, 
  gfloat $height
)
  is native(clutter)
  is export
  { * }

sub clutter_actor_box_union (
  ClutterActorBox $a, 
  ClutterActorBox $b, 
  ClutterActorBox $result
)
  is native(clutter)
  is export
  { * }

sub clutter_geometry_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_geometry_intersects (
  ClutterGeometry $geometry0, 
  ClutterGeometry $geometry1
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_geometry_union (C
  lutterGeometry $geometry_a, 
  ClutterGeometry $geometry_b, 
  ClutterGeometry $result
)
  is native(clutter)
  is export
  { * }

sub clutter_interval_register_progress_func (
  GType $value_type, 
  ClutterProgressFunc $func
)
  is native(clutter)
  is export
  { * }

sub clutter_knot_copy (ClutterKnot $knot)
  returns ClutterKnot
  is native(clutter)
  is export
  { * }

sub clutter_knot_equal (ClutterKnot $knot_a, ClutterKnot $knot_b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_knot_free (ClutterKnot $knot)
  is native(clutter)
  is export
  { * }

sub clutter_knot_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_margin_copy (ClutterMargin $margin_)
  returns ClutterMargin
  is native(clutter)
  is export
  { * }

sub clutter_margin_free (ClutterMargin $margin_)
  is native(clutter)
  is export
  { * }

sub clutter_margin_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_margin_new ()
  returns ClutterMargin
  is native(clutter)
  is export
  { * }

sub clutter_matrix_alloc ()
  returns ClutterMatrix
  is native(clutter)
  is export
  { * }

sub clutter_matrix_free (ClutterMatrix $matrix)
  is native(clutter)
  is export
  { * }

sub clutter_matrix_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_matrix_init_from_matrix (ClutterMatrix $a, ClutterMatrix $b)
  returns ClutterMatrix
  is native(clutter)
  is export
  { * }

sub clutter_matrix_init_identity (ClutterMatrix $matrix)
  returns ClutterMatrix
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_copy (ClutterPaintVolume $pv)
  returns ClutterPaintVolume
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_free (ClutterPaintVolume $pv)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_get_depth (ClutterPaintVolume $pv)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_get_height (ClutterPaintVolume $pv)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_get_origin (
  ClutterPaintVolume $pv, 
  ClutterVertex $vertex
)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_get_width (ClutterPaintVolume $pv)
  returns gfloat
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_set_depth (ClutterPaintVolume $pv, gfloat $depth)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_set_from_allocation (
  ClutterPaintVolume $pv, 
  ClutterActor $actor
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_set_height (ClutterPaintVolume $pv, gfloat $height)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_set_origin (
  ClutterPaintVolume $pv, 
  ClutterVertex $origin
)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_set_width (ClutterPaintVolume $pv, gfloat $width)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_union (
  ClutterPaintVolume $pv, 
  ClutterPaintVolume $another_pv
)
  is native(clutter)
  is export
  { * }

sub clutter_paint_volume_union_box (
  ClutterPaintVolume $pv, 
  ClutterActorBox $box
)
  is native(clutter)
  is export
  { * }

sub clutter_path_node_copy (ClutterPathNode $node)
  returns ClutterPathNode
  is native(clutter)
  is export
  { * }

sub clutter_path_node_equal (
  ClutterPathNode $node_a, 
  ClutterPathNode $node_b
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_path_node_free (ClutterPathNode $node)
  is native(clutter)
  is export
  { * }

sub clutter_path_node_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_point_alloc ()
  returns ClutterPoint
  is native(clutter)
  is export
  { * }

sub clutter_point_copy (ClutterPoint $point)
  returns ClutterPoint
  is native(clutter)
  is export
  { * }

sub clutter_point_distance (
  ClutterPoint $a, 
  ClutterPoint $b, 
  gfloat $x_distance, 
  gfloat $y_distance
)
  returns float
  is native(clutter)
  is export
  { * }

sub clutter_point_equals (ClutterPoint $a, ClutterPoint $b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_point_free (ClutterPoint $point)
  is native(clutter)
  is export
  { * }

sub clutter_point_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_point_init (ClutterPoint $point, gfloat $x, gfloat $y)
  returns ClutterPoint
  is native(clutter)
  is export
  { * }

sub clutter_point_zero ()
  returns ClutterPoint
  is native(clutter)
  is export
  { * }

sub clutter_rect_alloc ()
  returns ClutterRect
  is native(clutter)
  is export
  { * }

sub clutter_rect_clamp_to_pixel (ClutterRect $rect)
  is native(clutter)
  is export
  { * }

sub clutter_rect_contains_point (ClutterRect $rect, ClutterPoint $point)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_rect_contains_rect (ClutterRect $a, ClutterRect $b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_rect_copy (ClutterRect $rect)
  returns ClutterRect
  is native(clutter)
  is export
  { * }

sub clutter_rect_equals (ClutterRect $a, ClutterRect $b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_rect_free (ClutterRect $rect)
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_center (ClutterRect $rect, ClutterPoint $center)
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_height (ClutterRect $rect)
  returns float
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_width (ClutterRect $rect)
  returns float
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_x (ClutterRect $rect)
  returns float
  is native(clutter)
  is export
  { * }

sub clutter_rect_get_y (ClutterRect $rect)
  returns float
  is native(clutter)
  is export
  { * }

sub clutter_rect_init (
  ClutterRect $rect, 
  gfloat $x, 
  gfloat $y, 
  gfloat $width, 
  gfloat $height
)
  returns ClutterRect
  is native(clutter)
  is export
  { * }

sub clutter_rect_inset (ClutterRect $rect, gfloat $d_x, gfloat $d_y)
  is native(clutter)
  is export
  { * }

sub clutter_rect_intersection (
  ClutterRect $a, 
  ClutterRect $b, 
  ClutterRect $res
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_rect_normalize (ClutterRect $rect)
  returns ClutterRect
  is native(clutter)
  is export
  { * }

sub clutter_rect_offset (ClutterRect $rect, gfloat $d_x, gfloat $d_y)
  is native(clutter)
  is export
  { * }

sub clutter_rect_union (ClutterRect $a, ClutterRect $b, ClutterRect $res)
  is native(clutter)
  is export
  { * }

sub clutter_rect_zero ()
  returns ClutterRect
  is native(clutter)
  is export
  { * }

sub clutter_size_alloc ()
  returns ClutterSize
  is native(clutter)
  is export
  { * }

sub clutter_size_copy (ClutterSize $size)
  returns ClutterSize
  is native(clutter)
  is export
  { * }

sub clutter_size_equals (ClutterSize $a, ClutterSize $b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_size_free (ClutterSize $size)
  is native(clutter)
  is export
  { * }

sub clutter_size_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_size_init (ClutterSize $size, gfloat $width, gfloat $height)
  returns ClutterSize
  is native(clutter)
  is export
  { * }

sub clutter_vertex_alloc ()
  returns ClutterVertex
  is native(clutter)
  is export
  { * }

sub clutter_vertex_copy (ClutterVertex $vertex)
  returns ClutterVertex
  is native(clutter)
  is export
  { * }

sub clutter_vertex_equal (ClutterVertex $vertex_a, ClutterVertex $vertex_b)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_vertex_free (ClutterVertex $vertex)
  is native(clutter)
  is export
  { * }

sub clutter_vertex_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_vertex_init (
  ClutterVertex $vertex, 
  gfloat $x, 
  gfloat $y, 
  gfloat $z
)
  returns ClutterVertex
  is native(clutter)
  is export
  { * }

sub clutter_vertex_new (gfloat $x, gfloat $y, gfloat $z)
  returns ClutterVertex
  is native(clutter)
  is export
  { * }
