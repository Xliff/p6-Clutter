use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::AlignConstraint;

use Clutter::Constraint;

our subset ClutterAlignmentConstraintAncestry is export of Mu
  where ClutterAlignConstraint | ClutterConstraintAncestry;

class Clutter::AlignConstraint is Clutter::Constraint {
  has ClutterAlignConstraint $!cac;

  submethod BUILD (:$alignconstraint) {
    my $to-parent;
    $!cac = do given $alignconstraint {
      when ClutterAlignConstraint {
        $to-parent = cast(ClutterConstraint, $_);
        $_
      }

      default {
        $to-parent = $_;
        cast(ClutterAlignConstraint, $_);
      }
    }
    self.setConstraint($to-parent);
  }

  method Clutter::Raw::Definitions::CluttterAlignConstraint
    is also<ClutterAlignConstraint>
  { $!cac }

  multi method new (ClutterAlignmentConstraintAncestry $alignconstraint) {
    $alignconstraint ?? self.bless(:$alignconstraint) !! Nil;
  }
  multi method new (
    ClutterActor() $actor,
    Int() $axis, # ClutterAlignAxis $axis,
    Num() $factor
  ) {
    my gfloat $f = $factor;
    my guint $a = $axis;
    my $alignconstraint = clutter_align_constraint_new($actor, $a, $f);

    $alignconstraint ?? self.bless(:$alignconstraint) !! Nil;
  }

    method align_axis is rw is also<align-axis> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterAlignAxisEnum( clutter_align_constraint_get_align_axis($!cac) );
      },
      STORE => sub ($, Int() $axis is copy) {
        my guint $a = $axis;

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

  method source (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = clutter_align_constraint_get_source($!cac);

        $a ??
          ( $raw ?? $a !! ::('Clutter::Actor').new($a) )
          !!
          Nil
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
