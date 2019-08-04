use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::BrightnessContrastEffect;

use Clutter::OffscreenEffect;

our subset BrightnessContrastAncestry of Mu
  where ClutterBrightnessContrastEffect | OffscreenEffectAncestry;

class Clutter::BrightnessContrastEffect is Clutter::OffscreenEffect {
  has ClutterBrightnessContrastEffect $!cbc;
  
  submethod BUILD (:$bceffect) {
    given $bceffect {
      when BrightnessContrastAncestry {
        my $to-parent;
        $!cbc = do {
          when ClutterBrightnessContrastEffect {
            $to-parent = cast(ClutterOffscreenEffect, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterBrightnessContrastEffect, $_);
          }
        }
        self.setOffscreenEffect($to-parent);
      }
      when Clutter::BrightnessContrastEffect {
      }
      default {
      } 
    }
  }
  
  multi method new (BrightnessContrastAncestry $bceffect) {
    self.bless(:$bceffect);
  }
  
  multi method new { 
    self.bless( bceffect => clutter_brightness_contrast_effect_new() );
  }
  
  method get_brightness (Num() $red, Num() $green, Num() $blue) 
    is also<get-brightness> 
  {
    my gfloat ($r, $g, $b) = ($red, $green, $blue);
    clutter_brightness_contrast_effect_get_brightness($!cbc, $r, $g, $b);
  }

  method get_contrast (Num() $red, Num() $green, Num() $blue) 
    is also<get-contrast> 
  {
    my gfloat ($r, $g, $b) = ($red, $green, $blue);
    clutter_brightness_contrast_effect_get_contrast($!cbc, $r, $g, $b);
  }

  method get_type is also<get-type> { 
    state ($n, $t);
    unstable_get_type( 
      self.^name, &clutter_brightness_contrast_effect_get_type, $n, $t
    );
  }

  method set_brightness (Num() $brightness) is also<set-brightness> {
    my gfloat $b = $brightness;
    clutter_brightness_contrast_effect_set_brightness($!cbc, $b);
  }

  method set_brightness_full (Num() $red, Num() $green, Num() $blue) 
    is also<set-brightness-full> 
  {
    my gfloat ($r, $g, $b) = ($red, $green, $blue);
    clutter_brightness_contrast_effect_set_brightness_full($!cbc, $r, $g, $b);
  }

  method set_contrast (Num() $contrast) is also<set-contrast> {
    my gfloat $c = $contrast;
    clutter_brightness_contrast_effect_set_contrast($!cbc, $c);
  }

  method set_contrast_full (Num() $red, Num() $green, Num() $blue) 
    is also<set-contrast-full> 
  {
    my gfloat ($r, $g, $b) = ($red, $green, $blue);
    clutter_brightness_contrast_effect_set_contrast_full($!cbc, $r, $g, $b);
  }
  
}
