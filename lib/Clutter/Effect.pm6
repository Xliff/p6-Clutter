use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Object;
use GTK::Compat::Protection;

# Abstract. 
# GObject.

class Clutter::Effect {
  has ClutterEffect $!c-eff;
  
  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }
  
  method Clutter::Raw::Types::ClutterEffect
    is also<ClutterEffect>
  { $!c-eff }
  
  method setAction(ClutterEffect $effect) {
    self.IS-PROTECTED;
    self!setObject($!c-eff = $effect);
  }
  
  method queue_repaint is also<queue-repaint> {
    clutter_effect_queue_repaint($!c-eff);
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_effect_get_type, $n, $t );
  }
}

sub clutter_effect_queue_repaint (ClutterEffect $effect)
  is native(clutter)
  is export
  { * }

sub clutter_effect_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }