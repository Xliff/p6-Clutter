use v6.c;

use NativeCall;

use Clutter::Raw::Types;
use Clutter::OffscreenEffect;

our subset ClutterBlurEffectAncestry is export of Mu
  where ClutterBlurEffect | ClutterEffect;

class Clutter::BlurEffect is Clutter::OffscreenEffect {
  has ClutterBlurEffect $!cb;

  submethod BUILD (:$blur) {
    given $blur {
      when ClutterBlurEffectAncestry {
        my $to-parent;
        $!cb = do {
          when ClutterBlurEffect {
            $to-parent = cast(ClutterOffscreenEffect, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterBlurEffect, $_);
          }
        }
        self.setOffscreenEffect($to-parent);
      }
      when Clutter::BlurEffect {
      }
      default {
      }
    }
  }

  multi method new (ClutterBlurEffectAncestry $blur) {
    $blur ?? self.bless(:$blur) !! Nil;
  }
  multi method new {
    my $blur = clutter_blur_effect_new();

    $blur ?? self.bless(:$blur) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_blur_effect_get_type, $n, $t );
  }
}

sub clutter_blur_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_blur_effect_new ()
  returns ClutterBlurEffect
  is native(clutter)
  is export
{ * }
