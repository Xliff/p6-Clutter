use v6.c;

use NativeCall;
use Method::Also;

use Clutter::Raw::Types;

use GLib::Roles::Object;

class Clutter::ChildMeta {
  also does GLib::Roles::Object;

  has ClutterChildMeta $!ccmeta;

  submethod BUILD {
    #self.ADD-PREFIX('Clutter::');
  }

  method setChildMeta (ClutterChildMeta $childmeta) {
    self!setObject( cast(GObject, $!ccmeta = $childmeta) );
  }

  method Clutter::Raw::Definitions::ClutterChildMeta
    is also<ChildMeta>
  { $!ccmeta }

  method get_actor (:$raw = False)
    is also<
      get-actor
      actor
    >
  {
    my $a = clutter_child_meta_get_actor($!ccmeta);

    $a ??
      ( $raw ?? $a !! ::('Clutter::Actor').new($a) )
      !!
      Nil
  }

  method get_container (:$raw = False)
    is also<
      get-container
      container
    >
  {
    my $c = clutter_child_meta_get_container($!ccmeta);

    $c ??
      ( $raw ?? $c !! ::('Clutter::Container').new($c) )
      !!
      Nil
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
