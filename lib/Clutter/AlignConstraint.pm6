use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::AlignConstraint;

use Clutter::Constraint;

class Clutter::AlignConstraint is Clutter::Constraint {
  has ClutterAlignConstraint $!cac;
  
  # Needs ancestry logic.
  
  submethod BUILD (:$alignconstraint) {
    self.setConstraint( cast(ClutterConstraint, $!cac = $alignconstraint) );
  }
  
  method Clutter::Raw::Definitions::CluttterAlignConstraint 
    is also<ClutterAlignConstraint>
  { $!cac }
  
  method new (
    ClutterActor() $actor,
    Int() $axis, # ClutterAlignAxis $axis, 
    Num() $factor
  ) {
    my gfloat $f = $factor;
    my guint $a = resolve-uint($axis);
    self.bless( 
      alignconstraint => clutter_align_constraint_new($actor, $a, $f) 
    );
  }
  
    method align_axis is rw is also<align-axis> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterAlignAxis( clutter_align_constraint_get_align_axis($!cac) );
      },
      STORE => sub ($, Int() $axis is copy) {
        my guint $a = resolve-uint($axis);
        clutter_align_constraint_set_align_axis($!cac, $a);
      }
    );
  }

  method factor is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_align_constraint_get_factor($!cac);
      },
      STORE => sub ($, Num() $factor is copy) {
        my gfloat $f = $factor;
        clutter_align_constraint_set_factor($!cac, $f);
      }
    );
  }

  method source is rw {
    Proxy.new(
      FETCH => sub ($) {
        ::('Clutter::Actor').new( clutter_align_constraint_get_source($!cac) );
      },
      STORE => sub ($, ClutterActor() $source is copy) {
        clutter_align_constraint_set_source($!cac, $source);
      }
    );
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_align_constraint_get_type, $n, $t );
  }

}
