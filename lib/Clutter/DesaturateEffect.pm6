use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::OffscreenEffect;

our subset DesaturateEffectAncestry is export of Mu
  where ClutterDesaturateEffect | OffscreenEffectAncestry;

class Clutter::DesaturateEffect is Clutter::OffscreenEffect {
  has ClutterDesaturateEffect $!cde;

  submethod BUILD (:$desaturate) {
    say "{$desaturate}";
    given $desaturate {
      when DesaturateEffectAncestry {
        my $to-parent;
        $!cde = do {
          when ClutterDesaturateEffect {
            $to-parent = cast(ClutterOffscreenEffect, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterDesaturateEffect, $_);
          }
        }
        self.setOffscreenEffect($to-parent);
      }
      when Clutter::DesaturateEffect {
      }
      default {
        # Proposal!
        #throw X::GTK::UnknownType($_).new
        # Which basically does:
        die "Unknown type { .^name } passed to Clutter::DesaturateEffect.BUILD!"
      }
    }
  }

  method new (Num() $factor) {
    my gdouble $f = $factor;
    self.bless( desaturate => clutter_desaturate_effect_new($f) );
  }

  method factor is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_desaturate_effect_get_factor($!cde);
      },
      STORE => sub ($, Num() $factor is copy) {
        my gdouble $f = $factor;
        clutter_desaturate_effect_set_factor($!cde, $f);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_desaturate_effect_get_type, $n, $t )
  }

}

sub clutter_desaturate_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_desaturate_effect_new (gdouble $factor)
  returns ClutterDesaturateEffect
  is native(clutter)
  is export
{ * }

sub clutter_desaturate_effect_get_factor (ClutterDesaturateEffect $effect)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_desaturate_effect_set_factor (
  ClutterDesaturateEffect $effect,
  gdouble $factor
)
  is native(clutter)
  is export
{ * }
