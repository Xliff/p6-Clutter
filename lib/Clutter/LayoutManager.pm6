use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Types;

use Clutter::Raw::LayoutManager;

use Clutter::Alpha;
use Clutter::LayoutMeta;

# Object

class Clutter::LayoutManager {
  my ClutterLayoutManager $!clm;
  
  submethod BUILD (:$manager) {
    self!setObject( cast(GObject, $!clm = $manager) );
  }
  
  method Clutter::Raw::Types::ClutterLayoutManager 
    is also<ClutterLayoutManager>
  { $!clm }
  
  method new (ClutterLayoutManger $manager) {
    self.bless(:$manager);
  }
  
  method allocate (
    ClutterContainer $container, 
    ClutterActorBox $allocation, 
    Int() $flags # ClutterAllocationFlags $flags
  ) {
    my guint $f = resolve-uint($flags);
    clutter_layout_manager_allocate($!clm, $container, $allocation, $f);
  }

  method begin_animation (Int() $duration, Int() $mode) 
    is also<begin-animation> 
  {
    my guint $d = resolve-unit($duration);
    my gulong $m = resolve-ulong($mode);
   Clutter::Alpha.new( clutter_layout_manager_begin_animation($!clm, $d, $m) );
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

  method end_animation is also<end-animation> {
    clutter_layout_manager_end_animation($!clm);
  }

  method find_child_property (Str() $name) is also<find-child-property> {
    clutter_layout_manager_find_child_property($!clm, $name);
  }

  method get_animation_progress is also<get-animation-progress> {
    clutter_layout_manager_get_animation_progress($!clm);
  }

  method get_child_meta (
    ClutterContainer() $container, 
    ClutterActor() $actor
  ) 
    is also<get-child-meta> 
  {
    Clutter::LayoutMeta.new( 
      clutter_layout_manager_get_child_meta($!clm, $container, $actor)
    );
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

  method layout_changed is also<layout-changed> {
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
