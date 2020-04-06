use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;
use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::Size {
  has ClutterSize $!cs;

  submethod BUILD (:$size) {
    $!cs = $size;
  }

  method Clutter::Raw::Definitions::ClutterSize
    is also<ClutterSize>
  { $!cs }

  multi method new (ClutterSize $size) {
    $size ?? self.bless( :$size ) !! Nil;
  }
  multi method new (Num() $width, Num() $height) {
    self.init($width, $height);
  }

  multi method init (Num() $width, Num() $height) {
    my $size = Clutter::Size.alloc;

    die 'Could not allocate ClutterSize!' unless $size;

    Clutter::Size.init($size, $width, $height);

    self.bless(:$size);
  }
  multi method init (
    Clutter::Size:U:
    ClutterSize $s,
    Num() $width,
    Num() $height
  ) {
    my gfloat ($w, $h) = ($width, $height);
    clutter_size_init($s, $w, $h);
    $s
  }

  method alloc {
    clutter_size_alloc();
  }

  method copy (:$raw = False) {
    my $c = clutter_size_copy($!cs);

    $c ??
      ( $raw ?? $c !! Clutter::Size.new($c) )
      !!
      Nil;
  }

  method equals (ClutterSize() $b) {
    so clutter_size_equals($!cs, $b);
  }

  method free (Clutter::Size:U:) {
    clutter_size_free($!cs);
  }

  method !free {
    Clutter::Size.free($!cs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_size_get_type, $n, $t );
  }

}

multi sub infix:<eqv> (ClutterSize $a, ClutterSize $b) is export {
  so clutter_size_equals($a, $b);
}
