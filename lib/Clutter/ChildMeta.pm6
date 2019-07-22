use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Roles::Data;
use GTK::Roles::Protection;
use GTK::Compat::Roles::Object;

class Clutter::ChildMeta {
  also does GTK::Roles::Protection;
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Data;

  has ClutterChildMeta $!ccmeta;

  submethod BUILD {
    self.ADD-PREFIX('Clutter::');
  }

  method setChildMeta (ClutterChildMeta $childmeta) {
    self!setObject( cast(GObject, $!data = ($!ccmeta = $childmeta).p ) );
  }

  method get_actor
    is also<
      get-actor
      actor
    >
  {
    ::('Clutter::Actor').new( clutter_child_meta_get_actor($!ccmeta) );
  }

  method get_container
    is also<
      get-container
      container
    >
  {
    ::('Clutter::Container').new( clutter_child_meta_get_container($!ccmeta) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_child_meta_get_type, $n, $t );
  }

}

sub clutter_child_meta_get_actor (ClutterChildMeta $data)
  returns ClutterActor
  is native(clutter)
  is export
  { * }

sub clutter_child_meta_get_container (ClutterChildMeta $data)
  returns ClutterContainer
  is native(clutter)
  is export
  { * }

sub clutter_child_meta_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
