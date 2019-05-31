use v6.c;

use Method::Also;

use Cairo;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Roles::Signals::Stage;

# our subset ClutterStageAncestry is export of Mu
#   where ClutterStage | ClutterGroupAncestry;

use Clutter::Raw::Boxed;
use Clutter::Raw::Stage;

use Clutter::Actor;

my @attributes = <
  accept-focus     accept_focus
  color
  cursor-visible   cursor_visible
  fog
  fullscreen-set   fullscreen_set
  key-focus        key_focus
  no-clear-hint    no_clear_hint
  offscreen
  perspective
  title
  use-alpha        use_alpha
  use-fog          use_fog
  user-resizable   user_resizable
>;

my @set_methods = <
  minimum_size            minimum-size
  perspective
  sync_delay              sync-delay
>;

class Clutter::Stage is Clutter::Actor {
  also does Clutter::Roles::Signals::Stage;

  has ClutterStage $!cs;

  submethod BUILD (:$stage) {
    self.setActor( cast(ClutterActor, $!cs = $stage) );
  }

  # Replace ancestry logic
  multi method new (ClutterStage $stage) {
    self.bless( :$stage );
  }
  multi method new {
    self.bless( stage => clutter_stage_new() );
  }

  method setup(*%data) {
    for %data.keys {
      when @attributes.any {
        say "StA: {$_}";
        self."$_"() = %data{$_};
        %data{$_}:delete
      }
      when @set_methods.any {
        say "StSM: {$_}";
        self."set_{$_}"( %data{$_} );
        %data{$_}:delete
      }
    }
    # Not as clean as I like it, but it solves problems nextwith does NOT.
    self.Clutter::Actor::setup(|%data) if %data.keys.elems;
  }

  # Type: gboolean
  method accept-focus is rw  is also<accept_focus> {
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
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('color', $gv)
        );
        cast(ClutterColor, $gv.pointer);
      },
      STORE => -> $, ClutterColor $val is copy {
        $gv.pointer = $val;
        self.prop_set('color', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-visible is rw  is also<cursor_visible> {
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
  method fog is rw is DEPRECATED {
    my GTK::Compat::Value $gv .= new( Clutter::Boxed.fog_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fog', $gv)
        );
        cast(ClutterFog, $gv.boxed);
      },
      STORE => -> $, ClutterFog $val is copy {
        $gv.boxed = $val;
        self.prop_set('fog', $gv);
      }
    );
  }

  # Type: gboolean
  method fullscreen-set is rw  is also<fullscreen_set> {
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
  method key-focus is rw  is also<key_focus> {
    my GTK::Compat::Value $gv .= new( Clutter::Actor.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('key-focus', $gv)
        );
        Clutter::Actor.new( cast(ClutterActor, $gv.object) )
      },
      STORE => -> $, ClutterActor() $val is copy {
        $gv.object = $val;
        self.prop_set('key-focus', $gv);
      }
    );
  }

  # Type: gboolean
  method no-clear-hint is rw  is also<no_clear_hint> {
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
  method offscreen is rw is DEPRECATED {
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
    )
  }

  # Type: ClutterPerspective
  method perspective is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Boxed.perspective_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('perspective', $gv)
        );
        cast(ClutterPerspective, $gv.boxed);
      },
      STORE => -> $, ClutterPerspective $val is copy {
        $gv.boxed = $val;
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
  method use-alpha is rw  is also<use_alpha> {
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
  method use-fog is rw  is DEPRECATED is also<use_fog> {
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
  method user-resizable is rw  is also<user_resizable> {
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
    self.connect($!cs, 'activate');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method after-paint is also<after_paint> {
    self.connect($!cs, 'after-paint');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method deactivate {
    self.connect($!cs, 'deactivate');
  }

  # Is originally:
  # ClutterStage, ClutterEvent, gpointer --> gboolean
  method delete-event is also<delete_event> {
    self.connec-event($!cs, 'delete-event');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method fullscreen {
    self.connect($!cs, 'fullscreen');
  }

  # Is originally:
  # ClutterStage, gpointer --> void
  method unfullscreen {
    self.connect($!cs, 'unfullscreen');
  }

  method ensure_current is also<ensure-current> {
    clutter_stage_ensure_current($!cs);
  }

  method ensure_redraw is also<ensure-redraw> {
    clutter_stage_ensure_redraw($!cs);
  }

  method ensure_viewport is also<ensure-viewport> {
    clutter_stage_ensure_viewport($!cs);
  }

  method event (ClutterEvent() $event) {
    clutter_stage_event($!cs, $event);
  }

  method get_actor_at_pos (
    Int() $pick_mode, # ClutterPickMode $pick_mode,
    Int() $x,
    Int() $y
  )
    is also<get-actor-at-pos>
  {
    my guint $pm = resolve-uint($pick_mode);
    my gint ($xx, $yy) = resolve-int($x, $y);
    clutter_stage_get_actor_at_pos($!cs, $pm, $xx, $yy);
  }

  method get_minimum_size (Int() $width, Int() $height)
    is also<get-minimum-size>
  {
    my guint ($w, $h) = resolve-uint($width, $height);
    clutter_stage_get_minimum_size($!cs, $width, $height);
  }

  method get_perspective (ClutterPerspective $perspective)
    is also<get-perspective>
  {
    clutter_stage_get_perspective($!cs, $perspective);
  }

  proto method get_redraw_clip_bounds (|)
    is also<get-redraw-clip-bounds>
  { * }

  multi method get_redraw_clip_bounds (cairo_rectangle_int_t $clip) {
    clutter_stage_get_redraw_clip_bounds($!cs, $clip);
  }
  multi method get_redraw_clip_bounds (%clip) {
    die 'Invalid hash value passed to Clutter::Stage.get_redraw_clip_bounds'
      unless
        %clip<x y width height>.all.defined &&
        %clip<x y width height>.all ~~ Int;

    my $clip = cairo_rectangle_int_t.new;
    $clip.x      = %clip<x>;
    $clip.y      = %clip<y>;
    $clip.width  = %clip<width>;
    $clip.height = %clip<height>;

    samewith($clip);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_stage_get_type, $n, $t );
  }

  method hide_cursor is also<hide-cursor> {
    clutter_stage_hide_cursor($!cs);
  }

  method read_pixels (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  )
    is also<read-pixels>
  {
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);
    clutter_stage_read_pixels($!cs, $xx, $yy, $w, $h);
  }

  method set_minimum_size (Int() $width, Int() $height)
    is also<set-minimum-size>
  {
    my guint ($w, $h) = resolve-uint($width, $height);
    clutter_stage_set_minimum_size($!cs, $w, $h);
  }

  method set_perspective (ClutterPerspective $perspective)
    is also<set-perspective>
  {
    clutter_stage_set_perspective($!cs, $perspective);
  }

  method set_sync_delay (Int() $sync_delay)
    is also<set-sync-delay>
  {
    my gint $sd = resolve-int($sync_delay);
    clutter_stage_set_sync_delay($!cs, $sd);
  }

  method show_cursor is also<show-cursor> {
    clutter_stage_show_cursor($!cs);
  }

  method skip_sync_delay is also<skip-sync-delay> {
    clutter_stage_skip_sync_delay($!cs);
  }

}
