use v6.c;

use Method::Also;

use Cairo;

use Pango::Context;
use Pango::Layout;

use GTK::Compat::Types;
use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Actor;

use GTK::Compat::Value;

use Clutter::Action;
use Clutter::ActorBox;
use Clutter::Color;
use Clutter::Constraint;
use Clutter::LayoutManager;
use Clutter::PaintVolume;
use Clutter::Point;
use Clutter::Rect;
use Clutter::Size;
use Clutter::Vertex;

use GTK::Roles::Protection;
use GTK::Roles::Properties;

use Clutter::Roles::Animatable;
use Clutter::Roles::Container;
use Clutter::Roles::Content;
use Clutter::Roles::Scriptable;
use Clutter::Roles::Signals::Actor;
use Clutter::Roles::Signals::Generic;

my @attributes = <
  actions
  allocation
  anchor-gravity             anchor_gravity
  anchor-x                   anchor_x
  anchor-y                   anchor_y
  background-color           background_color
  background-color-set       background_color_set
  child-transform            child_transform
  child-transform-set        child_transform_set
  clip
  clip-rect                  clip_rect
  clip-to-allocation         clip_to_allocation
  constraints
  content
  content-box                content_box
  content-gravity            content_gravity
  content-repeat             content_repeat
  depth
  easing-duration            easing_duration
  easing-mode                easing_mode
  easing_delay
  effect
  fixed-position-set         fixed_position_set
  fixed-x                    fixed_x
  fixed-y                    fixed_y
  height
  layout-manager             layout_manager
  magnification-filter       magnification_filter
  mapped
  margin-bottom              margin_bottom
  margin-left                margin_left
  margin-right               margin_right
  margin-top                 margin_top
  margins
  min-height                 min_height
  min-height-set             min_height_set
  min-width                  min_width
  min-width-set              min_width_set
  minification-filter        minification_filter
  name
  natural-height             natural_height
  natural-height-set         natural_height_set
  natural-width              natural_width
  natural-width-set          natural_width_set
  offscreen-redirect         offscreen_redirect
  opacity
  opacity-override           opacity_override
  pivot-point                pivot_point
  pivot-point-z              pivot_point_z
  position
  reactive
  realized
  request-mode               request_mode
  rotation-angle-x           rotation_angle_x
  rotation-angle-y           rotation_angle_y
  rotation-angle-z           rotation_angle_z
  rotation-center-x          rotation_center_x
  rotation-center-y          rotation_center_y
  rotation-center-z          rotation_center_z
  rotation-center-z-gravity  rotation_center_z_gravity
  scale-center-x             scale_center_x
  scale-center-y             scale_center_y
  scale-gravity              scale_gravity
  scale-x                    scale_x
  scale-y                    scale_y
  scale_z
  show-on-set-parent         show_on_set_parent
  text_direction
  transform
  transform-set              transform_set
  translation-x              translation_x
  translation-y              translation_y
  translation-z              translation_z
  visible
  width
  x
  x-align                    x_align
  x-expand                   x_expand
  y
  y-align                    y_align
  y-expand                   y_expand
  z-position                 z_position
>;

# Please note that for .setup, 'size' is consdered a SET method. To set using a
# Clutter::Size or equivalent, use the key 'cluttersize' or directly via the
# .size  attribute
my @set_methods = <
  child_above_sibling      child-above-sibling
  child_at_index           child-at-index
  child_below_sibling      child-below-sibling
  content_scaling_filters  content-scaling-filters
  fixed_position_set       fixed-position-set
  flags
  rotation_angle           rotation-angle
  size
  translation
>;

my @add_methods = <
  action
  action_wth_name       action-with-name
  constraint
  constraint_with_name  constraint-with-name
  child
  effect
  effect_with_name      effect-with-name
>;

class Clutter::Actor {
  also does GTK::Roles::Protection;
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does Clutter::Roles::Animatable;
  also does Clutter::Roles::Container;
  also does Clutter::Roles::Scriptable;
  also does Clutter::Roles::Signals::Actor;
  also does Clutter::Roles::Signals::Generic;

  has ClutterActor $!ca;

  submethod BUILD (:$actor) {
    self.ADD-PREFIX('Clutter::');
    self.setActor($actor) if $actor.defined;
  }

  method Clutter::Raw::Types::ClutterActor
    is also<
      ClutterActor
      Actor
    >
  { $!ca }

  method setActor ($actor) {
    self.IS-PROTECTED;
    self!setObject( cast(GObject, $!ca = $actor) );
    self.setAnimatable( cast(ClutterAnimatable, $!ca) ); # Clutter::Roles::Animatable
    self.setContainer( cast(ClutterContainer, $!ca)   ); # Clutter::Roles::Container
    self.setScriptable( cast(ClutterScriptable, $!ca) ); # Clutter::Roles::Scriptable
  }

  multi method new (ClutterActor $actor) {
    self.bless(:$actor);
  }
  multi method new {
    self.bless( actor => clutter_actor_new() );
  }

