use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Roles::Object;
use GTK::Roles::Protection;

# Abstract.
# GObject.

class Clutter::Constraint {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Protection;

  has ClutterConstraint $!c-con;

  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }

  method Clutter::Raw::Types::ClutterConstraint
    is also<ClutterConstraint>
  { $!c-con }

  method setConstraint (ClutterConstraint $constraint) {
    self.IS-PROTECTED;
    self!setObject($!c-con = $constraint);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_constraint_get_type, $n, $t );
  }
}

sub clutter_constraint_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
