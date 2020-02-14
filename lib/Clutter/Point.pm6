use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::Point {
  has ClutterPoint $!cp handles<x y>;

  my $zero = clutter_point_zero();

  submethod BUILD (:$point) {
    $!cp = $point;
  }

  method Clutter::Raw::Types::ClutterPoint
    is also<ClutterPoint>
  { $!cp }

  multi method new (Num() $x = 0, Num() $y = 0) is also<init> {
    my gfloat ($xx, $yy) = ($x, $y);
    self.bless( point => clutter_point_init(Clutter::Point.alloc, $xx, $yy) );
  }

  method alloc {
    clutter_point_alloc();
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
    die 'Cannot free the <zero> point. It is owned by libclutter.'
      if $f =:= $zero;
    clutter_point_free($f);
  }

  method !free {
    Clutter::Point.free($!cp);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_point_get_type, $n, $t );
  }

  multi method zero (Clutter::Point:U:) {
    $zero;
  }

}

multi sub infix:<eqv> (ClutterPoint $a, ClutterPoint $b) {
  so clutter_point_equals($a, $b);
}
