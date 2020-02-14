use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::PanAction;

use Clutter::GestureAction;

use Clutter::Roles::Signals::PanAction;

class Clutter::PanAction is Clutter::GestureAction {
  also does Clutter::Roles::Signals::PanAction;
  
  has ClutterPanAction $!cpa;
  
  # Needs ancestry logic
  submethod BUILD (:$pan) {
    self.setGestureAction( cast(ClutterGestureAction, $!cpa = $pan) );
  }
  
  method Clutter::Raw::Types::ClutterPanAction
  { $!cpa }

  multi method new (ClutterPanAction $pan) {
    self.bless(:$pan);
  }
  multi method new {
    self.bless( pan => clutter_pan_action_new() );
  }
  
  method acceleration_factor is rw is also<acceleration-factor> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_pan_action_get_acceleration_factor($!cpa);
      },
      STORE => sub ($, Num() $factor is copy) {
        my gdouble $f = $factor;
        clutter_pan_action_set_acceleration_factor($!cpa, $f);
      }
    );
  }

  method deceleration is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_pan_action_get_deceleration($!cpa);
      },
      STORE => sub ($, Num() $rate is copy) {
        my gdouble $r = $rate;
        clutter_pan_action_set_deceleration($!cpa, $r);
      }
    );
  }

  method interpolate is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_pan_action_get_interpolate($!cpa);
      },
      STORE => sub ($, Int() $should_interpolate is copy) {
        my gboolean $s = resolve-bool($should_interpolate);
        clutter_pan_action_set_interpolate($!cpa, $s);
      }
    );
  }

  method pan_axis is rw is also<pan-axis> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterPanAxis( clutter_pan_action_get_pan_axis($!cpa) );
      },
      STORE => sub ($, Int() $axis is copy) {
        my guint $a = resolve-uint($axis);
        clutter_pan_action_set_pan_axis($!cpa, $a);
      }
    );
  }
  
  # Is originally:
  # ClutterPanAction, ClutterActor, gboolean, gpointer --> gboolean
  method pan {
    self.connect-pan($!cpa);
  }

  # Is originally:
  # ClutterPanAction, ClutterActor, gpointer --> void
  method pan-stopped is also<pan_stopped> {
    self.connect-actor($!cpa, 'pan-stopped');
  }
  
  proto method get_constrained_motion_delta (|)
    is also<get-constrained-motion-delta> 
  { * }
  
  multi method get_constrained_motion_delta (Int() $point) {
    my ($dx, $dy) = (0, 0);
    samewith($dx, $dy);
  }
  multi method get_constrained_motion_delta (
    Int() $point, 
    $delta_x is rw, 
    $delta_y is rw
  ) {
    die '$delta_x must be Num-compatible' unless $delta_x.^can('Num').elems;
    die '$delta_y must be Num-compatible' unless $delta_y.^can('Num').elems;
    $_ .= Num for $delta_x, $delta_y;
    my guint $p = resolve-uint($point);
    my gfloat ($dx, $dy) = ($delta_x, $delta_y);
    clutter_pan_action_get_constrained_motion_delta($!cpa, $p, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  proto method get_interpolated_coords (|)
    is also<get-interpolated-coords> 
  { * }
  
  multi method get_interpolated_coords {
    my ($ix, $iy) = (0, 0);
    samewith($ix, $iy);
  }
  multi method get_interpolated_coords (
    $interp_x is rw, 
    $interp_y is rw  
  ) {
    die '$interp_x must be Num-compatible' unless $interp_x.^can('Num').elems;
    die '$interp_y must be Num-compatible' unless $interp_y.^can('Num').elems;
    my gfloat ($ix, $iy) = ($interp_x, $interp_y);
    clutter_pan_action_get_interpolated_coords($!cpa, $ix, $iy);
    ($interp_x, $interp_y) = ($ix, $iy);
  }
  
  proto method get_interpolated_delta (|)
    is also<get-interpolated-delta> 
  { * }
  
  multi method get_interpolated_delta {
    my ($dx, $dy) = (0, 0);
    samewith($dx, $dy);
  }
  multi method get_interpolated_delta (
    $delta_x is rw, 
    $delta_y is rw
  ) {
    die '$delta_x must be Num-compatible' unless $delta_x.^can('Num').elems;
    die '$delta_y must be Num-compatible' unless $delta_y.^can('Num').elems;
    $_ .= Num for $delta_x, $delta_y;
    my gfloat ($dx, $dy) = ($delta_x, $delta_y);
    clutter_pan_action_get_interpolated_delta($!cpa, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  proto method get_motion_coords (|)
    is also<get-motion-coords> 
  { * }
  
  multi method get_motion_coords (Int() $point) {
    my ($mx, $my) = (0, 0);
    samewith($point, $mx, $my);
  }
  multi method get_motion_coords (
    Int() $point, 
    Num() $motion_x is rw, 
    Num() $motion_y is rw
  ) {
    die '$motion_x must be Num-compatible' unless $motion_x.^can('Num').elems;
    die '$motion_y must be Num-compatible' unless $motion_y.^can('Num').elems;
    $_ .= Num for $motion_x, $motion_y;
    my guint $p = resolve-uint($point);
    my gfloat ($mx, $my) = ($motion_x, $motion_y);
    clutter_pan_action_get_motion_coords($!cpa, $p, $mx, $my);
    ($motion_x, $motion_y) = ($mx, $my);
  }

  proto method get_motion_delta (|)
    is also<get-motion-delta> 
  { * }
  
  multi method get_motion_delta (Int() $point) {
    my ($dx, $dy) = (0, 0);
    samewith($point, $dx, $dy);
  }
  multi method get_motion_delta (
    Int() $point, 
    $delta_x is rw, 
    $delta_y is rw
  ) {
    die '$delta_x must be Num-compatible' unless $delta_x.^can('Num').elems;
    die '$delta_y must be Num-compatible' unless $delta_y.^can('Num').elems;
    $_ .= Num for $delta_x, $delta_y;
    my guint $p = resolve-uint($point);
    my gfloat ($dx, $dy) = ($delta_x, $delta_y);
    clutter_pan_action_get_motion_delta($!cpa, $p, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_pan_action_get_type, $n, $t );
  }

}

  
