use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::Rect {
  has ClutterRect $!cr;
  
  submethod BUILD (:$rect) {
    $!cr = $rect;
  }
  
  multi method new (ClutterRect $rect) {
    self.bless(:$rect);
  }
  multi method new (
    Num() $x, 
    Num() $y, 
    Num() $width, 
    Num() $height
  ) {
    my gfloat ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    self.init($xx, $yy, $w, $h);
  }
  
  multi method init (
    Num() $x, 
    Num() $y, 
    Num() $width, 
    Num() $height
  ) {
    self.bless( 
      rect => Clutter::Rect.init( Clutter::Rect.alloc, $x, $y, $width, $height )
    );
  }
  multi method init (
    Clutter::Rect:U:
    ClutterRect $r,
    Num() $x, 
    Num() $y, 
    Num() $width, 
    Num() $height
  ) {
    my gfloat ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    clutter_rect_init($r, $xx, $yy, $w, $h);
    $r;
  }
  
  method alloc (Clutter::Rect:U:) {
    clutter_rect_alloc();
  }

  method clamp_to_pixel is also<clamp-to-pixel> {
    clutter_rect_clamp_to_pixel($!cr);
  }

  method contains_point (ClutterPoint() $point) is also<contains-point> {
    clutter_rect_contains_point($!cr, $point);
  }

  method contains_rect (ClutterRect() $b) is also<contains-rect> {
    clutter_rect_contains_rect($!cr, $b);
  }

  method copy {
    Clutter::Rect.new( clutter_rect_copy($!cr) );
  }

  method equals (ClutterRect() $b) {
    clutter_rect_equals($!cr, $b);
  }

  method free {
    clutter_rect_free($!cr);
  }

  proto method get_center (|) 
    is also<get-center>
  { * }
  
  multi method get_center is also<center> {
    my $c = ClutterPoint.new; 
    Clutter::Point.new( Clutter::Rect.get_center($!cr, $c) );
  }
  multi method get_center (ClutterPoint $center) {
    clutter_rect_get_center($!cr, $center);
  }

  method get_height 
    is also<
      get-height
      height
    > 
  {
    clutter_rect_get_height($!cr);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_rect_get_type, $n, $t );
  }

  method get_width 
    is also<
      get-width
      width
    > 
  {
    clutter_rect_get_width($!cr);
  }

  method get_x 
    is also<
      get-x
      x
    > 
  {
    clutter_rect_get_x($!cr);
  }

  method get_y 
    is also<
      get-y
      y
    > 
  {
    clutter_rect_get_y($!cr);
  }

  method inset (Num() $d_x, Num() $d_y) {
    my gfloat ($dx, $dy) = ($d_x, $d_y);
    clutter_rect_inset($!cr, $d_x, $d_y);
  }

  multi method intersection (ClutterRect() $b) {
    my $r = ClutterRect.new;
    Clutter::Rect.new( Clutter::Rect.intersection($!cr, $b, $r) );
  }
  multi method intersection (
    Clutter::Rect:U:
    ClutterRect $a,
    ClutterRect $b,
    ClutterRect $res
  ) {
    clutter_rect_intersection($!cr, $b, $res);
    $res;
  }

  method normalize {
    clutter_rect_normalize($!cr);
  }

  method offset (Num() $d_x, Num() $d_y) {
    my gfloat ($dx, $dy) = ($d_x, $d_y);
    clutter_rect_offset($!cr, $d_x, $d_y);
  }

  multi method union (ClutterRect() $b) {
    my $r = ClutterRect.new;
    Clutter::Rect.new( Clutter::Rect.union($!cr, $b, $r) );
  }
  multi method union (
    Clutter::Rect:U:
    ClutterRect $a,
    ClutterRect $b, 
    ClutterRect $res
  ) {
    clutter_rect_union($a, $b, $res);
    $res;
  }

  method zero (Clutter::Rect:U:) {
    clutter_rect_zero();
  }
  
}
