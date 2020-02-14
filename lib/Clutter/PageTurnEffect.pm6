use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use Clutter::Raw::PageTurnEffect;

use Clutter::OffscreenEffect;

our subset PageTurnEffectAncestry is export of Mu
  where ClutterPageTurnEffect | OffscreenEffectAncestry;

class Clutter::PageTurnEffect is Clutter::OffscreenEffect {
  has ClutterPageTurnEffect $!cpte;

  submethod BUILD (:$page-turn) {
    given $page-turn {
      when PageTurnEffectAncestry {
        my $to-parent;
        $!cpte = do {
          when ClutterPageTurnEffect {
            $to-parent = cast(ClutterOffscreenEffect, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterPageTurnEffect, $_);
          }
        }
        self.setOffscreenEffect($to-parent);
      }
      when Clutter::PageTurnEffect {
      }
      default {
      }
    }
  }

  method Clutter::Raw::Types::PageTurnEffect
  { $!cpte }

  multi method new (ClutterPageTurnEffect $page-turn) {
    self.bless(:$page-turn);
  }
  multi method new (Num() $period, Num() $angle, Num() $radius) {
    my gdouble ($p, $a) = ($period, $angle);
    my gfloat $r = $radius;
    self.bless( page-turn => clutter_page_turn_effect_new($p, $a, $r) );
  }

  method angle is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_page_turn_effect_get_angle($!cpte);
      },
      STORE => sub ($, Num() $angle is copy) {
        my gdouble $a = $angle;
        clutter_page_turn_effect_set_angle($!cpte, $a);
      }
    );
  }

  method period is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_page_turn_effect_get_period($!cpte);
      },
      STORE => sub ($, Num() $period is copy) {
        my gdouble $p = $period;
        clutter_page_turn_effect_set_period($!cpte, $p);
      }
    );
  }

  method radius is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_page_turn_effect_get_radius($!cpte);
      },
      STORE => sub ($, Num() $radius is copy) {
        my gfloat $r = $radius;
        clutter_page_turn_effect_set_radius($!cpte, $r);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_page_turn_effect_get_type, $n, $t )
  }

}
