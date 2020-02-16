use v6.c;

use NativeCall;
use Method::Also;

use Clutter::Raw::Types;

use Clutter::LayoutManager;

our subset ClutterFixedLayoutAncestry is export of Mu
  where ClutterFixedLayout | ClutterLayoutManager;

class Clutter::FixedLayout is Clutter::LayoutManager {
  has ClutterFixedLayout $!cfl;

  submethod BUILD (:$fixed) {
    given $fixed {
      when ClutterFixedLayoutAncestry {
        my $to-parent;
        $!cfl = do {
          when ClutterFixedLayout {
            $to-parent = cast(ClutterLayoutManager, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterFixedLayout, $_);
          }
        };
        self.setLayoutManager($to-parent);
      }

      when Clutter::FixedLayout {
      }

      default {
      }
    }
  }

  method new {
    my $fixed = clutter_fixed_layout_new();

    $fixed ?? self.bless(:$fixed) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);
    
    unstable_get_type( self.^name, &clutter_fixed_layout_get_type, $n, $t );
  }

}

sub clutter_fixed_layout_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_fixed_layout_new ()
  returns ClutterLayoutManager
  is native(clutter)
  is export
{ * }
