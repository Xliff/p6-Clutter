use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;
use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::ActorBox {
  has ClutterActorBox $!cab handles <x1 y1 x2 y2>;

  submethod BUILD (:$actorbox) {
    $!cab = $actorbox;
  }

  multi method new (ClutterActorBox $actorbox) {
    $actorbox ?? self.bless(:$actorbox) !! Nil;
  }
  multi method new (Num() $x_1, Num() $y_1, Num() $x_2, Num() $y_2) {
    my gfloat ($xx1, $yy1, $xx2, $yy2) = ($x_1, $y_1, $x_2, $y_2);
    my $actorbox = clutter_actor_box_new($xx1, $yy1, $xx2, $yy2);

    $actorbox ?? self.bless(:$actorbox) !! Nil;
  }

  method alloc (Clutter::ActorBox:U:) {
    clutter_actor_box_alloc();
  }

  method clamp_to_pixel is also<clamp-to-pixel> {
    clutter_actor_box_clamp_to_pixel($!cab);
  }

  method contains (Num() $x, Num() $y) {
    my gfloat ($xx, $yy) = ($x, $y);

    clutter_actor_box_contains($!cab, $xx, $yy);
  }

  method copy (:$raw = False) {
    my $ab = clutter_actor_box_copy($!cab);

    $ab ??
      ( $raw ?? $ab !! Clutter::ActorBox.new($ab) )
      !!
      Nil;
  }

  method equal (ClutterActorBox() $box_b) {
    so clutter_actor_box_equal($!cab, $box_b);
  }

  method free (Clutter::ActorBox:U: ClutterActorBox $ab) {
    clutter_actor_box_free($ab);
  }

  method !free {
    Clutter::ActorBox.free($!cab);
  }

  method get_area
    is also<
      get-area
      area
    >
  {
    clutter_actor_box_get_area($!cab);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    clutter_actor_box_get_height($!cab);
  }

  proto method get_origin (|)
    is also<get-origin>
  { * }

  multi method get_origin {
    samewith($, $);
  }
  multi method get_origin ($x is rw, $y is rw)  {
    my gfloat ($xx, $yy) = 0e0 xx 2;

    clutter_actor_box_get_origin($!cab, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw)  {
    my gfloat ($w, $h) = 0e0 xx 2;

    clutter_actor_box_get_size($!cab, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_actor_box_get_type, $n, $t );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    clutter_actor_box_get_width($!cab);
  }

  method get_x
    is also<
      get-x
      x
    >
  {
    clutter_actor_box_get_x($!cab);
  }

  method get_y
    is also<
      get-y
      y
    >
  {
    clutter_actor_box_get_y($!cab);
  }

  method init (
    Clutter::ActorBox:U:
    ClutterActorBox() $ab,
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2) = ($x_1, $y_1, $x_2, $y_2);

    clutter_actor_box_init($ab, $xx1, $yy1, $xx2, $yy2);
  }

  method init_rect (
    Clutter::ActorBox:U:
    ClutterActorBox() $ab,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  )
    is also<init-rect>
  {
    my gfloat ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    clutter_actor_box_init_rect($ab, $xx, $yy, $w, $h);
  }

  multi method interpolate (
    ClutterActorBox() $final,
    Num() $progress,
    :$raw = False
  ) {
    my $actorbox = ClutterActorBox.alloc;

    die 'Could not allocate ClutterActorBox!' unless $actorbox;

    # Could use the return result, but illustrates one method of use...
    Clutter::ActorBox.interpolate($!cab, $final, $progress, $actorbox);

    $actorbox ??
      ( $raw ?? $actorbox !! Clutter::ActorBox.new($actorbox) )
      !!
      Nil;
  }
  multi method interpolate (
    Clutter::ActorBox:U:
    ClutterActorBox() $a,
    ClutterActorBox() $b,
    Num() $progress,
    ClutterActorBox() $r
  ) {
    my gdouble $p = $progress;

    clutter_actor_box_interpolate($a, $b, $p, $r);
    $r;
  }

  method set_origin (Num() $x, Num() $y) is also<set-origin> {
    my gfloat ($xx, $yy) = ($x, $y);

    clutter_actor_box_set_origin($!cab, $xx, $yy);
  }

  method set_size (Num() $width, Num() $height) is also<set-size> {
    my gfloat ($w, $h) = ($width, $height);

    clutter_actor_box_set_size($!cab, $width, $height);
  }

  multi method union (ClutterActorBox() $b, :$raw = False) {
    my $ab = ClutterActorBox.alloc;

    Clutter::ActorBox.union($!cab, $b, $ab);

    $ab ??
      ( $raw ?? $ab !! Clutter::ActorBox.new($ab) )
      !!
      Nil;
  }
  multi method union (
    Clutter::ActorBox:U:
    ClutterActorBox() $a,
    ClutterActorBox() $b,
    ClutterActorBox() $result
  ) {
    clutter_actor_box_union($!cab, $b, $result);
    $result;
  }


}
