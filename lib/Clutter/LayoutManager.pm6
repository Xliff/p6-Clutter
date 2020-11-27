use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::LayoutManager;

use GLib::Object::ParamSpec;
use Clutter::LayoutMeta;
use Clutter::GridLayoutMeta;

use GLib::Roles::Object;

# Object

our subset ClutterLayoutManagerAncestry is export of Mu
  where ClutterLayoutManager | GObject;

class Clutter::LayoutManager {
  also does GLib::Roles::Object;

  has ClutterLayoutManager $!clm;

  submethod BUILD (:$manager) {
    #self.ADD-PREFIX('Clutter::');
    self.setLayoutManager($manager) if $manager.defined;
  }

  method setLayoutManager(ClutterLayoutManagerAncestry $_) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!clm = do {
      when ClutterLayoutManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterLayoutManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterLayoutManager
    is also<ClutterLayoutManager>
  { $!clm }

  method new (ClutterLayoutManagerAncestry $manager) {
    $manager ?? self.bless(:$manager) !! Nil;
  }

  # Is originally:
  # ClutterLayoutManager, gpointer --> void
  method layout-changed {
    self.connect($!clm, 'layout-changed');
  }

  method allocate (
    ClutterContainer() $container,
    ClutterActorBox() $allocation,
    Int() $flags
  ) {
    my ClutterAllocationFlags $f = $flags;

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

  method find_child_property (Str() $name, :$raw = False)
    is also<find-child-property>
  {
    my $ps = clutter_layout_manager_find_child_property($!clm, $name);

    $ps ??
      ( $raw ?? $ps !! GLib::Object::ParamSpec.new($ps) )
      !!
      Nil;
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

    $cm ?? ($raw ?? $cm
                 !! ($grid ?? Clutter::GridLayoutMeta.new($cm)
                           !! Clutter::LayoutMeta.new($cm) ) )
        !! Nil;
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height (
    ClutterContainer() $container,
    Num() $for_width,
  ) {
    samewith($container, $for_width, $, $);
  }
  multi method get_preferred_height (
    ClutterContainer() $container,
    Num() $for_width,
    $min_height_p is rw,
    $nat_height_p is rw
  ) {
    my gfloat ($fw, $mh, $nh) = ($for_width, 0e0, 0e0);

    clutter_layout_manager_get_preferred_height(
      $!clm,
      $container,
      $fw,
      $mh,
      $nh
    );
    ($min_height_p, $nat_height_p) = ($mh, $nh);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width (
    ClutterContainer() $container,
    Num() $for_height
  ) {
    samewith($container, $for_height, $, $);
  }
  multi method get_preferred_width (
    ClutterContainer() $container,
    Num() $for_height,
    $min_width_p is rw,
    $nat_width_p is rw
  ) {
    my gfloat ($fh, $mw, $nw) = ($for_height, 0e0, 0e0);

    clutter_layout_manager_get_preferred_width(
      $!clm,
      $container,
      $fh,
      $mw,
      $nw
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_layout_manager_get_type, $n, $t );
  }

  method emit_layout_changed is also<emit-layout-changed> {
    clutter_layout_manager_layout_changed($!clm);
  }

  method list_child_properties (Int() $n_pspecs, :$raw = False)
    is also<list-child-properties>
  {
    my guint $np = $n_pspecs;

    my $psa = CArrayToArray(
      GParamSpec,
      clutter_layout_manager_list_child_properties($!clm, $np)
    );

    $psa ??
      ( $raw ?? $psa !! $psa.map({ GLib::Object::ParamSpec.new($_) }) )
      !!
      Nil;
  }

  method set_container (ClutterContainer() $container)
    is also<set-container>
  {
    clutter_layout_manager_set_container($!clm, $container);
  }

}
