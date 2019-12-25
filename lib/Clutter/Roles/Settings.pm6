use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GLib::Value;

use GTK::Roles::Properties;

role Clutter::Roles::Settings {
  also does GTK::Roles::Properties;

  has ClutterSettings $!c-set;

  method Clutter::Raw::Types::ClutterSettings
    is also<Settings>
  { $!c-set }

  method get_settings_default {
    self.setSettings( $!c-set = clutter_settings_get_default() );
  }

  method setSettings(ClutterSettings $settings) {
    self.IS-PROTECTED;
    self!setObject( cast(GObject, $settings) );
  }

  # Type: ClutterBackend
  method backend is rw is DEPRECATED {
    my GLib::Value $gv .= new( ::('Clutter::Backend').get-type );
    Proxy.new(
      FETCH => -> $ {
        warn 'backend does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, ClutterBackend() $val is copy {
        $gv.object = $val;
        self.prop_set('backend', $gv);
      }
    );
  }

  # Type: gint
  method dnd-drag-threshold is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('dnd-drag-threshold', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('dnd-drag-threshold', $gv);
      }
    );
  }

  # Type: gint
  method double-click-distance is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('double-click-distance', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('double-click-distance', $gv);
      }
    );
  }

  # Type: gint
  method double-click-time is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('double-click-time', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('double-click-time', $gv);
      }
    );
  }

  # Type: gint
  method font-antialias is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-antialias', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('font-antialias', $gv);
      }
    );
  }

  # Type: gint
  method font-dpi is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-dpi', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('font-dpi', $gv);
      }
    );
  }

  # Type: gchar
  method font-hint-style is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-hint-style', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-hint-style', $gv);
      }
    );
  }

  # Type: gint
  method font-hinting is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-hinting', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('font-hinting', $gv);
      }
    );
  }

  # Type: gchar
  method font-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-name', $gv);
      }
    );
  }

  # Type: gchar
  method font-subpixel-order is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('font-subpixel-order', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-subpixel-order', $gv);
      }
    );
  }

  # Type: guint
  method fontconfig-timestamp is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        warn 'fontconfig-timestamp does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('fontconfig-timestamp', $gv);
      }
    );
  }

  # Type: gint
  method long-press-duration is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('long-press-duration', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('long-press-duration', $gv);
      }
    );
  }

  # Type: guint
  method password-hint-time is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('password-hint-time', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('password-hint-time', $gv);
      }
    );
  }

  # Type: gint
  method unscaled-font-dpi is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        warn 'unscaled-font-dpi does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('unscaled-font-dpi', $gv);
      }
    );
  }

  # Type: gint
  method window-scaling-factor is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('window-scaling-factor', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('window-scaling-factor', $gv);
      }
    );
  }

  method settings_get_type {
    state ($n, $t);
    unstable_get_type(
      'Clutter::Roles::Settings', &clutter_settings_get_type, $n, $t
    );
  }
}

sub clutter_settings_get_default ()
  returns ClutterSettings
  is native(clutter)
  is export
{ * }

sub clutter_settings_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }
