use v6.c;

use Method::Also;

use Clutter::Raw::Types;

use Clutter::Raw::ActorMeta;

use GLib::Roles::Object;

our subset MetaActorAncestry is export of Mu
  where ClutterActorMeta | GObject;

class Clutter::ActorMeta {
  also does GLib::Roles::Object;

  has ClutterActorMeta $!cam is implementor;

  submethod BUILD (:$metaactor) {
    #self.ADD-PREFIX('Clutter::');
    self.setActorMeta(:$metaactor) if $metaactor.defined;
  }

  method setActorMeta (MetaActorAncestry $_) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!cam = do {
      when ClutterActorMeta {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterActorMeta, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterActorMeta
    is also<ClutterActorMeta>
  { $!cam }

  method new (MetaActorAncestry $metaactor) {
    $metaactor ?? self.bless(:$metaactor) !! Nil;
  }

  method enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_meta_get_enabled($!cam);
      },
      STORE => sub ($, Int() $is_enabled is copy) {
        my gboolean $ie = $is_enabled.so.Int;

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

  method get_actor (:$raw = False)
    is also<
      get-actor
      actor
    >
  {
    my $a = clutter_actor_meta_get_actor($!cam);

    $a ??
      ( $raw ?? $a !! ::('Clutter::Actor').new($a) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_actor_meta_get_type, $n, $t );
  }

}
