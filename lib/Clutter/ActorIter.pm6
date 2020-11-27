use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;
use Clutter::Raw::Actor;

use Clutter::Actor;

class Clutter::ActorIter {
  has ClutterActorIter $!cai;

  submethod BUILD (:$iter) {
    $!cai = $iter;
  }

  method Clutter::Raw::Definitions::ClutterActorIter
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
    $iter ?? self.bless(:$iter) !! Nil;
  }
  multi method new (ClutterActor() $root) {
    my $iter = ClutterActorIter.new;

    die 'Could not allocate ClutterActorIter!' unless $iter;

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

  multi method next (:$raw = False) {
    my $a = CArray[ClutterActor].new;
    $a[0] = ClutterActor;

    my $rv = samewith($a, :$raw);
    $rv[0] ?? $rv[1] !! Nil;
  }

  multi method next (CArray[ClutterActor] $child, :$raw = False) {
    my $rv = so clutter_actor_iter_next($!cai, $child);
    my $c  = ppr($child);

    $c = $c ??
      ( $raw ?? $c !! Clutter::Actor.new($c, :!ref) )
      !!
      Nil;

    ($rv, $c);
  }

  multi method prev (:$raw = False) {
    my $a = CArray[ClutterActor].new;
    $a[0] = ClutterActor;

    my $rv = samewith($a, :$raw);
    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method prev (CArray[ClutterActor] $child, :$raw = False) {
    my $rv = so clutter_actor_iter_prev($!cai, $child);
    my $c  = ppr($child);

    $c = $c ??
      ( $raw ?? $c !! Clutter::Actor.new($c, :!ref) )
      !!
      Nil;

    ($rv, $c);
  }

  method remove {
    clutter_actor_iter_remove($!cai);
  }
}
