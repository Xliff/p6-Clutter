use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Roles::Signals::Stage;

our subset ClutterStageAncestry is export of Mu
  where ClutterStage | ClutterGroupAncestry;

use Clutter::Raw::Stage is Clutter::Group {
  also does Clutter::Roles::Signals::Stage;

  has ClutterStage $!cs;

  submethod BUILD (:$stage) {
    self.setGroup( cast(ClutterGroup, $!cs = $stage) );
  }

  multi method new (ClutterStageAncestry $stage) {
    self.bless( :$stage );
  }
  multi method new {
    self.bless( stage => clutter_stage_new() );
  }

  # Type: gboolean
  method accept-focus is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('accept-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accept-focus', $gv);
      }
    );
  }

  # Type: ClutterColor
  method color is rw
    is DEPRECATED<the “background-color” property of ClutterActor>
  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('color', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('color', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-visible is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-visible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('cursor-visible', $gv);
      }
    );
  }

  # Type: ClutterFog
  method fog is rw  is DEPRECATED {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fog', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('fog', $gv);
      }
    );
  }

  # Type: gboolean
  method fullscreen-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fullscreen-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "fullscreen-set does not allow writing"
      }
    );
  }

  # Type: ClutterActor
  method key-focus is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('key-focus', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('key-focus', $gv);
      }
    );
  }

  # Type: gboolean
  method no-clear-hint is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('no-clear-hint', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('no-clear-hint', $gv);
      }
    );
  }

  # Type: gboolean
  method offscreen is rw  is DEPRECATED {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('offscreen', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('offscreen', $gv);
      }
    );
  }

  # Type: ClutterPerspective
  method perspective is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('perspective', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('perspective', $gv);
      }
    );
  }

  # Type: gchar
  method title is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('title', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: gboolean
  method use-alpha is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('use-alpha', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-alpha', $gv);
      }
    );
  }

  # Type: gboolean
  method use-fog is rw  is DEPRECATED {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('use-fog', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-fog', $gv);
      }
    );
  }

  # Type: gboolean
  method user-resizable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('user-resizable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('user-resizable', $gv);
      }
    );
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method activate {
    self.connect($!w, 'activate');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method after-paint {
    self.connect($!w, 'after-paint');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method deactivate {
    self.connect($!w, 'deactivate');
  }

  # Is originally:
  # ClutterStage, ClutterEvent, gpointer --> gboolean
  method delete-event {
    self.connec-event($!w, 'delete-event');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method fullscreen {
    self.connect($!w, 'fullscreen');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method unfullscreen {
    self.connect($!w, 'unfullscreen');
  }

  method clutter_fog_get_type {
    clutter_fog_get_type();
  }

  method clutter_perspective_get_type {
    clutter_perspective_get_type();
  }

  method ensure_current {
    clutter_stage_ensure_current($!cs);
  }

  method ensure_redraw {
    clutter_stage_ensure_redraw($!cs);
  }

  method ensure_viewport {
    clutter_stage_ensure_viewport($!cs);
  }

  method event (ClutterEvent $event) {
    clutter_stage_event($!cs, $event);
  }

  method get_actor_at_pos (ClutterPickMode $pick_mode, gint $x, gint $y) {
    clutter_stage_get_actor_at_pos($!cs, $pick_mode, $x, $y);
  }

  method get_minimum_size (guint $width, guint $height) {
    clutter_stage_get_minimum_size($!cs, $width, $height);
  }

  method get_perspective (ClutterPerspective $perspective) {
    clutter_stage_get_perspective($!cs, $perspective);
  }

  method get_redraw_clip_bounds (cairo_rectangle_int_t $clip) {
    clutter_stage_get_redraw_clip_bounds($!cs, $clip);
  }

  method get_type {
    clutter_stage_get_type();
  }

  method hide_cursor {
    clutter_stage_hide_cursor($!cs);
  }

  method read_pixels (gint $x, gint $y, gint $width, gint $height) {
    clutter_stage_read_pixels($!cs, $x, $y, $width, $height);
  }

  method set_minimum_size (guint $width, guint $height) {
    clutter_stage_set_minimum_size($!cs, $width, $height);
  }

  method set_perspective (ClutterPerspective $perspective) {
    clutter_stage_set_perspective($!cs, $perspective);
  }

  method set_sync_delay (gint $sync_delay) {
    clutter_stage_set_sync_delay($!cs, $sync_delay);
  }

  method show_cursor {
    clutter_stage_show_cursor($!cs);
  }

  method skip_sync_delay {
    clutter_stage_skip_sync_delay($!cs);
  }

}
