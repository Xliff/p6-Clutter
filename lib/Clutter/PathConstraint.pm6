use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use Clutter::Raw::PathConstraint;

use Clutter::Constraint;
use Clutter::Path;

our subset PathConstraintAncestry of Mu
  where ClutterPathConstraint | ClutterConstraint;

class Clutter::PathConstraint is Clutter::Constraint {
  has ClutterPathConstraint $!cpc;
  
  submethod BUILD (:$pathconstraint) {
    given $pathconstraint {
      when PathConstraintAncestry {
        my $to-parent;
        $!cpc = do {
          when ClutterPathConstraint {
            $to-parent = cast(ClutterContainer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterPathConstraint, $_);
          }
        };
        self.setConstraint($to-parent);
      }
      when Clutter::PathConstraint {
      }
      default {
      }
    }
  }
  
  method Clutter::Raw::Types::ClutterPathConstraint
    is also<ClutterPathConstraint>
  { $!cpc }
  
  multi method new (PathConstraintAncestry $pathconstraint) {
    self.bless(:$pathconstraint);
  }
 
  multi method new (ClutterPath() $path, Num() $offset) {
    self.bless( 
      pathconstraint => clutter_path_constraint_new($path, $offset)
    );
  }
  
  method offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_path_constraint_get_offset($!cpc);
      },
      STORE => sub ($, Num() $offset is copy) {
        my gfloat $o = $offset;
        clutter_path_constraint_set_offset($!cpc, $o);
      }
    );
  }

  method path is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Path.new( clutter_path_constraint_get_path($!cpc) );
      },
      STORE => sub ($, ClutterPath() $path is copy) {
        clutter_path_constraint_set_path($!cpc, $path);
      }
    );
  }
  
  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_path_constraint_get_type, $n, $t );
  }

}
  
