use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Actor;

use GTK::Roles::Protection;

use Clutter::Roles::Animatable;
use Clutter::Roles::Container;
use Clutter::Roles::Scriptable;
use Clutter::Roles::Signals::Actor;

class Clutter::Actor {
  also does GTK::Roles::Protection;
  also does Clutter::Roles::Animatable;
  also does Clutter::Roles::Container;
  also does Clutter::Roles::Scriptable;
  also does Clutter::Roles::Signals::Actor;

  has ClutterActor $!a;

  submethod BUILD (:$actor) {
    self.ADD-PREFIX('Clutter::');
    self.setClutterActor($actor);
  }

  method Clutter::Raw::Type::ClutterActor
    is also<
      ClutterActor
      Actor
    >
  { $!a }

  method setClutterActor ($actor) {
    self.IS-PROTECTED;
    $!a = $actor;
    self.setAnimatable( cast(ClutterActor, $!a) );      # Clutter::Roles::Animatable
    self.setContainer( cast(ClutterContainer, $!a) );   # Clutter::Roles::Container
    self.setScriptable( cast(ClutterScriptable, $!a) ); # Clutter::Roles::Scriptable
  }

  multi method new (ClutterActor $actor) {
    self.setClutterActor($actor);
  }
  method new {
    clutter_actor_new();
  }

