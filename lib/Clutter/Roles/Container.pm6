use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::Container;

use Clutter::ChildMeta;

use Clutter::Roles::Signals::Container;

role Clutter::Roles::Container {
  also does Clutter::Roles::Signals::Container;

  has ClutterContainer $!c;

  method Clutter::Raw::Definitions::ClutterContainer
    is also<Container>
  { $!c }

  method roleInit-ClutterContainer {
    my \i = findProperImplementor(self.^attributes);

    $!c = cast( ClutterContainer, i.get_value(self) );
  }

  method setContainer ($container is copy) {
    ##self.IS-PROTECTED;
    $container = cast(ClutterContainer, $container)
      unless $container ~~ ClutterContainer;
      
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
    self.connect-child-notify($!c);
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

  method emit_child_notify (ClutterActor() $child, GParamSpec() $pspec)
    is also<emit-child-notify>
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

  # cw: Not sure if we are dealing with GParamSpec or not.
  # method class_find_child_property (Str() $property_name) {
  #   clutter_container_class_find_child_property($!c, $property_name);
  # }
  #
  # method class_list_child_properties (Int() $n_properties) {
  #   my guint $np = resolve-uint($n_properties);
  #   clutter_container_class_list_child_properties($!c, $n_properties);
  # }

  # Here for completion, but the docs say:
  #   "Applications should not call this function"
  # ...for both of the following methods.
  #
  # method create_child_meta (ClutterActor() $actor)
  #   is also<create-child-meta>
  # {
  #   Clutter::ChildMeta.new( clutter_container_create_child_meta($!c, $actor) );
  # }
  #
  # method destroy_child_meta (ClutterActor() $actor)
  #   is also<destroy-child-meta>
  # {
  #   clutter_container_destroy_child_meta($!c, $actor);
  # }

  method find_child_by_name (Str() $child_name, :$raw = False)
    is also<find-child-by-name>
  {
    my $a = clutter_container_find_child_by_name($!c, $child_name);

    $a ??
      ( $raw ?? $a !! ::('Clutter::Actor').new($a) )
      !!
      Nil;
  }

  method get_child_meta (ClutterActor() $actor, :$raw = False)
    is also<get-child-meta>
  {
    my $cm = clutter_container_get_child_meta($!c, $actor);

    $cm ??
      ( $raw ?? $cm !! Clutter::ChildMeta.new($cm) )
      !!
      Nil;
  }

  method container_get_type is also<container-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_container_get_type, $n, $t);
  }

}
