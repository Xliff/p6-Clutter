use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::VariousTypes;

# Boxed

class Clutter::ActorBox {
  has ClutterActorBox $!cab;
  
  submethod BUILD (:$actorbox) {
    $!cab = $actorbox;
  }
  
  method new (Num() $x_1, Num() $y_1, Num() $x_2, Num() $y_2) {
    my gfloat ($xx1, $yy1, $xx2, $yy2) = ($x_1, $y_1, $x_2, $y_2);
    self.bless( actorbox => clutter_actor_box_new($xx1, $yy1, $xx2, $yy2) );
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

  method copy {
    Clutter::ActorBox.new( clutter_actor_box_copy($!cab) );
  }

  method equal (ClutterActorBox() $box_b) {
    clutter_actor_box_equal($!cab, $box_b);
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

  method get_origin (Num() $x, Num() $y) is also<get-origin> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_box_get_origin($!cab, $xx, $yy);
  }

  method get_size (Num() $width, Num() $height) is also<get-size> {
    clutter_actor_box_get_size($!cab, $width, $height);
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
    ClutterActorBox $ab, 
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
    ClutterActorBox $ab,
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
    Clutter::ActorBox:U:
    ClutterActorBox $a,
    ClutterActorBox $b,
    Num() $progress,
    ClutterActorBox $r
  ) {
    my gdouble $p = $progress;
    clutter_actor_box_interpolate($a, $b, $p, $r);
    $r;
  }
  multi method interpolate (ClutterActorBox() $final, Num() $progress) {
    my $result = ClutterActorBox.alloc;
    # Could use the return result, but illustrates one method of use...
    Clutter::ActorBox.interpolate($!cab, $final, $progress, $result);
    Clutter::ActorBox.new($result);
  }

  method set_origin (Num() $x, Num() $y) is also<set-origin> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_box_set_origin($!cab, $xx, $yy);
  }

  method set_size (Num() $width, Num() $height) is also<set-size> {
    my gfloat ($w, $h) = ($width, $height);
    clutter_actor_box_set_size($!cab, $width, $height);
  }

  multi method union (
    Clutter::ActorBox:U:
    ClutterActorBox $a,
    ClutterActorBox $b, 
    ClutterActorBox $result
  ) {
    clutter_actor_box_union($!cab, $b, $result);
    $result;
  }
  multi method union (ClutterActorBox() $b) {
    my $r = ClutterActorBox.alloc;
    # Uses the returned result.
    Clutter::ActorBox.new( Clutter::ActorBox.union($!cab, $b, $r) );
  }
  
}
