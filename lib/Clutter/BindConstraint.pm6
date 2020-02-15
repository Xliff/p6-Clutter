use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::BindConstraint;

use Clutter::Constraint;

our subset ClutterBindConstraintAncestry is export of Mu
  where ClutterBindConstraint | ClutterConstraintAncestry;

class Clutter::BindConstraint is Clutter::Constraint {
  has ClutterBindConstraint $!cb;

  submethod BUILD (:$bindconstraint) {
    my $to-parent;
    $!cb = do given $bindconstraint {
      when ClutterBindConstraint {
        $to-parent = cast(ClutterConstraint, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterBindConstraint, $_);
      }
    }
    self.setConstraint($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterBindConstraint
    is also<ClutterBindConstraint>
  { $!cb }

  multi method new (ClutterBindConstraintAncestry $bindconstraint) {
    $bindconstraint ?? self.bless(:$bindconstraint) !! Nil;
  }
  multi method new (
    ClutterActor() $source,
    Int() $coordinate, # ClutterBindCoordinate $coordinate,
    Num() $offset      # gfloat $offset
  ) {
    my gfloat $o = $offset;
    my guint $c = $coordinate;
    my $bindconstraint = clutter_bind_constraint_new($source, $c, $o);

    $bindconstraint ?? self.bless(:$bindconstraint) !! Nil;
  }

  method get_coordinate is also<get-coordinate> {
    clutter_bind_constraint_get_coordinate($!cb);
  }

  method get_offset is also<get-offset> {
    clutter_bind_constraint_get_offset($!cb);
  }

  method get_source (:$raw = False) is also<get-source> {
    my $a = clutter_bind_constraint_get_source($!cb);

    $a ??
      ( $raw ?? $a !! ::('Clutter::Actor').new($a) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_bind_constraint_get_type, $n, $t );
  }

  method set_coordinate (Int() $coordinate) is also<set-coordinate> {
    my guint $c = $coordinate;

    clutter_bind_constraint_set_coordinate($!cb, $c);
  }

  method set_offset (Num() $offset) is also<set-offset> {
    my gfloat $o = $offset;
    
    clutter_bind_constraint_set_offset($!cb, $o);
  }

  method set_source (ClutterActor() $source) is also<set-source> {
    clutter_bind_constraint_set_source($!cb, $source);
  }

}
