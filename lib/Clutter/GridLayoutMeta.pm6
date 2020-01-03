use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GLib::Value;
use Clutter::LayoutMeta;

use GTK::Roles::Properties;

# This is a made up object to accomodate for the differences between

our subset GridLayoutMetaAncestry of Mu
  where ClutterGridLayoutMeta | LayoutMetaAncestry;

class Clutter::GridLayoutMeta is Clutter::LayoutMeta {
  has ClutterGridLayoutMeta $!cl-gridmeta;
  has GObject $!prop;

  submethod BUILD (:$gridmetalayout) {
    given $gridmetalayout {
      when GridLayoutMetaAncestry {
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
        };
        $!prop = cast(GObject, $_);
        self.setLayoutMeta($to-parent);
      }
      when Clutter::GridLayoutMeta {
      }
      default {
      }
    }
  }

  method new (GridLayoutMetaAncestry $gridmetalayout) {
    # No GLib::Roles::References
    # No destroy yet, so no upref logic.
    self.bless(:$gridmetalayout);
  }

  method get_manager is also<get-manager> {
    ::('Clutter::GridLayoutManager').new(
      clutter_layout_meta_get_manager(self.LayoutMeta)
    );
  }

  # ↓↓↓↓ MECHANISM MUST BE MOVED BACK INTO GTK PROPER! ↓↓↓↓
  method prop_get(Str() $key, GValue() $v) {
    g_object_get_property($!prop, $key, $v);
  }

  method prop_set(Str() $key, GValue() $v) {
    g_object_get_property($!prop, $key, $v);
  }
  # ↑↑↑↑ MECHANISM MUST BE MOVED BACK INTO GTK PROPER! ↑↑↑↑

  method left is rw {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
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
      FETCH => -> $ {
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
      FETCH => -> $ {
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
      FETCH => -> $ {
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

# ↓↓↓↓ MECHANISM MUST BE MOVED BACK INTO GTK PROPER! ↓↓↓↓
sub g_object_set_property (
  GObject $object,
  Str $property_name,
  GValue $value
)
  is native(gobject)
  is export
{ * }

sub g_object_get_property (
  GObject $object,
  Str $property_name,
  GValue $value
)
  is native(gobject)
  is export
{ * }
# ↑↑↑↑ MECHANISM MUST BE MOVED BACK INTO GTK PROPER! ↑↑↑↑
