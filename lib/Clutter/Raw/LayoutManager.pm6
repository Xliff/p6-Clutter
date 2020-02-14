use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::LayoutManager;

sub clutter_layout_manager_allocate (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  ClutterActorBox $allocation, 
  guint $flags # ClutterAllocationFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_begin_animation (
  ClutterLayoutManager $manager, 
  guint $duration, 
  gulong $mode
)
  returns ClutterAlpha
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_child_get_property (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  ClutterActor $actor, 
  Str $property_name, 
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_child_set_property (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  ClutterActor $actor, 
  Str $property_name, 
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_end_animation (ClutterLayoutManager $manager)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_find_child_property (
  ClutterLayoutManager $manager, 
  Str $name
)
  returns GParamSpec
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_get_animation_progress (ClutterLayoutManager $manager)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_get_child_meta (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  ClutterActor $actor
)
  returns ClutterLayoutMeta
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_get_preferred_height (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  gfloat $for_width, 
  gfloat $min_height_p, 
  gfloat $nat_height_p
)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_get_preferred_width (
  ClutterLayoutManager $manager, 
  ClutterContainer $container, 
  gfloat $for_height, 
  gfloat $min_width_p, 
  gfloat $nat_width_p
)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_layout_changed (ClutterLayoutManager $manager)
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_list_child_properties (
  ClutterLayoutManager $manager, 
  guint $n_pspecs
)
  returns Pointer # Block of GParamSpec
  is native(clutter)
  is export
{ * }

sub clutter_layout_manager_set_container (
  ClutterLayoutManager $manager, 
  ClutterContainer $container
)
  is native(clutter)
  is export
{ * }
