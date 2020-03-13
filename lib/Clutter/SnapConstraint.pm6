use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::SnapConstraint;

use GLib::Value;
use Clutter::Actor;
use Clutter::Constraint;

our subset ClutterSnapConstraintAncestry is export of Mu
  where ClutterSnapConstraint | ClutterConstraintAncestry;

class Clutter::SnapConstraint is Clutter::Constraint {
  has ClutterSnapConstraint $!csc;

  # Needs ancestry logic
  submethod BUILD (:$snapconstraint) {
    given $snapconstraint {
      when ClutterSnapConstraintAncestry {
        my $to-parent;
        $!csc = do {
          when ClutterSnapConstraint {
            $to-parent = cast(ClutterConstraint, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterSnapConstraint, $_);
          }
        }
        self.setConstraint($to-parent);
      }

      when Clutter::SnapConstraint {
      }

      default {
      }
    }
  }

  method Clutter::Raw::Definitions::ClutterSnapConstraint
    is also<ClutterSnapConstraint>
  { $!csc }

  multi method new (ClutterSnapConstraintAncestry $snapconstraint) {
    $snapconstraint ?? self.bless(:$snapconstraint) !! Nil;
  }
  multi method new (
    ClutterActor() $source,
    Int() $from_edge,   # ClutterSnapEdge $from_edge,
    Int() $to_edge,     # ClutterSnapEdge $to_edge
    Num() $offset
  ) {
    my gfloat $o = $offset;
    my guint ($fe, $te) = ($from_edge, $to_edge);
    my $snapconstraint = clutter_snap_constraint_new($source, $fe, $te, $o);

    $snapconstraint ?? self.bless(:$snapconstraint) !! Nil;
  }

  method offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_snap_constraint_get_offset($!csc);
      },
      STORE => sub ($, Num() $offset is copy) {
        my gfloat $o = $offset;

        clutter_snap_constraint_set_offset($!csc, $o);
      }
    );
  }

  method source (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $sa = clutter_snap_constraint_get_source($!csc);

        $sa ??
          ( $raw ?? $sa !! Clutter::Actor.new($sa) )
          !!
          ClutterActor;
      },
      STORE => sub ($, ClutterActor() $source is copy) {
        clutter_snap_constraint_set_source($!csc, $source);
      }
    );
  }

  # Type: ClutterSnapEdge
  method from-edge is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('from-edge', $gv)
        );
        ClutterSnapEdgeEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('from-edge', $gv);
      }
    );
  }

  # Type: ClutterSnapEdge (guint)
  method to-edge is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('to-edge', $gv)
        );
        ClutterSnapEdgeEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('to-edge', $gv);
      }
    );
  }


  method get_edges (
    Int() $from_edge,   # ClutterSnapEdge $from_edge,
    Int() $to_edge      # ClutterSnapEdge $to_edge
  )
    is also<get-edges>
  {
    my guint ($fe, $te) = ($from_edge, $to_edge);

    clutter_snap_constraint_get_edges($!csc, $fe, $te);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_snap_constraint_get_type, $n, $t );
  }

  method set_edges (
    Int() $from_edge,   # ClutterSnapEdge $from_edge,
    Int() $to_edge      # ClutterSnapEdge $to_edge
  )
    is also<set-edges>
  {
    my guint ($fe, $te) = ($from_edge, $to_edge);

    clutter_snap_constraint_set_edges($!csc, $fe, $te);
  }

}
