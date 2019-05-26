use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Roles::Object;
use GTK::Roles::Protection;

# Abstract. 
# GObject.

class Clutter::Action {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Protection;
  
  has ClutterAction $!c-act;
  
  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }
  
  method Clutter::Raw::Types::ClutterAction
    is also<ClutterAction>
  { $!c-act }
  
  method setAction(ClutterAction $action) {
    self.IS-PROTECTED;
    self!setObject($!c-act = $action);
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_action_get_type, $n, $t );
  }
}

sub clutter_action_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
