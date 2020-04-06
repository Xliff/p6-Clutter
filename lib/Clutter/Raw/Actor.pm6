use v6.c;

use NativeCall;

use Clutter::Raw::Types;

unit package Clutter::Raw::Actor;

sub clutter_actor_add_child (ClutterActor $self, ClutterActor $child)
  is native(clutter)
  is export
{ * }

sub clutter_actor_add_transition (
  ClutterActor $self,
  Str $name,
  ClutterTransition $transition
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_allocate (
  ClutterActor $self,
  ClutterActorBox $box,
  uint32 $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_allocate_align_fill (
  ClutterActor $self,
  ClutterActorBox $box,
  gdouble $x_align,
  gdouble $y_align,
  gboolean $x_fill,
  gboolean $y_fill,
  uint32 $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_allocate_available_size (
  ClutterActor $self,
  gfloat $x,
  gfloat $y,
  gfloat $available_width,
  gfloat $available_height,
  uint32 $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_allocate_preferred_size (
  ClutterActor $self,
  uint32 $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_apply_relative_transform_to_point (
  ClutterActor $self,
  ClutterActor $ancestor,
  ClutterVertex $point,
  ClutterVertex $vertex
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_apply_transform_to_point (
  ClutterActor $self,
  ClutterVertex $point,
  ClutterVertex $vertex
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_bind_model (
  ClutterActor $self,
  GListModel $model,
  ClutterActorCreateChildFunc $create_child_func,
  gpointer $user_data,
  GDestroyNotify $notify
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_contains (ClutterActor $self, ClutterActor $descendant)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_continue_paint (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_create_pango_context (ClutterActor $self)
  returns PangoContext
  is native(clutter)
  is export
{ * }

sub clutter_actor_create_pango_layout (ClutterActor $self, Str $text)
  returns PangoLayout
  is native(clutter)
  is export
{ * }

sub clutter_actor_destroy (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_destroy_all_children (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_event (
  ClutterActor $actor,
  ClutterEvent $event,
  gboolean $capture
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_accessible (ClutterActor $self)
  returns AtkObject
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_allocation_box (
  ClutterActor $self,
  ClutterActorBox $box
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_background_color (
  ClutterActor $self,
  ClutterColor $color
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_child_at_index (
  ClutterActor $self,
  gint $index
)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_child_transform (
  ClutterActor $self,
  ClutterMatrix $transform
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_children (ClutterActor $self)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_clip (
  ClutterActor $self,
  gfloat $xoff   is rw,
  gfloat $yoff   is rw,
  gfloat $width  is rw,
  gfloat $height is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_clip_to_allocation (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_content (ClutterActor $self)
  returns ClutterContent
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_content_box (ClutterActor $self, ClutterActorBox $box)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_content_gravity (ClutterActor $self)
  returns uint32 # ClutterContentGravity
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_content_repeat (ClutterActor $self)
  returns guint # ClutterContentRepeat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_content_scaling_filters (
  ClutterActor $self,
  guint $min_filter, # ClutterScalingFilter $min_filter,
  guint $mag_filter  # ClutterScalingFilter $mag_filter
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_default_paint_volume (ClutterActor $self)
  returns ClutterPaintVolume
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_easing_delay (ClutterActor $self)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_easing_duration (ClutterActor $self)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_easing_mode (ClutterActor $self)
  returns uint32 # ClutterAnimationMode
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_first_child (ClutterActor $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_fixed_position_set (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_flags (ClutterActor $self)
  returns uint32 # ClutterActorFlags
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_height (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_last_child (ClutterActor $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_layout_manager (ClutterActor $self)
  returns ClutterLayoutManager
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_margin (ClutterActor $self, ClutterMargin $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_margin_bottom (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_margin_left (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_margin_right (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_margin_top (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_n_children (ClutterActor $self)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_name (ClutterActor $self)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_next_sibling (ClutterActor $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_offscreen_redirect (ClutterActor $self)
  returns guint # sClutterOffscreenRedirect
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_opacity (ClutterActor $self)
  returns guint8
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_opacity_override (ClutterActor $self)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_paint_box (ClutterActor $self, ClutterActorBox $box)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_paint_opacity (ClutterActor $self)
  returns guint8
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_paint_visibility (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_paint_volume (ClutterActor $self)
  returns ClutterPaintVolume
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_pango_context (ClutterActor $self)
  returns PangoContext
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_parent (ClutterActor $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_pivot_point (
  ClutterActor $self,
  gfloat $pivot_x is rw,
  gfloat $pivot_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_pivot_point_z (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_position (
  ClutterActor $self,
  gfloat $x is rw,
  gfloat $y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_preferred_height (
  ClutterActor $self,
  gfloat $for_width,
  gfloat $min_height_p     is rw,
  gfloat $natural_height_p is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_preferred_size (
  ClutterActor $self,
  gfloat $min_width_p      is rw,
  gfloat $min_height_p     is rw,
  gfloat $natural_width_p  is rw,
  gfloat $natural_height_p is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_preferred_width (
  ClutterActor $self,
  gfloat $for_height,
  gfloat $min_width_p     is rw,
  gfloat $natural_width_p is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_previous_sibling (ClutterActor $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_reactive (ClutterActor $actor)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_request_mode (ClutterActor $self)
  returns guint # ClutterRequestMode
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_rotation_angle (
  ClutterActor $self,
  guint $axis # ClutterRotateAxis $axis
)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_scale (
  ClutterActor $self,
  gdouble $scale_x is rw,
  gdouble $scale_y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_scale_z (ClutterActor $self)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_size (
  ClutterActor $self,
  gfloat $width  is rw,
  gfloat $height is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_stage (ClutterActor $actor)
  returns ClutterStage
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_text_direction (ClutterActor $self)
  returns guint # ClutterTextDirection
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_transform (
  ClutterActor $self,
  ClutterMatrix $transform
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_transformed_paint_volume (
  ClutterActor $self,
  ClutterActor $relative_to_ancestor
)
  returns ClutterPaintVolume
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_transformed_position (
  ClutterActor $self,
  gfloat $x is rw,
  gfloat $y is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_transformed_size (
  ClutterActor $self,
  gfloat $width  is rw,
  gfloat $height is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_transition (ClutterActor $self, Str $name)
  returns ClutterTransition
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_translation (
  ClutterActor $self,
  gfloat $translate_x is rw,
  gfloat $translate_y is rw,
  gfloat $translate_z is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_width (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_x (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_x_align (ClutterActor $self)
  returns guint # ClutterActorAlign
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_x_expand (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_y (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_y_align (ClutterActor $self)
  returns uint32 # ClutterActorAlign
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_y_expand (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_z_position (ClutterActor $self)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_actor_grab_key_focus (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_allocation (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_clip (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_key_focus (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_mapped_clones (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_overlaps (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_pointer (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_hide (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_insert_child_above (
  ClutterActor $self,
  ClutterActor $child,
  ClutterActor $sibling
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_insert_child_at_index (
  ClutterActor $self,
  ClutterActor $child,
  gint $index
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_insert_child_below (
  ClutterActor $self,
  ClutterActor $child,
  ClutterActor $sibling
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_in_clone_paint (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_mapped (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_realized (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_rotated (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_scaled (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_is_visible (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_destroy (ClutterActorIter $iter)
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_init (ClutterActorIter $iter, ClutterActor $root)
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_is_valid (ClutterActorIter $iter)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_next (
  ClutterActorIter $iter,
  CArray[Pointer[ClutterActor]] $child
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_prev (
  ClutterActorIter $iter,
  CArray[Pointer[ClutterActor]] $child
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_iter_remove (ClutterActorIter $iter)
  is native(clutter)
  is export
{ * }

sub clutter_actor_map (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_move_by (ClutterActor $self, gfloat $dx, gfloat $dy)
  is native(clutter)
  is export
{ * }

sub clutter_actor_needs_expand (
  ClutterActor $self,
  guint $orientation # ClutterOrientation $orientation
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_new ()
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_paint (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_queue_redraw (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_queue_redraw_with_clip (
  ClutterActor $self,
  cairo_rectangle_int_t $clip)
  is native(clutter)
  is export
{ * }

sub clutter_actor_queue_relayout (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_realize (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_all_children (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_all_transitions (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_child (ClutterActor $self, ClutterActor $child)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_clip (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_transition (ClutterActor $self, Str $name)
  is native(clutter)
  is export
{ * }

sub clutter_actor_replace_child (
  ClutterActor $self,
  ClutterActor $old_child,
  ClutterActor $new_child
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_restore_easing_state (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_save_easing_state (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_allocation (
  ClutterActor $self,
  ClutterActorBox $box,
  uint32 $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_background_color (
  ClutterActor $self,
  ClutterColor $color
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_child_above_sibling (
  ClutterActor $self,
  ClutterActor $child,
  ClutterActor $sibling
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_child_at_index (
  ClutterActor $self,
  ClutterActor $child,
  gint $index
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_child_below_sibling (
  ClutterActor $self,
  ClutterActor $child,
  ClutterActor $sibling
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_child_transform (
  ClutterActor $self,
  ClutterMatrix $transform
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_clip (
  ClutterActor $self,
  gfloat $xoff,
  gfloat $yoff,
  gfloat $width,
  gfloat $height
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_clip_to_allocation (
  ClutterActor $self,
  gboolean $clip_set
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_content (ClutterActor $self, ClutterContent $content)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_content_gravity (
  ClutterActor $self,
  uint32 $gravity # ClutterContentGravity $gravity
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_content_repeat (
  ClutterActor $self,
  uint32 $repeat # ClutterContentRepeat $repeat
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_content_scaling_filters (
  ClutterActor $self,
  guint $min_filter, # ClutterScalingFilter $min_filter,
  guint $mag_filter  # ClutterScalingFilter $mag_filter
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_easing_delay (ClutterActor $self, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_easing_duration (ClutterActor $self, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_easing_mode (
  ClutterActor $self,
  uint32 $mode # ClutterAnimationMode $mode
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_fixed_position_set (ClutterActor $self, gboolean $is_set)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_flags (
  ClutterActor $self,
  uint32 $flags # ClutterActorFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_height (ClutterActor $self, gfloat $height)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_layout_manager (
  ClutterActor $self,
  ClutterLayoutManager $manager
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_margin (ClutterActor $self, ClutterMargin $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_margin_bottom (ClutterActor $self, gfloat $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_margin_left (ClutterActor $self, gfloat $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_margin_right (ClutterActor $self, gfloat $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_margin_top (ClutterActor $self, gfloat $margin)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_name (ClutterActor $self, Str $name)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_offscreen_redirect (
  ClutterActor $self,
  guint $redirect # ClutterOffscreenRedirect $redirect
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_opacity (
  ClutterActor $self,
  guint8 $opacity
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_opacity_override (
  ClutterActor $self,
  gint $opacity
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_pivot_point (
  ClutterActor $self,
  gfloat $pivot_x,
  gfloat $pivot_y
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_pivot_point_z (ClutterActor $self, gfloat $pivot_z)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_position (ClutterActor $self, gfloat $x, gfloat $y)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_reactive (ClutterActor $actor, gboolean $reactive)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_request_mode (
  ClutterActor $self,
  uint32 # ClutterRequestMode $mode
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_rotation_angle (
  ClutterActor $self,
  uint32 $axis, # ClutterRotateAxis $axis,
  gdouble $angle
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_scale (
  ClutterActor $self,
  gdouble $scale_x,
  gdouble $scale_y
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_scale_z (ClutterActor $self, gdouble $scale_z)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_size (
  ClutterActor $self,
  gfloat $width,
  gfloat $height
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_text_direction (
  ClutterActor $self,
  uint32 $text_dir # ClutterTextDirection $text_dir
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_transform (ClutterActor $self, ClutterMatrix $transform)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_translation (
  ClutterActor $self,
  gfloat $translate_x,
  gfloat $translate_y,
  gfloat $translate_z
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_width (ClutterActor $self, gfloat $width)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_x (ClutterActor $self, gfloat $x)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_x_align (
  ClutterActor $self,
  uint32 $x_align # ClutterActorAlign $x_align
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_x_expand (ClutterActor $self, gboolean $expand)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_y (ClutterActor $self, gfloat $y)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_y_align (
  ClutterActor $self,
  uint32 # ClutterActorAlign $y_align
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_y_expand (ClutterActor $self, gboolean $expand)
  is native(clutter)
  is export
{ * }

sub clutter_actor_set_z_position (ClutterActor $self, gfloat $z_position)
  is native(clutter)
  is export
{ * }

sub clutter_actor_should_pick_paint (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_show (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_transform_stage_point (
  ClutterActor $self,
  gfloat $x,
  gfloat $y,
  gfloat $x_out is rw,
  gfloat $y_out is rw
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_unmap (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_unrealize (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_unset_flags (
  ClutterActor $self,
  uint32 $flags # ClutterActorFlags $flags
)
  is native(clutter)
  is export
{ * }

 # Action

 sub clutter_actor_add_action (ClutterActor $self, ClutterAction $action)
  is native(clutter)
  is export
{ * }

sub clutter_actor_add_action_with_name (
  ClutterActor $self,
  Str $name,
  ClutterAction $action
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_clear_actions (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_action (ClutterActor $self, Str $name)
  returns ClutterAction
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_actions (ClutterActor $self)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_actions (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_action (ClutterActor $self, ClutterAction $action)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_action_by_name (ClutterActor $self, Str $name)
  is native(clutter)
  is export
{ * }

# Constraint

sub clutter_actor_add_constraint (
  ClutterActor $self,
  ClutterConstraint $constraint
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_add_constraint_with_name (
  ClutterActor $self,
  Str $name,
  ClutterConstraint $constraint
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_clear_constraints (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_constraint (ClutterActor $self, Str $name)
  returns ClutterConstraint
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_constraints (ClutterActor $self)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_constraints (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_constraint (
  ClutterActor $self,
  ClutterConstraint $constraint
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_constraint_by_name (ClutterActor $self, Str $name)
  is native(clutter)
  is export
{ * }

# Effect

sub clutter_actor_add_effect (ClutterActor $self, ClutterEffect $effect)
  is native(clutter)
  is export
{ * }

sub clutter_actor_add_effect_with_name (
  ClutterActor $self,
  Str $name,
  ClutterEffect $effect
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_clear_effects (ClutterActor $self)
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_effect (ClutterActor $self, Str $name)
  returns ClutterEffect
  is native(clutter)
  is export
{ * }

sub clutter_actor_get_effects (ClutterActor $self)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_actor_has_effects (ClutterActor $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_effect (ClutterActor $self, ClutterEffect $effect)
  is native(clutter)
  is export
{ * }

sub clutter_actor_remove_effect_by_name (ClutterActor $self, Str $name)
  is native(clutter)
  is export
{ * }
