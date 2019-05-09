use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Container;

sub clutter_container_child_get_property (
  ClutterContainer $container,
  ClutterActor $child,
  Str $property,
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_container_child_notify (
  ClutterContainer $container,
  ClutterActor $child,
  GParamSpec $pspec
)
  is native(clutter)
  is export
{ * }

sub clutter_container_child_set_property (
  ClutterContainer $container,
  ClutterActor $child,
  Str $property,
  GValue $value
)
  is native(clutter)
  is export
{ * }

# No use of CLASS objects, yet...
# sub clutter_container_class_find_child_property (GObjectClass $klass, Str $property_name)
#   returns GParamSpec
#   is native(clutter)
#   is export
#   { * }
#
# sub clutter_container_class_list_child_properties (GObjectClass $klass, guint $n_properties)
#   returns CArray[GParamSpec]
#   is native(clutter)
#   is export
#   { * }

sub clutter_container_create_child_meta (
  ClutterContainer $container,
  ClutterActor $actor
)
  is native(clutter)
  is export
{ * }

sub clutter_container_destroy_child_meta (
  ClutterContainer $container,
  ClutterActor $actor
)
  is native(clutter)
  is export
{ * }

sub clutter_container_find_child_by_name (
  ClutterContainer $container,
  Str $child_name
)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_container_get_child_meta (
  ClutterContainer $container,
  ClutterActor $actor
)
  returns ClutterChildMeta
  is native(clutter)
  is export
{ * }

sub clutter_container_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }
