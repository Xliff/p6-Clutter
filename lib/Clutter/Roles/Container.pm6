use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Container;

use Clutter::Roles::Signals::Container;

role Clutter::Roles::Container {
  also does Clutter::Roles::Signals::Container;

  has ClutterContainer $!c;

  method setContainer ($container) {
    self.IS-PROTECTED;
    $!c = $container;
  }

  # Is originally:
  # ClutterContainer, ClutterActor, gpointer --> void
  method actor-added is also<actor_added> {
    self.connect-actor($!c, 'actor-added');
  }

  # Is originally:
  # ClutterContainer, ClutterActor, gpointer --> void
  method actor-removed is also<actor_removed> {
    self.connect-actor($!c, 'actor-removed');
  }

  # Is originally:
  # ClutterContainer, ClutterActor, GParamSpec, gpointer --> void
  method child-notify is also<child_notify> {
    self.connect-child-notify($!w);
  }

  method child_get_property (
    ClutterActor() $child,
    Str() $property,
    GValue() $value
  )
    is also<child-get-property>
  {
    clutter_container_child_get_property($!c, $child, $property, $value);
  }

  method child_notify (ClutterActor() $child, GParamSpec() $pspec)
    is also<child-notify>
  {
    clutter_container_child_notify($!c, $child, $pspec);
  }

  method child_set_property (
    ClutterActor() $child,
    Str() $property,
    GValue() $value
  )
    is also<child-set-property>
  {
    clutter_container_child_set_property($!c, $child, $property, $value);
  }

  # method class_find_child_property (Str() $property_name) {
  #   clutter_container_class_find_child_property($!c, $property_name);
  # }
  #
  # method class_list_child_properties (Int() $n_properties) {
  #   my guint $np = resolve-uint($n_properties);
  #   clutter_container_class_list_child_properties($!c, $n_properties);
  # }

  method create_child_meta (ClutterActor() $actor)
    is also<create-child-meta>
  {
    clutter_container_create_child_meta($!c, $actor);
  }

  method destroy_child_meta (ClutterActor() $actor)
    is also<destroy-child-meta>
  {
    clutter_container_destroy_child_meta($!c, $actor);
  }

  method find_child_by_name (Str() $child_name)
    is also<find-child-by-name>
  {
    clutter_container_find_child_by_name($!c, $child_name);
  }

  method get_child_meta (ClutterActor() $actor)
    is also<get-child-meta>
  {
    clutter_container_get_child_meta($!c, $actor);
  }

  method get_type is also<get-type> {
    state ($n, $t)
    unstable_get_type( self.^name, &clutter_container_get_type, $n, $t);
  }

}
