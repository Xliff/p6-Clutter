use v6.c;

use Method::Also;
use NativeCall;


use Clutter::Raw::Types;

use GLib::Roles::Object;


# Abstract.
# GObject.

class Clutter::Constraint {
  also does GLib::Roles::Object;
  

  has ClutterConstraint $!c-con;

  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }

  method Clutter::Raw::Definitions::ClutterConstraint
    is also<ClutterConstraint>
  { $!c-con }

  method setConstraint (ClutterConstraint $constraint) {
    #self.IS-PROTECTED;
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
