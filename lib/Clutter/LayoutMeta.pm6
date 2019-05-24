use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::ChildMeta;

class Clutter::LayoutMeta is Clutter::ChildMeta {
  has ClutteLayoutMeta $!clmeta;
  
  submethod BUILD (:$metalayout) {
    self.setChildMeta( 
      cast(ClutterLayoutMeta, $!clmeta = $metalayout) 
    );
  }
  
  method get_manager {
    ::('Clutter::LayoutManager').new( 
      clutter_layout_meta_get_manager($!clmeta)
    );
  }

  method get_type {
    state ($n, $m);
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
