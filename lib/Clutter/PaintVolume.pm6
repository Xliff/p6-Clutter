use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::PaintVolume {
  has ClutterPaintVolume $!cpv;
  
  submethod BUILD (:$paintvolume) {
    $!cpv = $paintvolume;
  }
  
  method Clutter::Raw::Types::PaintVolume
    is also<ClutterPaintVolume>
  { $!cpv }
  
  method copy {
    clutter_paint_volume_copy($!cpv);
  }

  method free {
    clutter_paint_volume_free($!cpv);
  }

  method get_depth is also<get-depth> {
    clutter_paint_volume_get_depth($!cpv);
  }

  method get_height is also<get-height> {
    clutter_paint_volume_get_height($!cpv);
  }

  method get_origin (ClutterVertex() $vertex) is also<get-origin> {
    clutter_paint_volume_get_origin($!cpv, $vertex);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_paint_volume_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    clutter_paint_volume_get_width($!cpv);
  }

  method set_depth (Num() $depth) is also<set-depth> {
    my gfloat $d = $depth;
    clutter_paint_volume_set_depth($!cpv, $d);
  }

  method set_from_allocation (ClutterActor() $actor) 
    is also<set-from-allocation> 
  {
    clutter_paint_volume_set_from_allocation($!cpv, $actor);
  }

  method set_height (Num() $height) is also<set-height> {
    my gfloat $h = $height;
    clutter_paint_volume_set_height($!cpv, $h);
  }

  method set_origin (ClutterVertex() $origin) is also<set-origin> {
    clutter_paint_volume_set_origin($!cpv, $origin);
  }

  method set_width (Num() $width) is also<set-width> {
    my gfloat $w = $width;
    clutter_paint_volume_set_width($!cpv, $w);
  }

  method union (ClutterPaintVolume() $another_pv) {
    clutter_paint_volume_union($!cpv, $another_pv);
  }

  method union_box (ClutterActorBox() $box) is also<union-box> {
    clutter_paint_volume_union_box($!cpv, $box);
  }

}
