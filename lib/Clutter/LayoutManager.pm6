use v6.c;

use Method::Also;


use GTK::Raw::Types;
use Clutter::Raw::Types;



use Clutter::Raw::LayoutManager;

use Clutter::LayoutMeta;
use Clutter::GridLayoutMeta;

use GTK::Roles::Properties;
use GTK::Roles::Protection;
use GTK::Roles::Signals::Generic;

# Object

class Clutter::LayoutManager {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Protection;
  also does GTK::Roles::Signals::Generic;
  
  has ClutterLayoutManager $!clm;
  
  submethod BUILD (:$manager) {
    self.ADD-PREFIX('Clutter::');
    self.setLayoutManager($manager) if $manager.defined;
  }
  
  method setLayoutManager($manager) {
    #self.IS-PROTECTED;
    self!setObject( cast(GObject, $!clm = $manager) ) if $manager;
  }
  
  method Clutter::Raw::Definitions::ClutterLayoutManager 
    is also<ClutterLayoutManager>
  { $!clm }
  
  method new (ClutterLayoutManager $manager) {
    self.bless(:$manager);
  }
  
  # Is originally:
  # ClutterLayoutManager, gpointer --> void
  method layout-changed {
    self.connect($!clm, 'layout-changed');
  }
  
  method allocate (
    ClutterContainer $container, 
    ClutterActorBox $allocation, 
    Int() $flags # ClutterAllocationFlags $flags
  ) {
    my guint $f = resolve-uint($flags);
    clutter_layout_manager_allocate($!clm, $container, $allocation, $f);
  }

  method child_get_property (
    ClutterContainer() $container, 
    ClutterActor() $actor, 
    Str() $property_name, 
    GValue() $value
  ) 
    is also<child-get-property> 
  {
    clutter_layout_manager_child_get_property(
      $!clm, 
      $container, 
      $actor, 
      $property_name, 
      $value
    );
  }

  method child_set_property (
    ClutterContainer() $container, 
    ClutterActor() $actor, 
    Str() $property_name, 
    GValue() $value
  ) 
    is also<child-set-property> 
  {
    clutter_layout_manager_child_set_property(
      $!clm, 
      $container, 
      $actor, 
      $property_name, 
      $value
    );  
  }

  method find_child_property (Str() $name) is also<find-child-property> {
    clutter_layout_manager_find_child_property($!clm, $name);
  }

  method get_child_meta (
    ClutterContainer() $container, 
    ClutterActor() $actor,
    :$raw,
    :$grid,
  ) 
    is also<get-child-meta> 
  {
    my $cm = clutter_layout_manager_get_child_meta($!clm, $container, $actor);
    $raw ?? $cm !! $grid ?? 
      Clutter::GridLayoutMeta.new($cm) !!
      Clutter::LayoutMeta.new($cm);
  }

  method get_preferred_height (
    ClutterContainer() $container, 
    Num() $for_width, 
    Num() $min_height_p, 
    Num() $nat_height_p
  ) 
    is also<get-preferred-height> 
  {
    my gfloat ($fw, $mh, $nh) = ($for_width, $min_height_p, $nat_height_p);
    clutter_layout_manager_get_preferred_height(
      $!clm, $container, $fw, $mh, $nh
    );
  }

  method get_preferred_width (
    ClutterContainer() $container, 
    gfloat $for_height, 
    gfloat $min_width_p, 
    gfloat $nat_width_p
  ) 
    is also<get-preferred-width> 
  {
    my gfloat ($fh, $mw, $nw) = ($for_height, $min_width_p, $nat_width_p);
    clutter_layout_manager_get_preferred_width(
      $!clm, $container, $fh, $mw, $nw
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_layout_manager_get_type, $n, $t );
  }

  method emit_layout_changed is also<emit-layout-changed> {
    clutter_layout_manager_layout_changed($!clm);
  }

  method list_child_properties (guint $n_pspecs) 
    is also<list-child-properties> 
  {
    my guint $np = resolve-int($n_pspecs);
    clutter_layout_manager_list_child_properties($!clm, $np);
  }

  method set_container (ClutterContainer() $container) 
    is also<set-container> 
  {
    clutter_layout_manager_set_container($!clm, $container);
  }
  
}
