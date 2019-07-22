use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::ChildMeta;

class Clutter::LayoutMeta is Clutter::ChildMeta {
  has ClutterLayoutMeta $!clmeta;
  
  submethod BUILD (:$metalayout) {
    self.setChildMeta( 
      cast(ClutterChildMeta, $!clmeta = $metalayout) 
    );
  }
    
  method new (ClutterLayoutMeta $metalayout) {
    # No GTK::Roles::References
    # No destroy yet, so no upref logic.
    self.bless(:$metalayout);
  }
  
  method get_manager is also<get-manager> {
    ::('Clutter::LayoutManager').new( 
      clutter_layout_meta_get_manager($!clmeta)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_layout_meta_get_type, $n, $t );
  }

}

sub clutter_layout_meta_get_manager (ClutterLayoutMeta $data)
  returns ClutterLayoutManager
  is native(clutter)
  is export
  { * }

sub clutter_layout_meta_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
