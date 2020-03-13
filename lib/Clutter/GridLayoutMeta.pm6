use v6.c;

use Method::Also;

use Clutter::Raw::Types;

use GLib::Value;
use Clutter::LayoutMeta;

use GLib::Roles::Object;

# This is a made up object to accomodate for the top, left, width and height
# attributes that are not supported in ClutterLayoutMeta.
#
# Note that this may no longer be necessary with the GLib-separation and the
# enhanced GLib::Roles::Object. This should be tested at a later date.
# cw - 2020-02-15

our subset ClutterGridLayoutMetaAncestry of Mu
  where ClutterGridLayoutMeta | ClutterLayoutMetaAncestry;

class Clutter::GridLayoutMeta is Clutter::LayoutMeta {
  has ClutterGridLayoutMeta $!cl-gridmeta;

  submethod BUILD (:$gridlayoutmeta) {
    given $gridlayoutmeta {
      when ClutterGridLayoutMetaAncestry {
        my $to-parent;
        $!cl-gridmeta = do {
          when ClutterGridLayoutMeta {
            $to-parent = cast(ClutterLayoutMeta, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterGridLayoutMeta, $_);
          }
        }
        self.setLayoutMeta($to-parent);
      }

      when Clutter::GridLayoutMeta {
      }

      default {
      }
    }
  }

  method new (ClutterGridLayoutMetaAncestry $gridlayoutmeta) {
    $gridlayoutmeta ?? self.bless(:$gridlayoutmeta) !! Nil
  }

  method get_manager (:$raw = False) is also<get-manager> {
    my $glm = clutter_layout_meta_get_manager(self.LayoutMeta);

    $glm ??
      ( $raw ?? $glm !! ::('Clutter::GridLayoutManager').new($glm) )
      !!
      Nil;
  }

  method left is rw {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left-attach', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('left-attach', $gv);
      }
    );
  }

  method top is rw {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('top-attach', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('top-attach', $gv);
      }
    );
  }

  method width is rw {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # cw: -YYY- Use $prop in future versions!
  method height is rw {
    my GLib::Value $gv .= new( G_TYPE_INT );
    my $prop = 'height';
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get($prop, $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set($prop, $gv);
      }
    );
  }

}
