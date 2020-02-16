use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::OffscreenEffect;

use Clutter::Effect;

our subset ClutterOffscreenEffectAncestry is export of Mu
  where ClutterOffscreenEffect | ClutterEffectAncestry;

class Clutter::OffscreenEffect is Clutter::Effect {
  has ClutterOffscreenEffect $!coe;

  # ABSTRACT!
  #
  # submethod BUILD (:$offscreen) {
  #   given $offscreen {
  #     when    OffscreenEffectAncestry  { self.setOffscreenEffect($offscreen) }
  #     when    Clutter::OffscreenEffect { }
  #     default                          { }
  #   }
  # }

  method setOffscreenEffect(ClutterOffscreenEffectAncestry $offscreen) {
    #self.IS-PROTECTED;
    say 'setOffscreenEffect' if $DEBUG;
    my $to-parent;
    $!coe = do given $offscreen {
      when ClutterOffscreenEffect {
        $to-parent = cast(ClutterEffect, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterOffscreenEffect, $_)
      }
    }
    self.setEffect($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterOffscreenEffect
    is also<ClutterOffscreenEffect>
  { $!coe }

  method create_texture (Num() $width, Num() $height) is also<create-texture> {
    my gfloat ($w, $h) = ($width, $height);

    clutter_offscreen_effect_create_texture($!coe, $width, $height);
  }

  method get_target
    is also<
      get-target
      target
    >
  {
    clutter_offscreen_effect_get_target($!coe);
  }

  method get_target_rect (ClutterRect() $rect) is also<get-target-rect> {
    so clutter_offscreen_effect_get_target_rect($!coe, $rect);
  }

  method get_texture is also<get-texture> {
    clutter_offscreen_effect_get_texture($!coe);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_offscreen_effect_get_type, $n, $t );
  }

  method paint_target is also<paint-target> {
    clutter_offscreen_effect_paint_target($!coe);
  }

}
