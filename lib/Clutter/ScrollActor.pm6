use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::ScrollActor;

use Clutter::Actor;

our subset ScrollActorAncestry is export of Mu
  where ClutterScrollActor | ActorAncestry;

class Clutter::ScrollActor is Clutter::Actor {
  has ClutterScrollActor $!csa;

  submethod BUILD (:$clone) {
    given $clone {
      when ScrollActorAncestry {
        my $to-parent;
        $!csa = do {
          when ScrollActorAncestry {
            $to-parent = cast(ClutterActor, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterScrollActor, $_);
          }
        }
        self.setActor($to-parent);
      }
      when Clutter::ScrollActor {
      }
      default {
      }
    }
  }

  method Clutter::Raw::Types::ClutterScrollActor
    is also<ClutterScrollActor>
  { $!csa }

  method new {
    self.bless( scroll => clutter_scroll_actor_new() );
  }

  method scroll_mode is rw is also<scroll-mode> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterScrollMode( clutter_scroll_actor_get_scroll_mode($!csa) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = resolve-uint($mode);
        clutter_scroll_actor_set_scroll_mode($!csa, $m);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_scroll_actor_get_type, $n, $t );
  }

  method scroll_to_point (ClutterPoint() $point) is also<scroll-to-point> {
    clutter_scroll_actor_scroll_to_point($!csa, $point);
  }

  method scroll_to_rect (ClutterRect() $rect) is also<scroll-to-rect> {
    clutter_scroll_actor_scroll_to_rect($!csa, $rect);
  }

}
