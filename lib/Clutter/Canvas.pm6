use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use GLib::Value;

use GTK::Roles::Properties;
use Clutter::Roles::Signals::Canvas;
use Clutter::Roles::Content;

our subset CanvasAncestry is export
  where ClutterCanvas | ClutterContent;

class Clutter::Canvas {
  also does GTK::Roles::Properties;
  also does Clutter::Roles::Content;
  also does Clutter::Roles::Signals::Canvas;

  has ClutterCanvas $!cc;

  submethod BUILD (:$canvas) {
    given $canvas {
      when CanvasAncestry {
        $!cc = do {
          when ClutterCanvas {
            $_;
          }
          when ClutterContent {
            $!c-con = $_;
            cast(ClutterCanvas, $_);
          }
        }
        $!c-con //= cast(ClutterContent, $_); # Clutter::Roles::Content
        self!setObject( cast(GObject, $!cc = $canvas) );
      }
      when Clutter::Canvas {
      }
      default {
      }
    }
  }

  multi method new (CanvasAncestry $canvas) {
    self.bless(:$canvas);
  }
  multi method new {
    self.bless( canvas => clutter_canvas_new() );
  }

  # Is originally:
  # ClutterCanvas, CairoContext, gint, gint, gpointer --> gboolean
  method draw {
    self.connect-draw($!cc);
  }

  method scale_factor is rw is also<scale-factor> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_canvas_get_scale_factor($!cc);
      },
      STORE => sub ($, Int() $scale is copy) {
        my gint $s = resolve-int($scale);
        clutter_canvas_set_scale_factor($!cc, $s);
      }
    );
  }

  # Type: gint
  method height is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('height', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: gboolean
  method scale-factor-set is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('scale-factor-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scale-factor-set does not allow writing'
      }
    );
  }

  # Type: gint
  method width is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('width', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_canvas_get_type, $n, $t);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my gint ($w, $h) = resolve-int($width, $height);
    so clutter_canvas_set_size($!cc, $w, $h);
  }

}

sub clutter_canvas_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_canvas_new ()
  returns ClutterCanvas
  is native(clutter)
  is export
{ * }

sub clutter_canvas_set_size (ClutterCanvas $canvas, gint $width, gint $height)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_canvas_get_scale_factor (ClutterCanvas $canvas)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_canvas_set_scale_factor (ClutterCanvas $canvas, gint $scale)
  is native(clutter)
  is export
{ * }
