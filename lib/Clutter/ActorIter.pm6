use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Actor;

use Clutter::Actor;

class Clutter::ActorIter {
  has ClutterActorIter $!cai;
  
  submethod BUILD (:$iter) {
    $!cai = $iter;
  }
  
  method Clutter::Raw::Types::ClutterActorIter
    is also<ClutterActorIter>
  { $!cai }
  
  # method new ($root is copy) {
  #   do given $root {
  #     when ClutterActorIter {
  #       self.bless(:$iter);
  #     }
  #     default {
  #       $root .= ClutterActor if $root ~~ Clutter::Actor;
  #       my $iter = ClutterActorIter.new;
  #       self.bless( iter => self.init($iter, $root) );
  #     }
  #   }
  # }
  
  multi method new (ClutterActorIter $iter) {
    self.bless(:$iter);
  }
  multi method new (ClutterActor() $root) {
    my $iter = ClutterActorIter.new;
    self.bless( iter => self.init($iter, $root) );
  }
  
  method destroy {
    clutter_actor_iter_destroy($!cai);
  }

  method init (ClutterActorIter $iter, ClutterActor() $root)  {
    clutter_actor_iter_init($iter, $root);
    $iter;
  }

  method is_valid is also<is-valid> {
    so clutter_actor_iter_is_valid($!cai);
  }

  multi method next {
    my $a = CArray[Pointer[ClutterActor]].new;
    $a[0] = Pointer[ClutterActor].new;
    my $r = samewith($a);
    $r ?? 
      $a[0].defined ?? Clutter::Actor.new( $a[0].deref ) !! Nil
      !!
      Nil;
  }
  multi method next (CArray[Pointer[ClutterActor]] $child) {
    so clutter_actor_iter_next($!cai, $child);
  }

  multi method prev {
    my $a = CArray[Pointer[ClutterActor]].new;
    $a[0] = Pointer[ClutterActor].new;
    my $r = samewith($a);
    $r ?? 
      $a[0].defined ?? Clutter::Actor.new( $a[0] ) !! Nil
      !!
      Nil;
  }
  multi method prev (CArray[Pointer[ClutterActor]] $child) {
    so clutter_actor_iter_prev($!cai, $child);
  }

  method remove {
    clutter_actor_iter_remove($!cai);
  }
}