  # Is originally:
  # ClutterActor, ClutterActorBox, ClutterAllocationFlags, gpointer --> void
  method allocation-changed is also<allocation_changed> {
    self.connect-allocation-changed($!ca);
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method button-press-event is also<button_press_event> {
    self.connect-clutter-event($!ca, 'button-press-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method button-release-event is also<button_release_event> {
    self.connect-clutter-event($!ca, 'button-release-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method captured-event is also<captured_event> {
    self.connect-clutter-event($!ca, 'captured-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method destroy {
    self.connect($!ca, 'destroy');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method enter-event is also<enter_event> {
    self.connect-clutter-event($!ca, 'enter-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method event {
    self.connect-clutter-event($!ca, 'event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method hide {
    self.connect($!ca, 'hide');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method key-focus-in is also<key_focus_in> {
    self.connect($!ca, 'key-focus-in');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method key-focus-out is also<key_focus_out> {
    self.connect($!ca, 'key-focus-out');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method key-press-event is also<key_press_event> {
    self.connect-clutter-event($!ca, 'key-press-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method key-release-event is also<key_release_event> {
    self.connect-clutter-event($!ca, 'key-release-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method leave-event is also<leave_event> {
    self.connect-clutter-event($!ca, 'leave-event');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method motion-event is also<motion_event> {
    self.connect-clutter-event($!ca, 'motion-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method paint {
    self.connect($!ca, 'paint');
  }

  # Is originally:
  # ClutterActor, ClutterActor, gpointer --> void
  method parent-set is also<parent_set> {
    self.connect-parent-set($!ca);
  }

  # Is originally:
  # ClutterActor, ClutterColor, gpointer --> void
  method pick {
    self.connect-pick($!ca);
  }

  # Is originally:
  # void, void
  method queue-redraw {
    self.connect($!ca, 'queue-redraw');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method queue-relayout is also<queue_relayout> {
    self.connect($!ca, 'queue-relayout');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method realize {
    self.connect($!ca, 'realize');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method scroll-event is also<scroll_event> {
    self.connect-clutter-event($!ca, 'scroll-event');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method show {
    self.connect($!ca, 'show');
  }

  # Is originally:
  # ClutterActor, ClutterEvent, gpointer --> gboolean
  method touch-event is also<touch_event> {
    self.connect-clutter-event($!ca, 'touch-event');
  }

  # Is originally:
  # ClutterActor, gchar, gboolean, gpointer --> void
  method transition-stopped is also<transition_stopped> {
    self.connect-transition-stopped($!ca);
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method transitions-completed is also<transitions_completed> {
    self.connect($!ca, 'transitions-completed');
  }

  # Is originally:
  # ClutterActor, gpointer --> void
  method unrealize {
    self.connect($!ca, 'unrealize');
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "AA: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      when @add_methods.any {
        my $proper-name = S:g /'-'/_/;
        say "AddA: {$_}" if $DEBUG;
        self."add_{ $proper-name }"( |%data{$_} )
      }

      when @set_methods.any {
        my $proper-name = S:g /'-'/_/;
        say "ASM: {$_}" if $DEBUG;
        self."set_{ $proper-name }"( |%data{$_} )
      }

      # set-size uses 'cluttersize' key to distinguish itself from the attribute.
      when 'cluttersize'   {
        say 'A cluttersize' if $DEBUG;
        self.size = %data<cluttersize>
      }

      when 'expand'   {
        say 'A expand' if $DEBUG;
        (self.x-expand, self.y-expand) = |%data<expand> xx 2
      }

      when 'align'    {
        say 'A align' if $DEBUG;
        (self.x-align, self.y-align) = |%data<align>  xx 2
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
  }

  method opacity is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_opacity($!ca);
      },
      STORE => sub ($, $opacity is copy) {
        clutter_actor_set_opacity($!ca, $opacity);
      }
    );
  }

  method opacity-override is rw is also<opacity_override> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_opacity_override($!ca);
      },
      STORE => sub ($, $opacity is copy) {
        clutter_actor_set_opacity_override($!ca, $opacity);
      }
    );
  }

  method pivot-point-z is rw is also<pivot_point_z> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_pivot_point_z($!ca);
      },
      STORE => sub ($, $pivot_z is copy) {
        clutter_actor_set_pivot_point_z($!ca, $pivot_z);
      }
    );
  }

  method reactive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_get_reactive($!ca);
      },
      STORE => sub ($, Int() $reactive is copy) {
        my gboolean $r = resolve-bool($reactive);
        clutter_actor_set_reactive($!ca, $r);
      }
    );
  }

  method request_mode is rw is also<request-mode> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterRequestMode( clutter_actor_get_request_mode($!ca) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = resolve-uint($mode);
        clutter_actor_set_request_mode($!ca, $m);
      }
    );
  }

  method scale_z is rw is also<scale-z> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_scale_z($!ca);
      },
      STORE => sub ($, $scale_z is copy) {
        clutter_actor_set_scale_z($!ca, $scale_z);
      }
    );
  }

  method text_direction is rw is also<text-direction> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterTextDirection( clutter_actor_get_text_direction($!ca) );
      },
      STORE => sub ($, Int() $text_dir is copy) {
        my guint $d = resolve-uint($text_dir);
        clutter_actor_set_text_direction($!ca, $d);
      }
    );
  }

  method width is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_width($!ca);
      },
      STORE => sub ($, $width is copy) {
        clutter_actor_set_width($!ca, $width);
      }
    );
  }

  method x is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_x($!ca);
      },
      STORE => sub ($, $x is copy) {
        clutter_actor_set_x($!ca, $x);
      }
    );
  }

  method x-align is rw is also<x_align> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterActorAlign( clutter_actor_get_x_align($!ca) );
      },
      STORE => sub ($, $x_align is copy) {
        clutter_actor_set_x_align($!ca, $x_align);
      }
    );
  }

  method x-expand is rw is also<x_expand> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_get_x_expand($!ca);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = resolve-bool($expand);
        clutter_actor_set_x_expand($!ca, $expand);
      }
    );
  }

  method y is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_y($!ca);
      },
      STORE => sub ($, $y is copy) {
        clutter_actor_set_y($!ca, $y);
      }
    );
  }

  method y-align is rw is also<y_align> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterActorAlign( clutter_actor_get_y_align($!ca) );
      },
      STORE => sub ($, $y_align is copy) {
        clutter_actor_set_y_align($!ca, $y_align);
      }
    );
  }

  method y-expand is rw is also<y_expand> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_get_y_expand($!ca);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = resolve-bool($expand);
        clutter_actor_set_y_expand($!ca, $expand);
      }
    );
  }

  method z-position is rw is also<z_position> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_z_position($!ca);
      },
      STORE => sub ($, Num() $z_position is copy) {
        my gfloat $z = $z_position;
        clutter_actor_set_z_position($!ca, $z_position);
      }
    );
  }

  # Type: ClutterAction
  method actions is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Action.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn "'actions' does not allow reading" if $DEBUG;
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
    my GTK::Compat::Value $gv .= new( Clutter::ActorBox.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('allocation', $gv)
        );
        cast(ClutterActorBox, $gv.boxed);
      },
      STORE => -> $, $val is copy {
        warn "'allocation' does not allow writing"
      }
    );
  }

  # Type: ClutterGravity
  method anchor-gravity is rw is also<anchor_gravity> is DEPRECATED( 'pivot-point' ) {
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
  method anchor-x is rw is also<anchor_x> is DEPRECATED( 'pivot-point' ) {
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
  method anchor-y is rw is also<anchor_y> is DEPRECATED( 'pivot-point' ) {
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

  method background-color is rw is also<background_color> {
    Proxy.new:
      FETCH => -> $       { self.get-background-color      },
      STORE => -> $, \val { self.set-background-color(val) };
  }

  # Type: gboolean
  method background-color-set is rw is also<background_color_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('background-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'background-color-set' does not allow writing" if $DEBUG;
      }
    );
  }

  # Type: ClutterMatrix
  method child-transform is rw is also<child_transform> {
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
  method child-transform-set is rw is also<child_transform_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('child-transform-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'child-transform-set' does not allow writing" if $DEBUG;
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
  method clip-rect is rw is also<clip_rect> {
    my GTK::Compat::Value $gv .= new( Clutter::Rect.get_type );
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
  method clip-to-allocation is rw is also<clip_to_allocation> {
    Proxy.new:
      FETCH => -> $             { self.get-clip-to-allocation },
      STORE => -> $, Int() \val { self.set-clip-to-allocation(val) };
  }

  # Type: ClutterConstraint
  method constraints is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Constraint.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn "'constraints' does not allow reading" if $DEBUG;
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
    Proxy.new:
      FETCH => -> $                        { self.get_content },
      STORE => -> $, ClutterContent() \val { self.set_content(val) };
  }

  # Type: ClutterActorBox
  method content-box is rw is also<content_box> {
    my GTK::Compat::Value $gv .= new( Clutter::ActorBox.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('content-box', $gv)
        );
        cast(ClutterActorBox, $gv.boxed);
      },
      STORE => -> $, $val is copy {
        warn "'content-box' does not allow writing";
      }
    );
  }

  # Type: ClutterContentGravity
  method content-gravity is rw is also<content_gravity> {
    Proxy.new:
      FETCH => -> $             { self.get-content-gravity },
      STORE => -> $, Int() \val { self.set-content-gravity(val) };
  }

  # Type: ClutterContentRepeat
  method content-repeat is rw is also<content_repeat> {
    Proxy.new:
      FETCH => -> $             { self.get-content-repeat },
      STORE => -> $, Int() \val { self.set-content-repeat(val) };
  }

  # Type: gfloat
  method depth is rw is DEPRECATED( “z-position” ) {
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

  method easing_delay is rw is also<easing-delay> {
    Proxy.new:
      FETCH => -> $             { self.get-easing-delay },
      STORE => -> $, Int() \val { self.set-easing-delay(val) };
  }

  method easing-duration is rw is also<easing_duration> {
    Proxy.new:
      FETCH => -> $             { self.get-easing-duration },
      STORE => -> $, Int() \val { self.set-easing-duration(val) };
  }

  method easing-mode is rw is also<easing_mode> {
    Proxy.new:
      FETCH => -> $             { self.get-easing-mode },
      STORE => -> $, Int() \val { self.set-easing-mode(val) };
  }

  # Type: ClutterEffect
  method effect is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Effect.get_type );
    Proxy.new(
      FETCH => -> $ {
        warn "'effect' does not allow reading" if $DEBUG;
        0;
      },
      STORE => -> $, ClutterEffect() $val is copy {
        $gv.object = $val;
        self.prop_set('effect', $gv);
      }
    );
  }

  # Type: gboolean
  method fixed-position-set is rw is also<fixed_position_set> {
    Proxy.new:
      FETCH => -> $             { self.get-fixed-position-set };
      STORE => -> $, Int() \val { self.set-fixed-position-set(val) };
  }

  # Type: gfloat
  method fixed-x is rw is also<fixed_x> {
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
  method fixed-y is rw is also<fixed_y> {
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

  # Type: gfloat
  method height is rw {
    Proxy.new:
      FETCH => -> $             { self.get-height },
      STORE => -> $, Num() \val { self.set-height(val) };
  }

  # Type: ClutterLayoutManager
  method layout-manager is rw is also<layout_manager> {
    Proxy.new:
      FETCH => -> $ {
        self.get-layout-manager
      },
      STORE => -> $, ClutterLayoutManager() \val {
        self.set-layout-manager(val)
      };
  }

  # Type: ClutterScalingFilter
  method magnification-filter is rw is also<magification_filter> {
    my GTK::Compat::Value $gv .= new( Clutter::Raw::Enums.scaling_filter_get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('magnification-filter', $gv)
        );
        ClutterScalingFilter( $gv.enum );
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
        warn "'mapped' does not allow writing"
      }
    );
  }

  method margins is rw {
    Proxy.new:
      FETCH => -> $ {
        (
          self.margin-top,
          self.margin-left,
          self.margin-right,
          self.margin-bottom
        )
      },
      STORE => -> $, Num() $val {
        my gfloat $v = $val;
        (
          self.margin-top,
          self.margin-left,
          self.margin-right,
          self.margin-bottom
        ) = $val xx 4;
      }
  }

  # Type: gfloat
  method margin-bottom is rw is also<margin_bottom> {
    Proxy.new:
      FETCH => -> $             { self.get-margin-bottom },
      STORE => -> $, Num() \val { self.set-margin-bottom(val) };
  }

  # Type: gfloat
  method margin-left is rw is also<margin_left> {
    Proxy.new:
      FETCH => -> $             { self.get-margin-left },
      STORE => -> $, Num() \val { self.set-margin-left(val) };
  }

  # Type: gfloat
  method margin-right is rw is also<margin_right> {
  Proxy.new:
    FETCH => -> $             { self.get-margin-right },
    STORE => -> $, Num() \val { self.set-margin-right(val) };
  }

  # Type: gfloat
  method margin-top is rw is also<margin_top> {
    Proxy.new:
      FETCH => -> $             { self.get-margin-top },
      STORE => -> $, Num() \val { self.set-margin-top(val) };
  }

  # Type: gfloat
  method min-height is rw is also<min_height> {
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
  method min-height-set is rw is also<min_height_set> {
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
  method min-width is rw is also<min_width> {
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
  method min-width-set is rw is also<min_width_set> {
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
  method minification-filter is rw is also<minification_filter> {
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
    Proxy.new:
      FETCH => -> $             { self.get-name },
      STORE => -> $, Str() $val { self.set-name($val) };
  }

  # Type: gfloat
  method natural-height is rw is also<natural_height> {
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
  method natural-height-set is rw is also<natural_height_set> {
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
  method natural-width is rw is also<natural_width> {
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
  method natural-width-set is rw is also<natural_width_set> {
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
  method offscreen-redirect is rw is also<offscreen_redirect> {
    Proxy.new:
      FETCH => -> $             { self.get-offscreen-redirect },
      STORE => -> $, Num() \val { self.set-offscreen-redirect(val) };
  }

  # Type: ClutterPoint
  method pivot-point is rw is also<pivot_point> {
    my GTK::Compat::Value $gv .= new( Clutter::Point.get_type );
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

  # Type: ClutterPoint
  method position is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Point.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('position', $gv)
        );
        cast(ClutterPoint, $gv.boxed);
      },
      STORE => -> $, ClutterPoint() $val is copy {
        $gv.boxed = $val;
        self.prop_set('position', $gv);
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
  method rotation-angle-x is rw is also<rotation_angle_x> {
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
  method rotation-angle-y is rw is also<rotation_angle_y> {
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
  method rotation-angle-z is rw is also<rotation_angle_z> {
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

  # Type: ClutterVertex
  method rotation-center-x is rw is also<rotation_center_x> is DEPRECATED( 'pivot-point' ) {
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
  method rotation-center-y is rw is also<rotation_center_y> is DEPRECATED( 'pivot-point' ) {
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
  method rotation-center-z is rw is also<rotation_center_z> is DEPRECATED( 'pivot-point' ) {
    my GTK::Compat::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('rotation-center-z', $gv)
        );
        Clutter::Vertex.new($gv.boxed);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-z', $gv);
      }
    );
  }

  # Type: ClutterGravity
  method rotation-center-z-gravity is rw is also<rotation_center_z_gravity> is DEPRECATED( 'pivot-point' ) {
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
  method scale-center-x is rw is also<scale_center_x> is DEPRECATED( 'pivot-point' ) {
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
  method scale-center-y is rw is also<scale_center_y> is DEPRECATED( 'pivot-point' ) {
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
  method scale-gravity is rw is also<scale_gravity> is DEPRECATED( 'pivot-point' ) {
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
  method scale-x is rw is also<scale_x> {
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
  method scale-y is rw is also<scale_y> {
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

  # Type: gboolean
  method show-on-set-parent is rw is also<show_on_set_parent> {
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
  method transform-set is rw is also<transform_set> {
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
  method translation-x is rw is also<translation_x> {
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
  method translation-y is rw is also<translation_y> {
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
  method translation-z is rw is also<translation_z> {
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

  method add_child (ClutterActor() $child) is also<add-child> {
    clutter_actor_add_child($!ca, $child);
  }

  method add_transition (Str() $name, ClutterTransition() $transition)
    is also<add-transition>
  {
    clutter_actor_add_transition($!ca, $name, $transition);
  }

  method allocate (
    ClutterActorBox() $box,
    Int() $flags # ClutterAllocationFlags $flags
  ) {
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate($!ca, $box, $f);
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
    clutter_actor_allocate_align_fill($!ca, $box, $xa, $ya, $xf, $yf, $f);
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
    clutter_actor_allocate_available_size($!ca, $xx, $yy, $aw, $ah, $f);
  }

  method allocate_preferred_size (
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<allocate-preferred-size>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_allocate_preferred_size($!ca, $f);
  }

  method apply_relative_transform_to_point (
    ClutterActor() $ancestor,
    ClutterVertex() $point,
    ClutterVertex() $vertex
  )
    is also<apply-relative-transform-to-point>
  {
    clutter_actor_apply_relative_transform_to_point(
      $!ca,
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
    clutter_actor_apply_transform_to_point($!ca, $point, $vertex);
  }

  method bind_model (
    GListModel() $model,
    ClutterActorCreateChildFunc $create_child_func,
    gpointer $user_data    = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<bind-model>
  {
    clutter_actor_bind_model(
      $!ca,
      $model,
      $create_child_func,
      $user_data,
      $notify
    );
  }

  method contains (ClutterActor() $descendant) {
    clutter_actor_contains($!ca, $descendant);
  }

  method continue_paint is also<continue-paint> {
    clutter_actor_continue_paint($!ca);
  }

  method create_pango_context is also<create-pango-context> {
    Pango::Context.new( clutter_actor_create_pango_context($!ca) );
  }

  method create_pango_layout (Str() $text) is also<create-pango-layout> {
    Pango::Layout.new( clutter_actor_create_pango_layout($!ca, $text) );
  }

  method destroy_actor is also<destroy-actor> {
    clutter_actor_destroy($!ca);
  }

  method destroy_all_children is also<destroy-all-children> {
    clutter_actor_destroy_all_children($!ca);
  }

  method emit-event (ClutterEvent() $event, Int() $capture) {
    my gboolean $c = resolve-bool($capture);
    clutter_actor_event($!ca, $event, $capture);
  }

  method get_accessible is also<get-accessible> {
    clutter_actor_get_accessible($!ca);
  }

  method get_allocation_box (ClutterActorBox() $box)
    is also<get-allocation-box>
  {
    clutter_actor_get_allocation_box($!ca, $box);
  }

  multi method get_background_color (|)
    is also<get-background-color>
  { * }

  multi method get_background_color {
    my $cc = ClutterColor.new;
    samewith($cc);
  }
  multi method get_background_color (ClutterColor() $color) {
    clutter_actor_get_background_color($!ca, $color);
    $color;
  }

  method get_child_at_index (Int() $index) is also<get-child-at-index> {
    my gint $i = resolve-int($index);
    Clutter::Actor.new( clutter_actor_get_child_at_index($!ca, $index) );
  }

  method get_child_transform (ClutterMatrix() $transform)
    is also<get-child-transform>
  {
    clutter_actor_get_child_transform($!ca, $transform);
  }

  method get_children (:$raw = False)
    is also<
      get-children
      children
    >
  {
    my $l = GTK::Compat::GList.new( clutter_actor_get_children($!ca) )
      but GTK::Compat::Roles::ListData[ClutterActor];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::Actor.new($_) });
  }

  multi method get_clip {
    my ($xo, $yo, $w, $h) = 0 xx 4;
    samewith($xo, $yo, $w, $h);
  }
  multi method get_clip (
    Num() $xoff   is rw,
    Num() $yoff   is rw,
    Num() $width  is rw,
    Num() $height is rw
  )
    is also<get-clip>
  {
    my num32 ($xo, $yo, $w, $h) = ($xoff, $yoff, $width, $height);
    clutter_actor_get_clip($!ca, $xo, $yo, $w, $h);
    ($xoff, $yoff, $width, $height) = ($xo, $yo, $w, $h);
  }

  method get_clip_to_allocation
    is also<get-clip-to-allocation>
  {
    clutter_actor_get_clip_to_allocation($!ca);
  }

  method get_content is also<get-content> {
    Clutter::Roles::Content.role-new( clutter_actor_get_content($!ca) );
  }

  method get_content_box (ClutterActorBox() $box) is also<get-content-box>
  {
    clutter_actor_get_content_box($!ca, $box);
  }

  method get_content_gravity is also<get-content-gravity> {
    ClutterContentGravity( clutter_actor_get_content_gravity($!ca) );
  }

  method get_content_repeat is also<get-content-repeat> {
    ClutterContentRepeat( clutter_actor_get_content_repeat($!ca) );
  }

  method get_content_scaling_filters (
    ClutterScalingFilter() $min_filter,
    ClutterScalingFilter() $mag_filter
  )
    is also<get-content-scaling-filters>
  {
    clutter_actor_get_content_scaling_filters($!ca, $min_filter, $mag_filter);
  }

  method get_default_paint_volume
    is also<
      get-default-paint-volume
      default_paint_volume
      default-paint-volume
    >
  {
    Clutter::PaintVolume.new( clutter_actor_get_default_paint_volume($!ca) );
  }

  method get_easing_delay is also<get-easing-delay> {
    clutter_actor_get_easing_delay($!ca);
  }

  method get_easing_duration is also<get-easing-duration> {
    clutter_actor_get_easing_duration($!ca);
  }

  method get_easing_mode is also<get-easing-mode> {
    ClutterAnimationMode( clutter_actor_get_easing_mode($!ca) );
  }

  method get_first_child
    is also<
      get-first-child
      first_child
      first-child
    >
  {
    Clutter::Actor.new( clutter_actor_get_first_child($!ca) );
  }

  method get_fixed_position_set is also<get-fixed-position-set> {
    clutter_actor_get_fixed_position_set($!ca);
  }

  method get_flags
    is also<
      get-flags
      flags
    >
  {
    ClutterActorFlags( clutter_actor_get_flags($!ca) );
  }

  method get_height is also<get-height> {
    clutter_actor_get_height($!ca);
  }

  method get_last_child
    is also<
      get-last-child
      last_child
      last-child
    >
  {
    Clutter::Actor.new( clutter_actor_get_last_child($!ca) );
  }

  method get_layout_manager is also<get-layout-manager> {
    Clutter::LayoutManager.new( clutter_actor_get_layout_manager($!ca) );
  }

  method get_margin (ClutterMargin() $margin) is also<get-margin> {
    clutter_actor_get_margin($!ca, $margin);
  }

  method get_margin_bottom is also<get-margin-bottom> {
    clutter_actor_get_margin_bottom($!ca);
  }

  method get_margin_left is also<get-margin-left>
  {
    clutter_actor_get_margin_left($!ca);
  }

  method get_margin_right is also<get-margin-right> {
    clutter_actor_get_margin_right($!ca);
  }

  method get_margin_top is also<get-margin-top> {
    clutter_actor_get_margin_top($!ca);
  }

  method get_n_children
    is also<
      get-n-children
      n_children
      n-children
      elems
    >
  {
    clutter_actor_get_n_children($!ca);
  }

  method get_name is also<get-name> {
    clutter_actor_get_name($!ca);
  }

  method get_next_sibling
    is also<
      get-next-sibling
      next_sibling
      next-sibling
    >
  {
    Clutter::Actor.new( clutter_actor_get_next_sibling($!ca) );
  }

  method get_offscreen_redirect is also<get-offscreen-redirect> {
    ClutterOffscreenRedirect( clutter_actor_get_offscreen_redirect($!ca) );
  }

  method get_opacity is also<get-opacity> {
    clutter_actor_get_opacity($!ca);
  }

  method get_opacity_override is also<get-opacity-override>
  {
    clutter_actor_get_opacity_override($!ca);
  }

  method get_paint_box (ClutterActorBox() $box) is also<get-paint-box> {
    so clutter_actor_get_paint_box($!ca, $box);
  }

  method get_paint_opacity
    is also<
      get-paint-opacity
      paint_opacity
      paint-opacity
    >
  {
    clutter_actor_get_paint_opacity($!ca);
  }

  method get_paint_visibility
    is also<
      get-paint-visibility
      paint_visibility
      paint-visibility
    >
  {
    clutter_actor_get_paint_visibility($!ca);
  }

  method get_paint_volume
    is also<
      get-paint-volume
      paint_volume
      paint-volume
    >
  {
    Clutter::PaintVolume.new( clutter_actor_get_paint_volume($!ca) );
  }

  method get_pango_context
    is also<
      get-pango-context
      pango_context
      pango-context
    >
  {
    Pango::Context.new( clutter_actor_get_pango_context($!ca) );
  }

  method get_parent
    is also<
      get-parent
      parent
    >
  {
    Clutter::Actor.new( clutter_actor_get_parent($!ca) );
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
    clutter_actor_get_pivot_point($!ca, $px, $py);
    ($pivot_x, $pivot_y) = ($px, $py);
  }

  method get_pivot_point_z is also<get-pivot-point-z> {
    clutter_actor_get_pivot_point_z($!ca);
  }

  multi method get_position {
    my ($x, $y) = 0 xx 2;
    samewith($x, $y);
  }
  multi method get_position (
    Num() $x is rw,
    Num() $y is rw
  )
    is also<get-position>
  {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_get_position($!ca, $xx, $yy);
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
    clutter_actor_get_preferred_height($!ca, $fw, $mh, $nh);
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
      ($min_width_p, $min_height_p, $natural_width_p, $natural_height_p);
    clutter_actor_get_preferred_size($!ca, $mw, $mh, $nw, $nh);
  }

  method get_preferred_width (
    Num() $for_height,
    Num() $min_width_p,
    Num() $natural_width_p
  )
    is also<get-preferred-width>
  {
    my ($fh, $mw, $nw) = ($for_height, $min_width_p, $natural_width_p);
    clutter_actor_get_preferred_width($!ca, $fh, $mw, $nw);
  }

  method get_previous_sibling
    is also<
      get-previous-sibling
      previous_sibling
      previous-sibling
    >
  {
    clutter_actor_get_previous_sibling($!ca);
  }

  method get_reactive is also<get-reactive> {
    clutter_actor_get_reactive($!ca);
  }

  method get_request_mode is also<get-request-mode> {
    ClutterRequestMode( clutter_actor_get_request_mode($!ca) );
  }

  method get_rotation_angle (
    Int() $axis # ClutterRotateAxis $axis
  )
    is also<get-rotation-angle>
  {
    my guint $a = resolve-uint($axis);
    clutter_actor_get_rotation_angle($!ca, $axis);
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
    clutter_actor_get_scale($!ca, $sx, $sy);
    ($scale_x, $scale_y) = ($sx, $sy);
  }

  method get_scale_z is also<get-scale-z> {
    clutter_actor_get_scale_z($!ca);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    my ($w, $h) = 0e0 xx 2;
    samewith($w, $h);
  }
  multi method get_size (
    $width  is rw,
    $height is rw
  ) {
    $width  .= Num if $width.^can('Num').elems;
    $height .= Num if $height.^can('Num').elems;
    my gfloat ($w, $h) = ($width, $height);
    clutter_actor_get_size($!ca, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_stage
    is also<
      get-stage
      stage
    >
  {
    ::('Clutter::Stage').new( clutter_actor_get_stage($!ca) );
  }

  method get_text_direction is also<get-text-direction>
  {
    ClutterTextDirection( clutter_actor_get_text_direction($!ca) );
  }

  method get_transform (ClutterMatrix() $transform) is also<get-transform> {
    clutter_actor_get_transform($!ca, $transform);
  }

  method get_transformed_paint_volume (
    ClutterActor() $relative_to_ancestor
  )
    is also<get-transformed-paint-volume>
  {
    Clutter::PaintVolume.new(
      clutter_actor_get_transformed_paint_volume($!ca, $relative_to_ancestor)
    );
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
    clutter_actor_get_transformed_position($!ca, $xx, $yy);
    ($x, $y) = ($xx, $yy);
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
    clutter_actor_get_transformed_size($!ca, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_transition (Str() $name) is also<get-transition> {
    Clutter::Transition.new( clutter_actor_get_transition($!ca, $name) );
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
    clutter_actor_get_translation($!ca, $tx, $ty, $tz);
    ($translate_x, $translate_y, $translate_z) = ($tx, $ty, $tz);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_actor_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    clutter_actor_get_width($!ca);
  }

  method get_x is also<get-x> {
    clutter_actor_get_x($!ca);
  }

  method get_x_align is also<get-x-align> {
    ClutterActorAlign( clutter_actor_get_x_align($!ca) );
  }

  method get_x_expand is also<get-x-expand> {
    clutter_actor_get_x_expand($!ca);
  }

  method get_y is also<get-y> {
    clutter_actor_get_y($!ca);
  }

  method get_y_align is also<get-y-align> {
    ClutterActorAlign( clutter_actor_get_y_align($!ca) );
  }

  method get_y_expand is also<get-y-expand> {
    clutter_actor_get_y_expand($!ca);
  }

  method get_z_position is also<get-z-position> {
    clutter_actor_get_z_position($!ca);
  }

  method grab_key_focus is also<grab-key-focus> {
    clutter_actor_grab_key_focus($!ca);
  }

  method has_allocation is also<has-allocation> {
    so clutter_actor_has_allocation($!ca);
  }

  method has_clip is also<has-clip> {
    so clutter_actor_has_clip($!ca);
  }

  method has_key_focus is also<has-key-focus> {
    so clutter_actor_has_key_focus($!ca);
  }

  method has_mapped_clones is also<has-mapped-clones> {
    so clutter_actor_has_mapped_clones($!ca);
  }

  method has_overlaps is also<has-overlaps> {
    so clutter_actor_has_overlaps($!ca);
  }

  method has_pointer is also<has-pointer> {
    so clutter_actor_has_pointer($!ca);
  }

  method hide_actor is also<hide-actor> {
    clutter_actor_hide($!ca);
  }

  method insert_child_above (ClutterActor() $child, ClutterActor() $sibling)
    is also<insert-child-above>
  {
    clutter_actor_insert_child_above($!ca, $child, $sibling);
  }

  method insert_child_at_index (ClutterActor() $child, Int() $index)
    is also<insert-child-at-index>
  {
    my gint $i = resolve-int($index);
    clutter_actor_insert_child_at_index($!ca, $child, $i);
  }

  method insert_child_below (ClutterActor() $child, ClutterActor() $sibling)
    is also<insert-child-below>
  {
    clutter_actor_insert_child_below($!ca, $child, $sibling);
  }

  method is_in_clone_paint is also<is-in-clone-paint> {
    so clutter_actor_is_in_clone_paint($!ca);
  }

  method is_mapped is also<is-mapped> {
    so clutter_actor_is_mapped($!ca);
  }

  method is_realized is also<is-realized> {
    so clutter_actor_is_realized($!ca);
  }

  method is_rotated is also<is-rotated> {
    so clutter_actor_is_rotated($!ca);
  }

  method is_scaled is also<is-scaled> {
    so clutter_actor_is_scaled($!ca);
  }

  method is_visible is also<is-visible> {
    so clutter_actor_is_visible($!ca);
  }

  method map {
    clutter_actor_map($!ca);
  }

  method move_by (Num() $dx, Num() $dy) is also<move-by> {
    my gfloat ($ddx, $ddy) = ($dx, $dy);
    clutter_actor_move_by($!ca, $ddx, $ddy);
  }

  method needs_expand (Int() $orientation) is also<needs-expand> {
    my guint $o = resolve-uint($orientation);
    clutter_actor_needs_expand($!ca, $o);
  }

  method paint_actor is also<paint-actor> {
    clutter_actor_paint($!ca);
  }

  method queue_redraw_actor is also<queue-redraw-actor> {
    clutter_actor_queue_redraw($!ca);
  }

  method queue_redraw_with_clip (cairo_rectangle_int_t $clip)
    is also<queue-redraw-with-clip>
  {
    clutter_actor_queue_redraw_with_clip($!ca, $clip);
  }

  method queue_relayout_actor is also<queue-relayout-actor> {
    clutter_actor_queue_relayout($!ca);
  }

  method realize-actor {
    clutter_actor_realize($!ca);
  }

  method remove_all_children is also<remove-all-children> {
    clutter_actor_remove_all_children($!ca);
  }

  method remove_all_transitions is also<remove-all-transitions> {
    clutter_actor_remove_all_transitions($!ca);
  }

  method remove_child (ClutterActor() $child) is also<remove-child> {
    clutter_actor_remove_child($!ca, $child);
  }

  method remove_clip is also<remove-clip> {
    clutter_actor_remove_clip($!ca);
  }

  method remove_transition (Str() $name) is also<remove-transition> {
    clutter_actor_remove_transition($!ca, $name);
  }

  method replace_child (
    ClutterActor() $old_child,
    ClutterActor() $new_child
  )
    is also<replace-child>
  {
    clutter_actor_replace_child($!ca, $old_child, $new_child);
  }

  method restore_easing_state is also<restore-easing-state> {
    clutter_actor_restore_easing_state($!ca);
  }

  method save_easing_state is also<save-easing-state> {
    clutter_actor_save_easing_state($!ca);
  }

  method set_allocation (
    ClutterActorBox() $box,
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<set-allocation>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_set_allocation($!ca, $box, $f);
  }

  method set_background_color (ClutterColor() $color)
    is also<set-background-color>
  {
    clutter_actor_set_background_color($!ca, $color);
  }

  method set_child_above_sibling (
    ClutterActor() $child,
    ClutterActor() $sibling
  )
    is also<set-child-above-sibling>
  {
    clutter_actor_set_child_above_sibling($!ca, $child, $sibling);
  }

  method set_child_at_index (ClutterActor() $child, Int() $index)
    is also<set-child-at-index>
  {
    my gint $i = resolve-int($index);
    clutter_actor_set_child_at_index($!ca, $child, $i);
  }

  method set_child_below_sibling (
    ClutterActor() $child,
    ClutterActor() $sibling
  )
    is also<set-child-below-sibling>
  {
    clutter_actor_set_child_below_sibling($!ca, $child, $sibling);
  }

  method set_child_transform (ClutterMatrix() $transform)
    is also<set-child-transform>
  {
    clutter_actor_set_child_transform($!ca, $transform);
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
    clutter_actor_set_clip($!ca, $xo, $yo, $w, $h);
  }

  method set_clip_to_allocation (Int() $clip_set)
    is also<set-clip-to-allocation>
  {
    my gboolean $c = resolve-bool($clip_set);
    clutter_actor_set_clip_to_allocation($!ca, $clip_set);
  }

  method set_content (ClutterContent() $content) is also<set-content> {
    clutter_actor_set_content($!ca, $content);
  }

  method set_content_gravity (
    Int() $gravity # ClutterContentGravity $gravity
  )
    is also<set-content-gravity>
  {
    my guint $g = resolve-uint($gravity);
    clutter_actor_set_content_gravity($!ca, $g);
  }

  method set_content_repeat (
    Int() $repeat # ClutterContentRepeat $repeat
  )
    is also<set-content-repeat>
  {
    my guint $r = resolve-uint($repeat);
    clutter_actor_set_content_repeat($!ca, $r);
  }

  method set_content_scaling_filters (
    ClutterScalingFilter() $min_filter,
    ClutterScalingFilter() $mag_filter
  )
    is also<set-content-scaling-filters>
  {
    clutter_actor_set_content_scaling_filters($!ca, $min_filter, $mag_filter);
  }

  method set_easing_delay (Int() $msecs) is also<set-easing-delay> {
    my guint $ms = resolve-uint($msecs);
    clutter_actor_set_easing_delay($!ca, $ms);
  }

  method set_easing_duration (Int() $msecs) is also<set-easing-duration> {
    my guint $ms = resolve-uint($msecs);
    clutter_actor_set_easing_duration($!ca, $ms);
  }

  method set_easing_mode (
    Int() $mode # ClutterAnimationMode $mode
  )
    is also<set-easing-mode>
  {
    my guint $m = resolve-uint($mode);
    clutter_actor_set_easing_mode($!ca, $m);
  }

  method set_fixed_position_set (Int() $is_set)
    is also<set-fixed-position-set>
  {
    my gboolean $is = resolve-bool($is_set);
    clutter_actor_set_fixed_position_set($!ca, $is);
  }

  method set_flags (
    Int() $flags # ClutterActorFlags $flags
  )
    is also<set-flags>
  {
    my guint $f = resolve-uint($flags);
    clutter_actor_set_flags($!ca, $f);
  }

  method set_height (Num() $height) is also<set-height> {
    my gfloat $h = $height;
    clutter_actor_set_height($!ca, $h);
  }

  method set_layout_manager (ClutterLayoutManager() $manager)
    is also<set-layout-manager>
  {
    clutter_actor_set_layout_manager($!ca, $manager);
  }

  method set_margin (ClutterMargin() $margin) is also<set-margin> {
    clutter_actor_set_margin($!ca, $margin);
  }

  method set_margin_bottom (Num() $margin) is also<set-margin-bottom> {
    clutter_actor_set_margin_bottom($!ca, $margin);
    my gfloat $m = $margin;
  }

  method set_margin_left (Num() $margin) is also<set-margin-left> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_left($!ca, $margin);
  }

  method set_margin_right (Num() $margin) is also<set-margin-right> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_right($!ca, $m);
  }

  method set_margin_top (Num() $margin) is also<set-margin-top> {
    my gfloat $m = $margin;
    clutter_actor_set_margin_top($!ca, $m);
  }

  method set_name (Str() $name) is also<set-name> {
    clutter_actor_set_name($!ca, $name);
  }

  method set_offscreen_redirect (
    Int() $redirect # ClutterOffscreenRedirect $redirect
  )
    is also<set-offscreen-redirect>
  {
    my guint $r = resolve-int($redirect);
    clutter_actor_set_offscreen_redirect($!ca, $r);
  }

  method set_opacity (Int() $opacity) is also<set-opacity> {
    my guint8 $o = resolve-uint8($opacity);
    clutter_actor_set_opacity($!ca, $opacity);
  }

  method set_opacity_override (Int() $opacity) is also<set-opacity-override> {
    my gint $o = resolve-int($opacity);
    clutter_actor_set_opacity_override($!ca, $o);
  }

  method set_pivot_point (Num() $pivot_x, Num() $pivot_y)
    is also<set-pivot-point>
  {
    my gfloat ($px, $py) = ($pivot_x, $pivot_y);
    clutter_actor_set_pivot_point($!ca, $pivot_x, $pivot_y);
  }

  method set_pivot_point_z (Num() $pivot_z) is also<set-pivot-point-z> {
    my gfloat $pz = $pivot_z;
    clutter_actor_set_pivot_point_z($!ca, $pz);
  }

  method set_position (Num() $x, Num() $y) is also<set-position> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_actor_set_position($!ca, $xx, $yy);
  }

  method set_reactive (Int() $reactive) is also<set-reactive> {
    my gboolean $r = resolve-bool($reactive);
    clutter_actor_set_reactive($!ca, $r);
  }

  method set_request_mode (
    Int() $mode # ClutterRequestMode $mode
  )
    is also<set-request-mode>
  {
    my guint $m = resolve-uint($mode);
    clutter_actor_set_request_mode($!ca, $m);
  }

  method set_rotation_angle (
    Int() $axis, # ClutterRotateAxis $axis,
    Num() $angle
  )
    is also<set-rotation-angle>
  {
    my guint $a = resolve-uint($axis);
    my gdouble $ang = $angle;
    clutter_actor_set_rotation_angle($!ca, $a, $ang);
  }

  method set_scale (Num() $scale_x, Num() $scale_y) is also<set-scale> {
    my gdouble ($sx, $sy);
    clutter_actor_set_scale($!ca, $sx, $sy);
  }

  method set_scale_z (Num() $scale_z) is also<set-scale-z> {
    my gdouble $sz = $scale_z;
    clutter_actor_set_scale_z($!ca, $sz);
  }

  method set_size (Num() $width, Num() $height) is also<set-size> {
    my gfloat ($w, $h) = ($width, $height);
    say "set_size {$w}x{$h}" if $DEBUG;
    clutter_actor_set_size($!ca, $w, $h);
  }

  method set_text_direction (
    Int() $text_dir # $ClutterTextDirection $text_dir
  )
    is also<set-text-direction>
  {
    my guint $td = resolve-uint($text_dir);
    clutter_actor_set_text_direction($!ca, $td);
  }

  method set_transform (ClutterMatrix() $transform) is also<set-transform> {
    clutter_actor_set_transform($!ca, $transform);
  }

  method set_translation (
    Num() $translate_x,
    Num() $translate_y,
    Num() $translate_z
  )
    is also<set-translation>
  {
    my gfloat ($tx, $ty, $tz) = ($translate_x, $translate_y, $translate_z);
    clutter_actor_set_translation($!ca, $tx, $ty, $tz);
  }

  method set_width (Num() $width) is also<set-width> {
    my gfloat $w = $width;
    clutter_actor_set_width($!ca, $w);
  }

  method set_x (Num() $x) is also<set-x> {
    my gfloat $xx = $x;
    clutter_actor_set_x($!ca, $xx);
  }

  method set_x_align (
    Int() $x_align # ClutterActorAlign $x_align
  )
    is also<set-x-align>
  {
    my guint $xa = resolve-uint($x_align);
    clutter_actor_set_x_align($!ca, $xa);
  }

  method set_x_expand (Num() $expand) is also<set-x-expand> {
    my gboolean $e = resolve-bool($expand);
    clutter_actor_set_x_expand($!ca, $e);
  }

  method set_y (Num() $y) is also<set-y> {
    my gfloat $yy = $y;
    clutter_actor_set_y($!ca, $yy);
  }

  method set_y_align (
    Int() $y_align # ClutterActorAlign $y_align
  )
    is also<set-y-align>
  {
    my guint $ya = resolve-uint($y_align);
    clutter_actor_set_y_align($!ca, $ya);
  }

  method set_y_expand (Int() $expand) is also<set-y-expand> {
    my gboolean $e = resolve-bool($expand);
    clutter_actor_set_y_expand($!ca, $e);
  }

  method set_z_position (Num() $z_position) is also<set-z-position> {
    my gfloat $zp = $z_position;
    clutter_actor_set_z_position($!ca, $zp);
  }

  method should_pick_paint is also<should-pick-paint> {
    clutter_actor_should_pick_paint($!ca);
  }

  method show_actor is also<show-actor> {
    clutter_actor_show($!ca);
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
    clutter_actor_transform_stage_point($!ca, $xx, $yy, $xo, $yo);
  }

  method unmap {
    clutter_actor_unmap($!ca);
  }

  method unrealize_actor is also<unrealize-actor> {
    clutter_actor_unrealize($!ca);
  }

  method unset_flags (
    Int() $flags # ClutterActorFlags $flags
  ) is also<unset-flags> {
    my guint $f = resolve-uint($flags);
    clutter_actor_unset_flags($!ca, $f);
  }

  method add_action (ClutterAction() $action) {
    clutter_actor_add_action($!ca, $action);
  }

  method add_action_with_name (Str() $name, ClutterAction() $action) {
    clutter_actor_add_action_with_name($!ca, $name, $action);
  }

  method clear_actions is also<clear-action> {
    clutter_actor_clear_actions($!ca);
  }

  method get_action (Str() $name) is also<get-action> {
    Clutter::Action.new( clutter_actor_get_action($!ca, $name) );
  }

  method get_actions (:$raw = False) is also<get-actions> {
    my $l = GTK::Compat::GList.new( clutter_actor_get_actions($!ca) )
      but GTK::Compat::Roles::ListData[ClutterAction];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::Actor.new($_) });
  }

  method has_actions is also<has-action> {
    so clutter_actor_has_actions($!ca);
  }

  method remove_action (ClutterAction() $action) is also<remove-action> {
    clutter_actor_remove_action($!ca, $action);
  }

  method remove_action_by_name (Str() $name) is also<remove-action-by-name> {
    clutter_actor_remove_action_by_name($!ca, $name);
  }

  # Constraints

  method add_constraint (ClutterConstraint() $constraint)
    is also<add-constraint>
  {
    clutter_actor_add_constraint($!ca, $constraint);
  }

  method add_constraint_with_name (
    Str() $name,
    ClutterConstraint() $constraint
  )
    is also<add-constraint-with-name>
  {
    clutter_actor_add_constraint_with_name($!ca, $name, $constraint);
  }

  method clear_constraints is also<clear-constraints> {
    clutter_actor_clear_constraints($!ca);
  }

  method get_constraint (Str() $name) is also<get-constraint> {
    Clutter::Constraint.new( clutter_actor_get_constraint($!ca, $name) );
  }

  method get_constraints (:$raw = False) is also<get-constraints> {
    my $l = GTK::Compat::GList.new( clutter_actor_get_constraints($!ca) )
      but GTK::Compat::Roles::ListData[ClutterConstraint];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::Constraint.new($_) });
  }

  method has_constraints is also<has-constraints> {
    so clutter_actor_has_constraints($!ca);
  }

  method remove_constraint (ClutterConstraint() $constraint)
    is also<remove-constraint>
  {
    clutter_actor_remove_constraint($!ca, $constraint);
  }

  method remove_constraint_by_name (Str() $name)
    is also<remove-constraint-by-name>
  {
    clutter_actor_remove_constraint_by_name($!ca, $name);
  }

  method add_effect (ClutterEffect() $effect) is also<add-effect> {
    clutter_actor_add_effect($!ca, $effect);
  }

  method add_effect_with_name (Str() $name, ClutterEffect() $effect)
    is also<add-effect-with-name>
  {
    clutter_actor_add_effect_with_name($!ca, $name, $effect);
  }

  method clear_effects is also<clear-effects> {
    clutter_actor_clear_effects($!ca);
  }

  method get_effect (Str() $name) is also<get-effect> {
    Clutter::Effect.new( clutter_actor_get_effect($!ca, $name) );
  }

  method get_effects (:$raw) is also<get-effects> {
    my $l = GTK::Compat::GList.new( clutter_actor_get_effects($!ca) )
      but GTK::Compat::Roles::ListData[ClutterEffect];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::Effect.new($_) });
  }

  method has_effects is also<has-effects> {
    so clutter_actor_has_effects($!ca);
  }

  method remove_effect (ClutterEffect $effect) is also<remove-effect> {
    clutter_actor_remove_effect($!ca, $effect);
  }

  method remove_effect_by_name (Str() $name)
    is also<remove-effect-by-name>
  {
    clutter_actor_remove_effect_by_name($!ca, $name);
  }

}
