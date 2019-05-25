use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::Point {
  has ClutterPoint $!cp;
  
  submethod BUILD (:$point) {
    $!cp = $point;
  }
  
  method Clutter::Raw::Types::ClutterPoint
    is also<ClutterPoint>
  { $!cp }
  
  method init (float $x, float $y) is also<new> {
    self.bless( point => clutter_point_init(Clutter::Point.alloc, $x, $y);
  }
  
  method alloc {
    clutter_point_alloc($!cp);
  }

  method copy {
    Clutter::Point.new( clutter_point_copy($!cp) );
  }

  multi method distance (ClutterPoint() $b, Num() $xdist, Num() $ydist) {
    Clutter::Point.distance($!cp, $b, $xdist, $ydist);
  }
  multi method distance (
    Clutter::Point:U:
    ClutterPoint $a, 
    ClutterPoint $b, 
    Num() $x_distance, 
    Num() $y_distance
  ) {
    my gfloat ($xd, $yd) = ($x_distance, $y_distance);
    clutter_point_distance($a, $b, $x_distance, $y_distance);
  }

  method equals (ClutterPoint $b) {
    clutter_point_equals($!cp, $b);
  }

  method free (Clutter::Point:U: ClutterPoint $f) { 
    clutter_point_free($f);
  }
  
  method !free {
    Clutter::Point.free($!cp);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_point_get_type, $n, $t );
  }
r
  method zero {
    Clutter::Point.zero($!cp);
  }
  multi method zero (Clutter::Point:U: ClutterPoint() $p) {
    clutter_point_zero($p);
  }
  
}

multi sub infix:<eqv> (CluterPoint $a, ClutterPoint $b) {
  so clutter_point_equals($a, $b);
}
