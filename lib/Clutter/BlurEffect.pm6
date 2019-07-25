use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::OffscreenEffect;

our subset BlurAncestry of Mu
  where ClutterBlurEffect | ClutterEffect;

class Clutter::BlurEffect is Clutter::OffscreenEffect {
  has ClutterBlurEffect $!cb;
  
  submethod BUILD (:$blur) {
    given $blur {
      when BlurAncestry {
        my $to-parent;
        $!cb = do {
          when ClutterBlurEffect {
            $to-parent = cast(ClutterOffscreenEffect, $_);
            $_;
          }
          when ClutterOffscreenEffect {
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
  
  method new { 
    self.bless( blur => clutter_blur_effect_new() );
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
