use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Actor;

class Clutter::ActorIter {
  has ClutterActorIter $!cai;
  
  submethod BUILD (:$iter) {
    $!cai = $iter;
  }
  
  method Clutter::Raw::Types::ClutterActorIter
    is also<ClutterActorIter>
  { $!cai }
  
  method new (ClutterActorIter $iter) {
    self.bless(:$iter);
  }
  
  method destroy {
    clutter_actor_iter_destroy($!cai);
  }

  method init (ClutterActor() $root)  {
    clutter_actor_iter_init($!cai, $root);
  }

  method is_valid is also<is-valid> {
    clutter_actor_iter_is_valid($!cai);
  }

  method next (ClutterActor() $child) {
    clutter_actor_iter_next($!cai, $child);
  }

  method prev (ClutterActor() $child) {
    clutter_actor_iter_prev($!cai, $child);
  }

  method remove {
    clutter_actor_iter_remove($!cai);
  }
}
