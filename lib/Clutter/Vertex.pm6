use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::Vertex {
  has ClutterVertex $!cv handles<x y z>;

  submethod BUILD (:$cluttervertex) {
    $!cv = $cluttervertex;
  }

  method new (Num() $x, Num() $y, Num() $z) {
    my gfloat ($xx, $yy, $zz) = ($x, $y, $z);
    my $cluttervertex = clutter_vertex_new($x, $y, $z);

    $cluttervertex ?? self.bless(:$cluttervertex) !! Nil;
  }

  method alloc (Clutter::Vertex:U:) {
    clutter_vertex_alloc();
  }

  method copy (:$raw = False) {
    my $cluttervertex = clutter_vertex_copy($!cv);

    $cluttervertex ?? self.bless(:$cluttervertex) !! Nil;
  }

  method equal (ClutterVertex() $vertex_b) {
    so clutter_vertex_equal($!cv, $vertex_b);
  }

  method free {
    clutter_vertex_free($!cv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_vertex_get_type, $n, $t);
  }

  method init (
    Clutter::Vertex:U:
    ClutterVertex $v;
    Num() $x,
    Num() $y,
    Num() $z
  ) {
    clutter_vertex_init($v, $x, $y, $z);
  }

}

# Should be done for all types in Clutter::Raw::VariousTypes
multi sub infix:<eqv> (ClutterVertex $a, ClutterVertex $b) is export {
  clutter_vertex_equal($a, $b);
}

multi sub free (ClutterVertex $v) is export {
  clutter_vertex_free($v);
}