  # Is originally:
  # ClutterActor, ClutterActorBox, ClutterAllocationFlags, gpointer --> void
  method allocation-changed {
    self.connect-allocation-changed($!a);
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method button-press-event {
    self.connect-clutter-event($!a, 'button-press-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method button-release-event {
    self.connect-clutter-event($!a, 'button-release-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method captured-event {
    self.connect-clutter-event($!a, 'captured-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method destroy {
    self.connect($!a, 'destroy');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method enter-event {
    self.connect-clutter-event($!a, 'enter-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method event {
    self.connect-clutter-event($!a, 'event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method hide {
    self.connect($!a, 'hide');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method key-focus-in {
    self.connect($!a, 'key-focus-in');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method key-focus-out {
    self.connect($!a, 'key-focus-out');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method key-press-event {
    self.connect-clutter-event($!a, 'key-press-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method key-release-event {
    self.connect-clutter-event($!a, 'key-release-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method leave-event {
    self.connect-clutter-event($!a, 'leave-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method motion-event {
    self.connect-clutter-event($!a, 'motion-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method paint {
    self.connect($!a, 'paint');
  }

  # Is originally:
  # ClutterActor, ClutterActor, gpointer --> void
  method parent-set {
    self.connect-parent-set($!a);
  }

  # Is originally:
  # ClutterActor, ClutterColor, gpointer --> void
  method pick {
    self.connect-pick($!a);
  }

  # Is originally:
  # void, void
  method queue-redraw {
    self.connect($!a, 'queue-redraw');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method queue-relayout {
    self.connect($!a, 'queue-relayout');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method realize {
    self.connect($!a, 'realize');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method scroll-event {
    self.connect-clutter-event($!a, 'scroll-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method show {
    self.connect($!a, 'show');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method touch-event {
    self.connect-clutter-event($!a, 'touch-event');
  }

  # Is originally:
  # ClutterActor, gchar, gboolean, gpointer --> void
  method transition-stopped {
    self.connect-transition-stopped($!a);
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method transitions-completed {
    self.connect($!a, 'transitions-completed');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method unrealize {
    self.connect($!a, 'unrealize');
  }

  # Type: ClutterAction
  method actions is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Action.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn "actions does not allow reading" if $DEBUG;
        0;
      },
      STORE => -> $, ClutterAction() $val is copy {
        $gv.object = $val;
        self.prop_set('actions', $gv);
      }
    );
  }

  # Type: ClutterActorBox
  method allocation is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.actor_box_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('allocation', $gv)
        );
        cast(ClutterActorBox, $gv.boxed);
      },
      STORE => -> $, $val is copy {
        warn 'allocation does not allow writing'
      }
    );
  }

  # Type: ClutterGravity
  method anchor-gravity is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('anchor-gravity', $gv)
        );
        ClutterGravity( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.guint = $val;
        self.prop_set('anchor-gravity', $gv);
      }
    );
  }

  # Type: gfloat
  method anchor-x is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('anchor-x', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('anchor-x', $gv);
      }
    );
  }

  # Type: gfloat
  method anchor-y is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('anchor-y', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('anchor-y', $gv);
      }
    );
  }

  # Type: ClutterColor
  method background-color is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('background-color', $gv)
        );
        Clutter::Color.new($gv.boxed)
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('background-color', $gv);
      }
    );
  }

  # Type: gboolean
  method background-color-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('background-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "background-color-set does not allow writing"
      }
    );
  }

  # Type: ClutterMatrix
  method child-transform is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('child-transform', $gv)
        );
        cast(ClutterMatrix, $gv.pointer)
      },
      STORE => -> $, ClutterMatrix() $val is copy {
        $gv.pointer = $val;
        self.prop_set('child-transform', $gv);
      }
    );
  }

  # Type: gboolean
  method child-transform-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('child-transform-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "child-transform-set does not allow writing"
      }
    );
  }

  # Type: ClutterGeometry
  # method clip is rw  is DEPRECATED( “clip-rect” ) {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('clip', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('clip', $gv);
  #     }
  #   );
  # }

  # Type: ClutterRect
  method clip-rect is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.rect_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('clip-rect', $gv)
        );
        cast(ClutterRect, $gv.boxed);
      },
      STORE => -> $, ClutterRect $val is copy {
        $gv.boxed = $val;
        self.prop_set('clip-rect', $gv);
      }
    );
  }

  # Type: gboolean
  method clip-to-allocation is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('clip-to-allocation', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('clip-to-allocation', $gv);
      }
    );
  }

  # Type: ClutterConstraint
  method constraints is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Constraint.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn "constraints does not allow reading" if $DEBUG;
        0;
      },
      STORE => -> $, ClutterConstraint() $val is copy {
        $gv.object = $val;
        self.prop_set('constraints', $gv);
      }
    );
  }

  # Type: ClutterContent
  method content is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Content.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('content', $gv)
        );
        Clutter::Content.new( cast(ClutterContent, $gv.pointer) );
      },
      STORE => -> $, ClutterContent() $val is copy {
        $gv.pointer = $val;
        self.prop_set('content', $gv);
      }
    );
  }

  # Type: ClutterActorBox
  method content-box is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.actor_box_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('content-box', $gv)
        );
        cast(ClutterActorBox, $gv.boxed);
      },
      STORE => -> $, $val is copy {
        warn 'content-box does not allow writing'
      }
    );
  }

  # Type: ClutterContentGravity
  method content-gravity is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.content_gravity_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('content-gravity', $gv)
        );
        ClutterContentGravity( $gv.enum )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('content-gravity', $gv);
      }
    );
  }

  # Type: ClutterContentRepeat
  method content-repeat is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.content_repeat_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('content-repeat', $gv)
        );
        ClutterContentRepeatType( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('content-repeat', $gv);
      }
    );
  }

  # Type: gfloat
  method depth is rw  is DEPRECATED( “z-position” ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('depth', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('depth', $gv);
      }
    );
  }

  # Type: ClutterEffect
  method effect is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Effect.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn 'effect does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, ClutterEffect() $val is copy {
        $gv.object = $val;
        self.prop_set('effect', $gv);
      }
    );
  }

  # Type: ClutterActor
  method first-child is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Actor.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('first-child', $gv)
        );
        Clutter::Actor.new( $gv.object )
      },
      STORE => -> $, $val is copy {
        warn 'first-child does not allow writing'
      }
    );
  }

  # Type: gboolean
  method fixed-position-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fixed-position-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fixed-position-set', $gv);
      }
    );
  }

  # Type: gfloat
  method fixed-x is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fixed-x', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('fixed-x', $gv);
      }
    );
  }

  # Type: gfloat
  method fixed-y is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fixed-y', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('fixed-y', $gv);
      }
    );
  }

  # Type: gboolean
  method has-clip is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-clip', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "has-clip does not allow writing"
      }
    );
  }

  # Type: gboolean
  method has-pointer is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-pointer', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "has-pointer does not allow writing"
      }
    );
  }

  # Type: gfloat
  method height is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('height', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: ClutterActor
  method last-child is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Actor.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('last-child', $gv)
        );
        Clutter::Actor.new( $gv.object );
      },
      STORE => -> $,  $val is copy {
        warn 'last-child does not allow writing'
      }
    );
  }

  # Type: ClutterLayoutManager
  method layout-manager is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::LayoutManager.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('layout-manager', $gv)
        );
        Clutter::LayoutManager( $gv.object );
      },
      STORE => -> $, ClutterLayoutManager() $val is copy {
        $gv.object = $val;
        self.prop_set('layout-manager', $gv);
      }
    );
  }

  # Type: ClutterScalingFilter
  method magnification-filter is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.scaling_filter_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('magnification-filter', $gv)
        );
        CluttrerScalingFilter( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('magnification-filter', $gv);
      }
    );
  }

  # Type: gboolean
  method mapped is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('mapped', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "mapped does not allow writing"
      }
    );
  }

  # Type: gfloat
  method margin-bottom is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('margin-bottom', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('margin-bottom', $gv);
      }
    );
  }

  # Type: gfloat
  method margin-left is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('margin-left', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('margin-left', $gv);
      }
    );
  }

  # Type: gfloat
  method margin-right is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('margin-right', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('margin-right', $gv);
      }
    );
  }

  # Type: gfloat
  method margin-top is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('margin-top', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('margin-top', $gv);
      }
    );
  }

  # Type: gfloat
  method min-height is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('min-height', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('min-height', $gv);
      }
    );
  }

  # Type: gboolean
  method min-height-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('min-height-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('min-height-set', $gv);
      }
    );
  }

  # Type: gfloat
  method min-width is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('min-width', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('min-width', $gv);
      }
    );
  }

  # Type: gboolean
  method min-width-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('min-width-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('min-width-set', $gv);
      }
    );
  }

  # Type: ClutterScalingFilter
  method minification-filter is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.scaling_filter_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('minification-filter', $gv)
        );
        ClutterScalingFilter( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('minification-filter', $gv);
      }
    );
  }

  # Type: gchar
  method name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gfloat
  method natural-height is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('natural-height', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('natural-height', $gv);
      }
    );
  }

  # Type: gboolean
  method natural-height-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('natural-height-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('natural-height-set', $gv);
      }
    );
  }

  # Type: gfloat
  method natural-width is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('natural-width', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('natural-width', $gv);
      }
    );
  }

  # Type: gboolean
  method natural-width-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('natural-width-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('natural-width-set', $gv);
      }
    );
  }

  # Type: ClutterOffscreenRedirect
  method offscreen-redirect is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.offscreen_redirect_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('offscreen-redirect', $gv)
        );
        ClutterOffscreenRedirect( $gv.enum );
      },
      STORE => -> $, guint $val is copy {
        $gv.uint = $val;
        self.prop_set('offscreen-redirect', $gv);
      }
    );
  }

  # Type: guint
  method opacity is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('opacity', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('opacity', $gv);
      }
    );
  }

  # Type: ClutterPoint
  method pivot-point is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.point_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('pivot-point', $gv)
        );
        cast(ClutterPoint, $gv.boxed);
      },
      STORE => -> $, ClutterPoint $val is copy {
        $gv.boxed = $val;
        self.prop_set('pivot-point', $gv);
      }
    );
  }

  # Type: gfloat
  method pivot-point-z is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('pivot-point-z', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('pivot-point-z', $gv);
      }
    );
  }

  # Type: ClutterPoint
  method position is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Boxed.point_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('position', $gv)
        );
        cast(ClutterPoint, $gv.boxed);
      },
      STORE => -> $, ClutterPoint $val is copy {
        $gv.boxed = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  # Type: gboolean
  method reactive is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('reactive', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reactive', $gv);
      }
    );
  }

  # Type: gboolean
  method realized is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('realized', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "realized does not allow writing"
      }
    );
  }

  # Type: gdouble
  method rotation-angle-x is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-angle-x', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('rotation-angle-x', $gv);
      }
    );
  }

  # Type: gdouble
  method rotation-angle-y is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-angle-y', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('rotation-angle-y', $gv);
      }
    );
  }

  # Type: gdouble
  method rotation-angle-z is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-angle-z', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('rotation-angle-z', $gv);
      }
    );
  }

  Type: ClutterVertex
  method rotation-center-x is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-center-x', $gv)
        );
        Clutter::Vertex.new($gv.boxed);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-x', $gv);
      }
    );
  }

  # Type: ClutterVertex
  method rotation-center-y is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-center-y', $gv)
        );
        Clutter::Vertex.new($gv.boxed);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-y', $gv);
      }
    );
  }

  # Type: ClutterVertex
  method rotation-center-z is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-center-z', $gv)
        );
        Clutter::Vertex.new($gv.boxed);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val
        self.prop_set('rotation-center-z', $gv);
      }
    );
  }

  # Type: ClutterGravity
  method rotation-center-z-gravity is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-center-z-gravity', $gv)
        );
        ClutterGravity( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('rotation-center-z-gravity', $gv);
      }
    );
  }

  # Type: gfloat
  method scale-center-x is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-center-x', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('scale-center-x', $gv);
      }
    );
  }

  # Type: gfloat
  method scale-center-y is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-center-y', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('scale-center-y', $gv);
      }
    );
  }

  # Type: ClutterGravity
  method scale-gravity is rw  is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-gravity', $gv)
        );
        ClutterGravity( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('scale-gravity', $gv);
      }
    );
  }

  # Type: gdouble
  method scale-x is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-x', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale-x', $gv);
      }
    );
  }

  # Type: gdouble
  method scale-y is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-y', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale-y', $gv);
      }
    );
  }

  # Type: gdouble
  method scale-z is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('scale-z', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale-z', $gv);
      }
    );
  }

  # Type: gboolean
  method show-on-set-parent is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('show-on-set-parent', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-on-set-parent', $gv);
      }
    );
  }

  # Type: ClutterSize
  method size is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Size.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('size', $gv)
        );
        Clutter::Size.new($gv.boxed);
      },
      STORE => -> $, ClutterSize() $val is copy {
        $gv.boxed = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: ClutterTextDirection
  method text-direction is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.text_direction_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('text-direction', $gv)
        );
        ClutterTextDirection( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('text-direction', $gv);
      }
    );
  }

  # Type: ClutterMatrix
  method transform is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('transform', $gv)
        );
        cast(ClutterMatrix, $gv.pointer);
      },
      STORE => -> $, ClutterMatrix() $val is copy {
        $gv.pointer = $val;
        self.prop_set('transform', $gv);
      }
    );
  }

  # Type: gboolean
  method transform-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('transform-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "transform-set does not allow writing"
      }
    );
  }

  # Type: gfloat
  method translation-x is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('translation-x', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('translation-x', $gv);
      }
    );
  }

  # Type: gfloat
  method translation-y is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('translation-y', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('translation-y', $gv);
      }
    );
  }

  # Type: gfloat
  method translation-z is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('translation-z', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('translation-z', $gv);
      }
    );
  }

  # Type: gboolean
  method visible is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('visible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible', $gv);
      }
    );
  }

  # Type: gfloat
  method width is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('width', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # Type: gfloat
  method x is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('x', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('x', $gv);
      }
    );
  }

  # Type: ClutterActorAlign
  method x-align is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.actor_align_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('x-align', $gv)
        );
        ClutterActorAlign( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('x-align', $gv);
      }
    );
  }

  # Type: gboolean
  method x-expand is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('x-expand', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('x-expand', $gv);
      }
    );
  }

  # Type: gfloat
  method y is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('y', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('y', $gv);
      }
    );
  }

  # Type: ClutterActorAlign
  method y-align is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.actor_align_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('y-align', $gv)
        );
        ClutterActorAlign( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('y-align', $gv);
      }
    );
  }

  # Type: gboolean
  method y-expand is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('y-expand', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('y-expand', $gv);
      }
    );
  }

  # Type: gfloat
  method z-position is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('z-position', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('z-position', $gv);
      }
    );
  }

  method add_child (ClutterActor() $child) is also<add-child> {
    clutter_actor_add_child($!a, $child);
  }

  method add_transition (Str() $name, ClutterTransition() $transition)
    is also<add-transition>
  {
    clutter_actor_add_transition($!a, $name, $transition);
  }

  method allocate (
    ClutterActorBox() $box,
    Int() $flags # ClutterAllocationFlags $flags
  ) {
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate($!a, $box, $f);
  }

  method allocate_align_fill (
    ClutterActorBox() $box,
    Num() $x_align,
    Num() $y_align,
    Int() $x_fill,
    Int() $y_fill,
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<allocate-align-fill>
  {
    my gdouble ($xa, $ya) = ($x_align, $y_align);
    my gboolean ($xf, $yf) = resolve-bool($x_fill, $y_fill);
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate_align_fill($!a, $box, $xa, $ya, $xf, $yf, $f);
    ;
  }

  method allocate_available_size (
    Num() $x,
    Num() $y,
    Num() $available_width,
    Num() $available_height,
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<allocate-available-size>
  {
    my gfloat ($xx, $yy, $aw, $ah)
      = ($x, $y, $available_width, $available_height);
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate_available_size($!a, $xx, $yy, $aw, $ah, $f);
  }

  method allocate_preferred_size (
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<allocate-preferred-size>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate_preferred_size($!a, $f);
  }

  method apply_relative_transform_to_point (
    ClutterActor() $ancestor,
    ClutterVertex() $point,
    ClutterVertex() $vertex
  )
    is also<apply-relative-transform-to-point>
  {
    clutter_actor_apply_relative_transform_to_point(
      $!a,
      $ancestor,
      $point,
      $vertex
    );
  }

  method apply_transform_to_point (
    ClutterVertex() $point,
    ClutterVertex() $vertex
  )
    is also<apply-transform-to-point>
  {
    clutter_actor_apply_transform_to_point($!a, $point, $vertex);
  }

  method bind_model (
    GListModel() $model,
    ClutterActorCreateChildFunc $create_child_func,
    gpointer $user_data    = Pointer,
    GDestroyNotify $notify = Pointer
  )
    is also<bind-model>
  {
    clutter_actor_bind_model(
      $!a,
      $model,
      $create_child_func,
      $user_data,
      $notify
    );
  }

  method contains (ClutterActor() $descendant) {
    clutter_actor_contains($!a, $descendant);
  }

  method continue_paint is also<continue-paint> {
    clutter_actor_continue_paint($!a);
  }

  method create_pango_context is also<create-pango-context> {
    clutter_actor_create_pango_context($!a);
  }

  method create_pango_layout (Str() $text) is also<create-pango-layout> {
    clutter_actor_create_pango_layout($!a, $text);
  }

  method destroy {
    clutter_actor_destroy($!a);
  }

  method destroy_all_children is also<destroy-all-children> {
    clutter_actor_destroy_all_children($!a);
  }

  method event (ClutterEvent() $event, Int() $capture) {
    my gboolean $c = resolve-bool($capture);
    clutter_actor_event($!a, $event, $capture);
  }

  method get_accessible is also<get-accessible> {
    clutter_actor_get_accessible($!a);
  }

  method get_allocation_box (ClutterActorBox() $box)
    is also<get-allocation-box>
  {
    clutter_actor_get_allocation_box($!a, $box);
  }

  method get_background_color (ClutterColor() $color)
    is also<get-background-color>
  {
    clutter_actor_get_background_color($!a, $color);
  }

  method get_child_at_index (Int() $index) is also<get-child-at-index> {
    my gint $i = resolve-int($index);
    clutter_actor_get_child_at_index($!a, $index_);
  }

  method get_child_transform (ClutterMatrix() $transform)
    is also<get-child-transform>
  {
    clutter_actor_get_child_transform($!a, $transform);
  }

  method get_children
    is also<
      get-children
      children
    >
  {
    clutter_actor_get_children($!a);
  }

  multi method get_clip {
    my ($xo, $yo, $w, $h) = 0 xx 4;
    samewith($xo, $yo, $w, $h);
  }
  method get_clip (
    Num() $xoff   is rw,
    Num() $yoff   is rw,
    Num() $width  is rw,
    Num() $height is rw
  )
    is also<get-clip>
  {
    my num32 ($xo, $yo, $w, $h) = ($xoff, $yoff, $width, $height);
    clutter_actor_get_clip($!a, $xo, $yo, $w, $h);
    ($xoff, $yoff, $width, $height) = ($xo, $yo, $w, $h);
  }

  method get_clip_to_allocation
    is also<
      get-clip-to-allocation
      clip_to_allocation
      clip-to-allocation
    >
  {
    clutter_actor_get_clip_to_allocation($!a);
  }

  method get_content
    is also<
      get-content
      content
    >
  {
    clutter_actor_get_content($!a);
  }

  method get_content_box (ClutterActorBox() $box)
    is also<
      get-content-box
      content_box
      content-box
    >
  {
    clutter_actor_get_content_box($!a, $box);
  }

  method get_content_gravity
    is also<
      get-content-gravity
      content_gravity
      content-gravity
    >
  {
    clutter_actor_get_content_gravity($!a);
  }

  method get_content_repeat
    is also<
      get-content-repeat
      content_repeat
      content-repeat
    >
  {
    clutter_actor_get_content_repeat($!a);
  }

  method get_content_scaling_filters (
    ClutterScalingFilter() $min_filter,
    ClutterScalingFilter() $mag_filter
  )
    is also<get-content-scaling-filters>
  {
    clutter_actor_get_content_scaling_filters($!a, $min_filter, $mag_filter);
  }

  method get_default_paint_volume
    is also<
      get-default-paint-volume
      default_paint_volume
      default-paint-volume
    >
  {
    clutter_actor_get_default_paint_volume($!a);
  }

  method get_easing_delay
    is also<
      get-easing-delay
      easing_delay
      easing-delay
    >
  {
    clutter_actor_get_easing_delay($!a);
  }

  method get_easing_duration
    is also<
      get-easing-duration
      easing_duration
      easing-duration
    >
  {
    clutter_actor_get_easing_duration($!a);
  }

  method get_easing_mode
    is also<
      get-easing-mode
      easing_mode
      easing-mode
    >
  {
    clutter_actor_get_easing_mode($!a);
  }

  method get_first_child
    is also<
      get-first-child
      first_child
      first-child
    >
  {
    clutter_actor_get_first_child($!a);
  }

  method get_fixed_position_set
    is also<
      get-fixed-position-set
      fixed_position_set
      fixed-position-set
    >
  {
    clutter_actor_get_fixed_position_set($!a);
  }

  method get_flags
    is also<
      get-flags
      flags
    >
  {
    clutter_actor_get_flags($!a);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    clutter_actor_get_height($!a);
  }

  method get_last_child
    is also<
      get-last-child
      last_child
      last-child
    >
  {
    clutter_actor_get_last_child($!a);
  }

  method get_layout_manager
    is also<
      get-layout-manager
      layout_manager
      layout-manager
    >
  {
    clutter_actor_get_layout_manager($!a);
  }

  method get_margin (ClutterMargin() $margin) is also<get-margin> {
    clutter_actor_get_margin($!a, $margin);
  }

  method get_margin_bottom
    is also<
      get-margin-bottom
      margin_bottom
      margin-bottom
    >
  {
    clutter_actor_get_margin_bottom($!a);
  }

  method get_margin_left
    is also<
      get-margin-left
      margin_left
      margin-left
    >
  {
    clutter_actor_get_margin_left($!a);
  }

  method get_margin_right
    is also<
      get-margin-right
      margin_right
      margin-right
    >
  {
    clutter_actor_get_margin_right($!a);
  }

  method get_margin_top
    is also<
      get-margin-top
      margin_top
      margin-top
    >
  {
    clutter_actor_get_margin_top($!a);
  }

  method get_n_children
    is also<
      get-n-children
      n_children
      n-children
      elems
    >
  {
    clutter_actor_get_n_children($!a);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    clutter_actor_get_name($!a);
  }

  method get_next_sibling
    is also<
      get-next-sibling
      next_sibling
      next-sibling
    >
  {
    clutter_actor_get_next_sibling($!a);
  }

  method get_offscreen_redirect
    is also<
      get-offscreen-redirect
      offscreen_redirect
      offscreen-redirect
    >
  {
    clutter_actor_get_offscreen_redirect($!a);
  }

  method get_opacity
    is also<
      get-opacity
      opacity
    >
  {
    clutter_actor_get_opacity($!a);
  }

  method get_opacity_override
    is also<
      get-opacity-override
      opacity_override
      opacity-override
    >
  {
    clutter_actor_get_opacity_override($!a);
  }

  method get_paint_box (ClutterActorBox() $box) is also<get-paint-box> {
    clutter_actor_get_paint_box($!a, $box);
  }

  method get_paint_opacity
    is also<
      get-paint-opacity
      paint_opacity
      paint-opacity
    >
  {
    clutter_actor_get_paint_opacity($!a);
  }

  method get_paint_visibility
    is also<
      get-paint-visibility
      paint_visibility
      paint-visibility
    >
  {
    clutter_actor_get_paint_visibility($!a);
  }

  method get_paint_volume
    is also<
      get-paint-volume
      paint_volume
      paint-volume
    >
  {
    clutter_actor_get_paint_volume($!a);
  }

  method get_pango_context
    is also<
      get-pango-context
      pango_context
      pango-context
    >
  {
    clutter_actor_get_pango_context($!a);
  }

  method get_parent
    is also<
      get-parent
      parent
    >
  {
    clutter_actor_get_parent($!a);
  }

  multi method get_pivot_point {
    my ($px, $py) = 0 xx 2;
    samewith($px, $py);
  }
  multi method get_pivot_point (
    Num() $pivot_x is rw,
    Num() $pivot_y is rw
  )
    is also<get-pivot-point>
  {
    my gfloat ($px, $py) = ($pivot_x, $pivot_y);
    clutter_actor_get_pivot_point($!a, $px, $py);
    ($pivot_x, $pivot_y) = ($px, $py);
  }

  method get_pivot_point_z
    is also<
      get-pivot-point-z
      pivot_point_z
      pivot-point-z
    >
  {
    clutter_actor_get_pivot_point_z($!a);
  }

  multi method get_position {
    my ($x, $y) = 0 xx 2;
    samewith($x, $y);
  }
  method get_position (
    Num() $x is rw,
    Num() $y is rw
  )
    is also<get-position>
  {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_get_position($!a, $yx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_preferred_height (
    Num() $for_width,
    Num() $min_height_p,
    Num() $natural_height_p
  )
    is also<get-preferred-height>
  {
    my gfloat ($fw, $mh, $nh) = ($for_width, $min_height_p, $natural_height_p);
    clutter_actor_get_preferred_height($!a, $fw, $mh, $nh);
  }

  method get_preferred_size (
    Num() $min_width_p,
    Num() $min_height_p,
    Num() $natural_width_p,
    Num() $natural_height_p
  )
    is also<get-preferred-size>
  {
    my gfloat ($mw, $mh, $nw, $nh) =
      ($min_width_p, $min_height_p, $natural_width_p, $natural_height_p)
    clutter_actor_get_preferred_size($!a, $mw, $mh, $nw, $nh);
  }

  method get_preferred_width (
    Num() $for_height,
    Num() $min_width_p,
    Num() $natural_width_p
  )
    is also<get-preferred-width>
  {
    my ($fh, $mw, $nw) = ($for_height, $min_width_p, $natural_width_p);
    clutter_actor_get_preferred_width($!a, $fh, $mw, $nw);
  }

  method get_previous_sibling
    is also<
      get-previous-sibling
      previous_sibling
      previous-sibling
    >
  {
    clutter_actor_get_previous_sibling($!a);
  }

  method get_reactive
    is also<
      get-reactive
      reactive
    >
  {
    clutter_actor_get_reactive($!a);
  }

  method get_request_mode
    is also<
      get-request-mode
      request_mode
      request-mode
    >
  {
    clutter_actor_get_request_mode($!a);
  }

  method get_rotation_angle (
    Int() $axis # ClutterRotateAxis $axis
  )
    is also<get-rotation-angle>
  {
    my guint $a = resolve-uint($axis);
    clutter_actor_get_rotation_angle($!a, $axis);
  }

  multi method get_scale {
    my ($sx, $sy) = 0 xx 2;
    samewith($sx, $sy);
  }
  multi method get_scale (
    Num() $scale_x is rw,
    Num() $scale_y is rw
  )
    is also<get-scale>
  {
    my gdouble ($sx, $sy) = ($scale_x, $scale_y);
    clutter_actor_get_scale($!a, $sx, $sy);
    ($scale_x, $scale_y) = ($sx, $sy);
  }

  method get_scale_z
    is also<
      get-scale-z
      scale_z
      scale-z
    >
  {
    clutter_actor_get_scale_z($!a);
  }

  multi method get_size {
    my ($w, $h) = 0 xx 2;
    samewith($w, $h);
  }
  multi method get_size (
    Num() $width  is rw,
    Num() $height is rw
  )
    is also<get-size>
  {
    my gfloat ($w, $h) = ($width, $height);
    clutter_actor_get_size($!a, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_stage
    is also<
      get-stage
      stage
    >
  {
    clutter_actor_get_stage($!a);
  }

  method get_text_direction
    is also<
      get-text-direction
      text_direction
      text-direction
    >
  {
    clutter_actor_get_text_direction($!a);
  }

  method get_transform (ClutterMatrix() $transform) is also<get-transform> {
    clutter_actor_get_transform($!a, $transform);
  }

  method get_transformed_paint_volume (
    ClutterActor() $relative_to_ancestor
  )
    is also<get-transformed-paint-volume>
  {
    clutter_actor_get_transformed_paint_volume($!a, $relative_to_ancestor);
  }

  multi method get_transformed_position {
    my ($x, $y) = 0 xx 2;
    samewith($x, $y);
  }
  multi method get_transformed_position (
    Num() $x is rw,
    Num() $y is rw
  )
    is also<get-transformed-position>
  {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_get_transformed_position($!a, $xx, $yy);
    ($x, $y) = ($xx, $tyy);
  }

  multi method get_transformed_size {
    my ($w, $h) = 0 xx 2;
    samewith($w, $h);
  }
  multi method get_transformed_size (
    Num() $width,
    Num() $height
  )
    is also<get-transformed-size>
  {
    my gfloat ($w, $h) = ($width, $height);
    clutter_actor_get_transformed_size($!a, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_transition (Str() $name) is also<get-transition> {
    Clutter::Transition.new( clutter_actor_get_transition($!a, $name) );
  }

  multi method get_translation {
    my ($x, $y, $z) = 0 xx 3;
    samewith($x, $y, $z);
  }
  multi method get_translation (
    Num() $translate_x is rw,
    Num() $translate_y is rw,
    Num() $translate_z is rw
  )
    is also<get-translation>
  {
    my gfloat ($tx, $ty, $tz) = ($translate_x, $translate_y, $translate_z);
    clutter_actor_get_translation($!a, $tx, $ty, $tz);
    ($translate_x, $translate_y, $translate_z) = ($tx, $ty, $tz);
  }

  method get_type is also<get-type> {
    state ($n, $t)
    unstable_get_type( self.^name, &clutter_actor_get_type, $n, $t );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    clutter_actor_get_width($!a);
  }

  method get_x
    is also<
      get-x
      x
    >
  {
    clutter_actor_get_x($!a);
  }

  method get_x_align
    is also<
      get-x-align
      x_align
      x-align
    >
  {
    clutter_actor_get_x_align($!a);
  }

  method get_x_expand
    is also<
      get-x-expand
      x_expand
      x-expand
    >
  {
    clutter_actor_get_x_expand($!a);
  }

  method get_y
    is also<
      get-y
      y
    >
  {
    clutter_actor_get_y($!a);
  }

  method get_y_align
    is also<
      get-y-align
      y_align
      y-align
    >
  {
    clutter_actor_get_y_align($!a);
  }

  method get_y_expand
    is also<
      get-y-expand
      y_expand
      y-expand
    >
  {
    clutter_actor_get_y_expand($!a);
  }

  method get_z_position
    is also<
      get-z-position
      z_position
      z-position
    >
  {
    clutter_actor_get_z_position($!a);
  }

  method grab_key_focus is also<grab-key-focus> {
    clutter_actor_grab_key_focus($!a);
  }

  method has_allocation is also<has-allocation> {
    so clutter_actor_has_allocation($!a);
  }

  method has_clip is also<has-clip> {
    so clutter_actor_has_clip($!a);
  }

  method has_key_focus is also<has-key-focus> {
    so clutter_actor_has_key_focus($!a);
  }

  method has_mapped_clones is also<has-mapped-clones> {
    so clutter_actor_has_mapped_clones($!a);
  }

  method has_overlaps is also<has-overlaps> {
    so clutter_actor_has_overlaps($!a);
  }

  method has_pointer is also<has-pointer> {
    so clutter_actor_has_pointer($!a);
  }

  method hide {
    clutter_actor_hide($!a);
  }

  method insert_child_above (ClutterActor() $child, ClutterActor() $sibling)
    is also<insert-child-above>
  {
    clutter_actor_insert_child_above($!a, $child, $sibling);
  }

  method insert_child_at_index (ClutterActor() $child, Int() $index)
    is also<insert-child-at-index>
  {
    my gint $i = resolve-int($index);
    clutter_actor_insert_child_at_index($!a, $child, $i);
  }

  method insert_child_below (ClutterActor() $child, ClutterActor() $sibling)
    is also<insert-child-below>
  {
    clutter_actor_insert_child_below($!a, $child, $sibling);
  }

  method is_in_clone_paint is also<is-in-clone-paint> {
    so clutter_actor_is_in_clone_paint($!a);
  }

  method is_mapped is also<is-mapped> {
    so clutter_actor_is_mapped($!a);
  }

  method is_realized is also<is-realized> {
    so clutter_actor_is_realized($!a);
  }

  method is_rotated is also<is-rotated> {
    so clutter_actor_is_rotated($!a);
  }

  method is_scaled is also<is-scaled> {
    so clutter_actor_is_scaled($!a);
  }

  method is_visible is also<is-visible> {
    so clutter_actor_is_visible($!a);
  }

  method iter_destroy is also<iter-destroy> {
    clutter_actor_iter_destroy($!a);
  }

  method iter_init (ClutterActor() $root) is also<iter-init> {
    clutter_actor_iter_init($!a, $root);
  }

  method iter_is_valid is also<iter-is-valid> {
    clutter_actor_iter_is_valid($!a);
  }

  method iter_next (ClutterActor() $child) is also<iter-next> {
    clutter_actor_iter_next($!a, $child);
  }

  method iter_prev (ClutterActor() $child) is also<iter-prev> {
    clutter_actor_iter_prev($!a, $child);
  }

  method iter_remove is also<iter-remove> {
    clutter_actor_iter_remove($!a);
  }

  method map {
    clutter_actor_map($!a);
  }

  method move_by (Num() $dx, Num() $dy) is also<move-by> {
    my gfloat ($ddx, $ddy) = ($dx, $dy);
    clutter_actor_move_by($!a, $ddx, $ddy);
  }

  method needs_expand (Int() $orientation) is also<needs-expand> {
    my guint $o = resolve-uint($orientation);
    clutter_actor_needs_expand($!a, $o);
  }

  method paint {
    clutter_actor_paint($!a);
  }

  method queue_redraw is also<queue-redraw> {
    clutter_actor_queue_redraw($!a);
  }

  method queue_redraw_with_clip (cairo_rectangle_int_t $clip)
    is also<queue-redraw-with-clip>
  {
    clutter_actor_queue_redraw_with_clip($!a, $clip);
  }

  method queue_relayout is also<queue-relayout> {
    clutter_actor_queue_relayout($!a);
  }

  method realize {
    clutter_actor_realize($!a);
  }

  method remove_all_children is also<remove-all-children> {
    clutter_actor_remove_all_children($!a);
  }

  method remove_all_transitions is also<remove-all-transitions> {
    clutter_actor_remove_all_transitions($!a);
  }

  method remove_child (ClutterActor() $child) is also<remove-child> {
    clutter_actor_remove_child($!a, $child);
  }

  method remove_clip is also<remove-clip> {
    clutter_actor_remove_clip($!a);
  }

  method remove_transition (Str() $name) is also<remove-transition> {
    clutter_actor_remove_transition($!a, $name);
  }

  method replace_child (
    ClutterActor() $old_child,
    ClutterActor() $new_child
  )
    is also<replace-child>
  {
    clutter_actor_replace_child($!a, $old_child, $new_child);
  }

  method restore_easing_state is also<restore-easing-state> {
    clutter_actor_restore_easing_state($!a);
  }

  method save_easing_state is also<save-easing-state> {
    clutter_actor_save_easing_state($!a);
  }

  method set_allocation (
    ClutterActorBox() $box,
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<set-allocation>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_set_allocation($!a, $box, $f);
  }

  method set_background_color (ClutterColor() $color)
    is also<set-background-color>
  {
    clutter_actor_set_background_color($!a, $color);
  }

  method set_child_above_sibling (
    ClutterActor() $child,
    ClutterActor() $sibling
  )
    is also<set-child-above-sibling>
  {
    clutter_actor_set_child_above_sibling($!a, $child, $sibling);
  }

  method set_child_at_index (ClutterActor() $child, Int() $index)
    is also<set-child-at-index>
  {
    my gint $i = resolve-int($index);
    clutter_actor_set_child_at_index($!a, $child, $i);
  }

  method set_child_below_sibling (
    ClutterActor() $child,
    ClutterActor() $sibling
  )
    is also<set-child-below-sibling>
  {
    clutter_actor_set_child_below_sibling($!a, $child, $sibling);
  }

  method set_child_transform (ClutterMatrix() $transform)
    is also<set-child-transform>
  {
    clutter_actor_set_child_transform($!a, $transform);
  }

  method set_clip (
    Num() $xoff,
    Num() $yoff,
    Num() $width,
    Num() $height
  )
    is also<set-clip>
  {
    my gfloat ($xo, $yo, $w, $h) = ($xoff, $yoff, $width, $height);
    clutter_actor_set_clip($!a, $xo, $yo, $w, $h);
  }

  method set_clip_to_allocation (Int() $clip_set)
    is also<set-clip-to-allocation>
  {
    my gboolean $c = resolve-bool($clip_set);
    clutter_actor_set_clip_to_allocation($!a, $clip_set);
  }

  method set_content (ClutterContent() $content) is also<set-content> {
    clutter_actor_set_content($!a, $content);
  }

  method set_content_gravity (
    Int() $gravity # ClutterContentGravity $gravity
  )
    is also<set-content-gravity>
  {
    my guint $g = resolve-uint($gravity);
    clutter_actor_set_content_gravity($!a, $g);
  }

  method set_content_repeat (
    Int() $repeat # ClutterContentRepeat $repeat
  )
    is also<set-content-repeat>
  {
    my guint $r = resolve-uint($repeat);
    clutter_actor_set_content_repeat($!a, $r);
  }

  method set_content_scaling_filters (
    ClutterScalingFilter() $min_filter,
    ClutterScalingFilter() $mag_filter
  )
    is also<set-content-scaling-filters>
  {
    clutter_actor_set_content_scaling_filters($!a, $min_filter, $mag_filter);
  }

  method set_easing_delay (Int() $msecs) is also<set-easing-delay> {
    my guint $ms = resolve-uint($msecs);
    clutter_actor_set_easing_delay($!a, $ms);
  }

  method set_easing_duration (guint $msecs) is also<set-easing-duration> {
    my guint $ms = resolve-uint($msecs);
    clutter_actor_set_easing_duration($!a, $ms);
  }

  method set_easing_mode (
    Int() $mode # ClutterAnimationMode $mode
  )
    is also<set-easing-mode>
  {
    my guint $m = resolve-uint($mode);
    clutter_actor_set_easing_mode($!a, $m);
  }

  method set_fixed_position_set (Int() $is_set)
    is also<set-fixed-position-set>
  {
    my gboolean $is = resolve-bool($is_set);
    clutter_actor_set_fixed_position_set($!a, $is);
  }

  method set_flags (
    Int() $flags # ClutterActorFlags $flags
  )
    is also<set-flags>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_set_flags($!a, $f);
  }

  method set_height (Num() $height) is also<set-height> {
    my gfloat $h = $height
    clutter_actor_set_height($!a, $h);
  }

  method set_layout_manager (ClutterLayoutManager() $manager)
    is also<set-layout-manager>
  {
    clutter_actor_set_layout_manager($!a, $manager);
  }

  method set_margin (ClutterMargin() $margin) is also<set-margin> {
    clutter_actor_set_margin($!a, $margin);
  }

  method set_margin_bottom (Num() $margin) is also<set-margin-bottom> {
    clutter_actor_set_margin_bottom($!a, $margin);
    my gfloat $m = $margin;
  }

  method set_margin_left (Num() $margin) is also<set-margin-left> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_left($!a, $margin);
  }

  method set_margin_right (Num() $margin) is also<set-margin-right> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_right($!a, $m);
  }

  method set_margin_top (Num() $margin) is also<set-margin-top> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_top($!a, $m);
  }

  method set_name (Str() $name) is also<set-name> {
    clutter_actor_set_name($!a, $name);
  }

  method set_offscreen_redirect (
    Int() $redirect # ClutterOffscreenRedirect $redirect
  )
    is also<set-offscreen-redirect>
  {
    my guint $r = resolve-int($redirect);
    clutter_actor_set_offscreen_redirect($!a, $r);
  }

  method set_opacity (Int() $opacity) is also<set-opacity> {
    my guint8 $o = resolve-uint8($opacity);
    clutter_actor_set_opacity($!a, $opacity);
  }

  method set_opacity_override (Int() $opacity) is also<set-opacity-override> {
    my gint $o = resolve-ing($opacity);
    clutter_actor_set_opacity_override($!a, $o);
  }

  method set_pivot_point (Num() $pivot_x, Num() $pivot_y)
    is also<set-pivot-point>
  {
    my gfloat ($px, $py) = ($pivot_x, $pivot_y);
    clutter_actor_set_pivot_point($!a, $pivot_x, $pivot_y);
  }

  method set_pivot_point_z (Num() $pivot_z) is also<set-pivot-point-z> {
    my gfloat $pz = $pivot_z;
    clutter_actor_set_pivot_point_z($!a, $pz);
  }

  method set_position (gfloat $x, gfloat $y) is also<set-position> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_set_position($!a, $xx, $yy);
  }

  method set_reactive (Int() $reactive) is also<set-reactive> {
    my gboolean $r = resolve-bool($reactive);
    clutter_actor_set_reactive($!a, $r);
  }

  method set_request_mode (
    Int() $mode # ClutterRequestMode $mode
  )
    is also<set-request-mode>
  {
    my guint $m = resolve-uint($mode);
    clutter_actor_set_request_mode($!a, $m);
  }

  method set_rotation_angle (
    Int() $axis, # ClutterRotateAxis $axis,
    Num() $angle
  )
    is also<set-rotation-angle>
  {
    my guint $a = resolve-uint($axis);
    my gdouble $ang = $angle
    clutter_actor_set_rotation_angle($!a, $a, $ang);
  }

  method set_scale (Num() $scale_x, Num() $scale_y) is also<set-scale> {
    my gdouble ($sx, $sy);
    clutter_actor_set_scale($!a, $sx, $sy);
  }

  method set_scale_z (Num() $scale_z) is also<set-scale-z> {
    my gdouble $sz = $scale_z;
    clutter_actor_set_scale_z($!a, $sz);
  }

  method set_size (Num() $width, Num() $height) is also<set-size> {
    my gfloat ($w, $h) = ($width, $height);
    clutter_actor_set_size($!a, $w, $h);
  }

  method set_text_direction (
    Int() $text_dir # $ClutterTextDirection $text_dir
  )
    is also<set-text-direction>
  {
    my guint $td = resolve-uint($text_dir);
    clutter_actor_set_text_direction($!a, $td);
  }

  method set_transform (ClutterMatrix() $transform) is also<set-transform> {
    clutter_actor_set_transform($!a, $transform);
  }

  method set_translation (
    Num() $translate_x,
    Num() $translate_y,
    Num() $translate_z
  )
    is also<set-translation>
  {
    my gfloat ($tx, $ty, $tz) = ($translate_x, $translate_y, $translate_z);
    clutter_actor_set_translation($!a, $tx, $ty, $tz);
  }

  method set_width (Num() $width) is also<set-width> {
    my gfloat $w = $width;
    clutter_actor_set_width($!a, $w);
  }

  method set_x (Num() $x) is also<set-x> {
    my gfloat $xx = $x;
    clutter_actor_set_x($!a, $xx);
  }

  method set_x_align (
    Int() $x_align # ClutterActorAlign $x_align
  ) is also<set-x-align> {
    my guint $xa = resolve-uint($x_align);
    clutter_actor_set_x_align($!a, $xa);
  }

  method set_x_expand (Num() $expand) is also<set-x-expand> {
    my gboolean $e = resolve-bool($expand);
    clutter_actor_set_x_expand($!a, $e);
  }

  method set_y (Num() $y) is also<set-y> {
    my gfloat $yy = $y;
    clutter_actor_set_y($!a, $yy);
  }

  method set_y_align (
    Int() $y_align # ClutterActorAlign $y_align
  )
    is also<set-y-align>
  {
    my guint $ya = resolve-uint($y_align);
    clutter_actor_set_y_align($!a, $ya);
  }

  method set_y_expand (Int() $expand) is also<set-y-expand> {
    my gboolean $e = resolve-bool($expand);
    clutter_actor_set_y_expand($!a, $e);
  }

  method set_z_position (Num() $z_position) is also<set-z-position> {
    my gfloat $zp = $z_position;
    clutter_actor_set_z_position($!a, $zp);
  }

  method should_pick_paint is also<should-pick-paint> {
    clutter_actor_should_pick_paint($!a);
  }

  method show {
    clutter_actor_show($!a);
  }

  method transform_stage_point (
    Num() $x,
    Num() $y,
    Num() $x_out,
    Num() $y_out
  )
    is also<transform-stage-point>
  {
    my gfloat ($xx, $yy, $xo, $yo) = ($x, $y, $x_out, $y_out);
    clutter_actor_transform_stage_point($!a, $xx, $yy, $xo, $yo);
  }

  method unmap {
    clutter_actor_unmap($!a);
  }

  method unrealize {
    clutter_actor_unrealize($!a);
  }

  method unset_flags (ClutterActorFlags $flags) is also<unset-flags> {
    clutter_actor_unset_flags($!a, $flags);
  }

}
