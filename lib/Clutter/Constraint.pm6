use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Object;
use GTK::Compat::Protection;

# Abstract. 
# GObject.

class Clutter::Constraint {
  has ClutterConstraint $!c-con;
  
  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }
  
  method Clutter::Raw::Types::ClutterConstraint
    is also<ClutterConstraint>
  { $!c-act }
  
  method setConstraint(ClutterConstraint $constraint) {
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
