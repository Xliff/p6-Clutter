use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::ActorMeta;

use GTK::Compat::Roles::Object;
use GTK::Roles::Protection;

class Clutter::ActorMeta {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Protection;

  has ClutterActorMeta $!cam;

  submethod BUILD (:$metaactor) {
    self.ADD-PREFIX('Clutter::');
    self.setActorMeta(:$metaactor) if $metaactor.defined;
  }

  method setActorMeta (ClutterActorMeta $metaactor) {
    self.IS-PROTECTED;
    self!setObject( cast(GObject, $!cam = $metaactor) );
  }

  method Clutter::Raw::Types::ClutterActorMeta
    is also<ClutterActorMeta>
  { $!cam }

  method new (ClutterActorMeta $metaactor) {
    self.bless(:$metaactor);
  }

  method enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_meta_get_enabled($!cam);
      },
      STORE => sub ($, Int() $is_enabled is copy) {
        my gboolean $ie = resolve-bool($is_enabled);
        clutter_actor_meta_set_enabled($!cam, $ie);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_meta_get_name($!cam);
      },
      STORE => sub ($, Str() $name is copy) {
        clutter_actor_meta_set_name($!cam, $name);
      }
    );
  }

  method get_actor
    is also<
      get-actor
      actor
    >
  {
    ::('Clutter::Actor').new( clutter_actor_meta_get_actor($!cam) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_actor_meta_get_type, $n, $t );
  }

}
