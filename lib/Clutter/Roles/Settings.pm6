use v6.c;

use Method::Also;

use NativeCall;

use Clutter::Raw::Types;

use GLib::Value;

use GLib::Roles::Object;

role Clutter::Roles::Settings {
  also does GLib::Roles::Object;

  has ClutterSettings $!c-set;

  # submethod BUILD (:$settings) {
  #   $!c-set = $settings;
  # }

  method Clutter::Raw::Definitions::ClutterSettings
    is also<
      Settings
      ClutterSettings
    >
  { $!c-set }

  method roleInit-ClutterContainer is also<roleInit_ClutterContainer> {
    my \i = findProperImplementor(self.^attributes);

    $!c-set = cast( ClutterSettings, i.get_value(self) );
  }

  method get_settings_default (::?CLASS:U:) is also<get-settings-default> {
    my $settings = clutter_settings_get_default();

    $settings ?? self.bless(:$settings) !! Nil;
  }

  method setSettings(ClutterSettings $settings) {
    #self.IS-PROTECTED;
    self!setObject( cast(GObject, $settings) );
  }

  # Type: ClutterBackend
  method backend is rw is DEPRECATED {
    my GLib::Value $gv .= new( ::('Clutter::Backend').get-type );
    Proxy.new(
      FETCH => sub ($) {
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
  method dnd-drag-threshold is rw  is also<dnd_drag_threshold> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method double-click-distance is rw  is also<double_click_distance> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method double-click-time is rw  is also<double_click_time> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-antialias is rw  is also<font_antialias> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-dpi is rw  is also<font_dpi> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-hint-style is rw  is also<font_hint_style> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-hinting is rw  is also<font_hinting> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-name is rw  is also<font_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method font-subpixel-order is rw  is also<font_subpixel_order> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method fontconfig-timestamp is rw  is also<fontconfig_timestamp> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
  method long-press-duration is rw  is also<long_press_duration> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method password-hint-time is rw  is also<password_hint_time> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
  method unscaled-font-dpi is rw  is also<unscaled_font_dpi> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method window-scaling-factor is rw  is also<window_scaling_factor> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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

  method cluttersettings_get_type is also<cluttersettings-get-type> {
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
