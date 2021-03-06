use v6.c;

use Method::Also;

use Cairo;

use Clutter::Raw::Types;
use Clutter::Raw::Actor;

use Pango::Context;
use Pango::Layout;
use GLib::Value;

use Clutter::Action;
use Clutter::ActorBox;
use Clutter::Color;
use Clutter::Constraint;
use Clutter::Effect;
use Clutter::LayoutManager;
use Clutter::PaintVolume;
use Clutter::Point;
use Clutter::Rect;
use Clutter::Size;
use Clutter::Transition;
use Clutter::Vertex;

use GLib::Roles::Object;

use Clutter::Roles::Animatable;
use Clutter::Roles::Container;
use Clutter::Roles::Content;
use Clutter::Roles::Scriptable;
use Clutter::Roles::Signals::Actor;
use Clutter::Roles::Signals::Generic;

# Removed for special handling: position, pivot-point
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
  pivot-point-z              pivot_point_z
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

# cw: An experimental replacement for this now exists in %properties.
our %animatables = (
  anchor-x         => G_TYPE_FLOAT,
  anchor-y         => G_TYPE_FLOAT,
  depth            => G_TYPE_FLOAT,
  fixed-x          => G_TYPE_FLOAT,
  fixed-y          => G_TYPE_FLOAT,
  height           => G_TYPE_FLOAT,
  margin-bottom    => G_TYPE_FLOAT,
  margin-top       => G_TYPE_FLOAT,
  margin-left      => G_TYPE_FLOAT,
  margin-right     => G_TYPE_FLOAT,
  min-height       => G_TYPE_FLOAT,
  min-width        => G_TYPE_FLOAT,
  natural-height   => G_TYPE_FLOAT,
  natural-width    => G_TYPE_FLOAT,
  opacity          => G_TYPE_UINT,
  pivot-point-z    => G_TYPE_FLOAT,
  rotation-angle-x => G_TYPE_DOUBLE,
  rotation-angle-y => G_TYPE_DOUBLE,
  rotation-angle-z => G_TYPE_DOUBLE,
  scale-center-x   => G_TYPE_FLOAT,
  scale-center-y   => G_TYPE_FLOAT,
  scale-x          => G_TYPE_DOUBLE,
  scale-y          => G_TYPE_DOUBLE,
  scale-z          => G_TYPE_DOUBLE,
  tramslation-x    => G_TYPE_FLOAT,
  tramslation-y    => G_TYPE_FLOAT,
  tramslation-z    => G_TYPE_FLOAT,
  'x'              => G_TYPE_FLOAT,
  y                => G_TYPE_FLOAT,
  z-position       => G_TYPE_FLOAT,

  background-color => 'ClutterColor'
);

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
  action_wth_name        action-with-name
  constraint
  constraints
  constraint_by_name     constraint-by-name
  constraint_with_name   constraint-with-name
  child
  effect
  effect-by-name          effect-by-name
  effect_with_name        effect-with-name

  actions_by_name         actions-by-name
  actions_with_name       actions-with-name
  constraints_by_name     constraints-by-name
  constraints_with_name   constraints-with-name
  effects_by_name         effects-by-name
  effects_with_name       effects-with-name
>;

# The above arrays CAN be populated within a BEGIN block, but that will be
# for a later date. Predefined values is currently the path of least resistance:
#   - Tricky part is getting the right list of attributes. They MUST have both
#     getters and setters to be considered. This could be a fun chore.

our subset ClutterActorAncestry is export of Mu
  where ClutterAnimatable | ClutterContainer | ClutterScriptable |
        ClutterActor      | GObject;

my %properties;

class Clutter::Actor {
  also does GLib::Roles::Object;
  also does Clutter::Roles::Animatable;
  also does Clutter::Roles::Container;
  also does Clutter::Roles::Scriptable;
  also does Clutter::Roles::Signals::Actor;
  also does Clutter::Roles::Signals::Generic;

  has ClutterActor $!ca;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    #$o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$actor) {
    #self.ADD-PREFIX('Clutter::');
    self.setClutterActor($actor) if $actor;
  }

  method Clutter::Raw::Definitions::ClutterActor
    is also<
      Actor
      ClutterActor
    >
  { $!ca }

  method setClutterActor (ClutterActorAncestry $actor) {
    #self.IS-PROTECTED;
    my $to-parent;
    $!ca = do given $actor {
      when ClutterActor      {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when ClutterAnimatable { $!c-anim = $_; proceed; }
      when ClutterScriptable { $!cs     = $_; proceed; }
      when ClutterContainer  { $!c      = $_; proceed; }

      when ClutterAnimatable | ClutterContainer | ClutterScriptable {
        $to-parent = cast(GObject, $_);
        cast(ClutterActor, $_);
      }

      default {
        $to-parent = $_;
        cast(ClutterActor, $_);
      }
    }

    self!setObject($to-parent);
    self.setAnimatable($actor) unless $!c-anim;  # Clutter::Roles::Animatable
    self.setContainer($actor)  unless $!c;       # Clutter::Roles::Container
    self.setScriptable($actor) unless $!cs;      # Clutter::Roles::Scriptable
  }

  method listProperties (Clutter::Actor:U: ) {
    %properties.Map;
  }

  multi method new (ClutterActorAncestry $actor, :$ref = True) {
    $actor ?? self.bless(:$actor) !! Nil;
  }
  multi method new {
    my $actor = clutter_actor_new();

    $actor ?? self.bless(:$actor) !! Nil;
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

  method !setAmbiguousPoint (%data, $name is copy) {
    say "A { $name }" if $DEBUG;
    $name .= subst('_', '-', :g);

    # cw: Seq isn't considered positional, so check that, first!
    my $arg = %data{$name};
    $arg = $arg.Array if $arg ~~ Seq;
    die "'{ $name }' value must be a Clutter::Point-compatible object or a 2-element list'"
      unless [||](
        so $arg ~~ (Clutter::Point, ClutterPoint).any,
        $arg ~~ Positional && $arg.elems == 2
      );
    say "Data: { $arg.gist } ({ $arg.^name })" if $DEBUG;
    if $arg ~~ Positional {
      self."set-{$name}"( |$arg );
    } else {
      self."$name"() = $arg;
    }
  }

  method getAnimatable (Str() $name) {
    if %animatables{$name}:exists {
      %animatables{$name}
    } else {
      # Parent
      die "Animatable value {$name} does not exist";
      # Child
      #self.Clutter::Actor::getAnimatable($name);
    }
  }

  # Think about descendants and how not to duplicate code.
  method getAnimatableValue ($name, $value) {
    my $gv = do given self.getAnimatable($name) {
      when 'ClutterColor' {
        my $v; GLib::Value.new(Clutter::Color.get-type);
        # cw: Or is it .boxed?
        $v.pointer = $value;
        $v;
      }

      when GTypeEnum {
        my $v = GLib::Value.new($_);
        $v.valueFromGType($_) = $value;
        $v;
      }

      default {
        die "Cannot get a GValue for attribute '{ $name }' name from '{
             $value.^name }'";

      }
    }
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
        (self.x-expand, self.y-expand) = %data<expand> xx 2
      }

      when 'align'    {
        say 'A align' if $DEBUG;
        (self.x-align, self.y-align) = %data<align> xx 2
      }

      when 'actions'  {
        say 'A actions' if $DEBUG;

      }

      # Attributes needing special handling
      when 'position'    |
           'pivot-point' | 'pivot_point'
      {
        self!setAmbiguousPoint(%data, $_);
      }

      when 'parent' {
        %data<parent>.add_child(self);
        self.show-actor;
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    # Role attribute and set methods should be respected, somehow. Think
    # about a proper mechanism to do that. Bonus points for maintaining
    # abstraction!

    self;
  }

  method opacity is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_opacity($!ca);
      },
      STORE => sub ($, Int() $opacity is copy) {
        my guint8 $o = $opacity;

        clutter_actor_set_opacity($!ca, $o);
      }
    );
  }

  method opacity-override is rw is also<opacity_override> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_opacity_override($!ca);
      },
      STORE => sub ($, Int() $opacity is copy) {
        my gint $o = $opacity;

        clutter_actor_set_opacity_override($!ca, $o);
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
        my gboolean $r = $reactive.so.Int;

        clutter_actor_set_reactive($!ca, $r);
      }
    );
  }

  method request_mode is rw is also<request-mode> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterRequestModeEnum( clutter_actor_get_request_mode($!ca) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = $mode;

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
        ClutterTextDirectionEnum( clutter_actor_get_text_direction($!ca) );
      },
      STORE => sub ($, Int() $text_dir is copy) {
        my guint $d = $text_dir;
        clutter_actor_set_text_direction($!ca, $d);
      }
    );
  }

  method width is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_width($!ca);
      },
      STORE => sub ($, Num() $width is copy) {
        my gfloat $w = $width;

        clutter_actor_set_width($!ca, $w);
      }
    );
  }

  method x is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_x($!ca);
      },
      STORE => sub ($, Num() $x is copy) {
        my gfloat $xx = $x;

        clutter_actor_set_x($!ca, $xx);
      }
    );
  }

  method x-align is rw is also<x_align> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterActorAlignEnum( clutter_actor_get_x_align($!ca) );
      },
      STORE => sub ($, Int() $x_align is copy) {
        my ClutterActorAlign $xa = $x_align;

        clutter_actor_set_x_align($!ca, $xa);
      }
    );
  }

  method x-expand is rw is also<x_expand> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_get_x_expand($!ca);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand.so.Int;

        clutter_actor_set_x_expand($!ca, $expand);
      }
    );
  }

  method y is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_actor_get_y($!ca);
      },
      STORE => sub ($, Num() $y is copy) {
        my gfloat $yy = $y;

        clutter_actor_set_y($!ca, $yy);
      }
    );
  }

  method y-align is rw is also<y_align> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterActorAlignEnum( clutter_actor_get_y_align($!ca) );
      },
      STORE => sub ($, Int() $y_align is copy) {
        my ClutterActorAlign $ya = $y_align;

        clutter_actor_set_y_align($!ca, $ya);
      }
    );
  }

  method y-expand is rw is also<y_expand> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_actor_get_y_expand($!ca);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand.so.Int;

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
    my GLib::Value $gv .= new( Clutter::Action.get_type );
    Proxy.new(
      FETCH => sub ($) {
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
  method allocation (:$raw = False) is rw  {
    my GLib::Value $gv .= new( Clutter::ActorBox.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('allocation', $gv);

        return Nil unless $gv.boxed;

        my $ab = cast(ClutterActorBox, $gv.boxed);
        $raw ?? $ab !! Clutter::ActorBox.new($ab);
      },
      STORE => -> $, $val is copy {
        warn "'allocation' does not allow writing"
      }
    );
  }

  # Type: ClutterGravity
  method anchor-gravity is rw is also<anchor_gravity> is DEPRECATED( 'pivot-point' ) {
    my GLib::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('anchor-gravity', $gv);
        ClutterGravityEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.guint = $val;

        self.prop_set('anchor-gravity', $gv);
      }
    );
  }

  # Type: gfloat
  method anchor-x is rw is also<anchor_x> is DEPRECATED( 'pivot-point' ) {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('anchor-x', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('anchor-y', $gv);
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
      FETCH => sub ($)       { self.get-background-color      },
      STORE => -> $, \val { self.set-background-color(val) };
  }

  # Type: gboolean
  method background-color-set is rw is also<background_color_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background-color-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'background-color-set' does not allow writing" if $DEBUG;
      }
    );
  }

  # Type: ClutterMatrix
  method child-transform is rw is also<child_transform> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child-transform', $gv);

        return Nil unless $gv.pointer;

        cast(ClutterMatrix, $gv.pointer);
      },
      STORE => -> $, ClutterMatrix() $val is copy {
        $gv.pointer = $val;
        self.prop_set('child-transform', $gv);
      }
    );
  }

  # Type: gboolean
  method child-transform-set is rw is also<child_transform_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child-transform-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'child-transform-set' does not allow writing" if $DEBUG;
      }
    );
  }

  # Type: ClutterGeometry
  # method clip is rw  is DEPRECATED( “clip-rect” ) {
  #   my GLib::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( Clutter::Rect.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('clip-rect', $gv);
        cast(ClutterRect, $gv.boxed);
      },
      STORE => -> $, ClutterRect() $val is copy {
        $gv.boxed = $val;
        self.prop_set('clip-rect', $gv);
      }
    );
  }

  # Type: gboolean
  method clip-to-allocation is rw is also<clip_to_allocation> {
    Proxy.new:
      FETCH => sub ($)             { self.get-clip-to-allocation },
      STORE => -> $, Int() \val { self.set-clip-to-allocation(val) };
  }

  # Removed because it was redundant. Left here as reference.
  # Type: ClutterConstraint
  # method constraint is rw  {
  #   my GLib::Value $gv .= new( Clutter::Constraint.get_type );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       warn "'constraints' does not allow reading" if $DEBUG;
  #       0;
  #     },
  #     STORE => -> $, ClutterConstraint() $val is copy {
  #       $gv.object = $val;
  #       self.prop_set('constraints', $gv);
  #     }
  #   );
  # }

  # Type: ClutterContent
  method content is rw  {
    Proxy.new:
      FETCH => sub ($)                        { self.get_content },
      STORE => -> $, ClutterContent() \val { self.set_content(val) };
  }

  # Type: ClutterActorBox
  method content-box (:$raw = False) is rw is also<content_box> {
    my GLib::Value $gv .= new( Clutter::ActorBox.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content-box', $gv);

        return Nil unless $gv.boxed;

        my $ab = cast(ClutterActorBox, $gv.boxed);
        $raw ?? $ab !! Clutter::ActorBox.new($ab);
      },
      STORE => -> $, $val is copy {
        warn "'content-box' does not allow writing";
      }
    );
  }

  # Type: ClutterContentGravity
  method content-gravity is rw is also<content_gravity> {
    Proxy.new:
      FETCH => sub ($)             { self.get-content-gravity },
      STORE => -> $, Int() \val { self.set-content-gravity(val) };
  }

  # Type: ClutterContentRepeat
  method content-repeat is rw is also<content_repeat> {
    Proxy.new:
      FETCH => sub ($)             { self.get-content-repeat },
      STORE => -> $, Int() \val { self.set-content-repeat(val) };
  }

  # Type: gfloat
  method depth is rw is DEPRECATED( 'z-position' ) {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('depth', $gv);
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
      FETCH => sub ($)             { self.get-easing-delay },
      STORE => -> $, Int() \val { self.set-easing-delay(val) };
  }

  method easing-duration is rw is also<easing_duration> {
    Proxy.new:
      FETCH => sub ($)             { self.get-easing-duration },
      STORE => -> $, Int() \val { self.set-easing-duration(val) };
  }

  method easing-mode is rw is also<easing_mode> {
    Proxy.new:
      FETCH => sub ($)             { self.get-easing-mode },
      STORE => -> $, Int() \val { self.set-easing-mode(val) };
  }

  # Type: ClutterEffect
  method effect is rw  {
    my GLib::Value $gv .= new( Clutter::Effect.get_type );
    Proxy.new(
      FETCH => sub ($) {
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
      FETCH => sub ($)             { self.get-fixed-position-set };
      STORE => -> $, Int() \val { self.set-fixed-position-set(val) };
  }

  # Type: gfloat
  method fixed-x is rw is also<fixed_x> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fixed-x', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fixed-y', $gv);
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
      FETCH => sub ($)             { self.get-height },
      STORE => -> $, Num() \val { self.set-height(val) };
  }

  # Type: ClutterLayoutManager
  method layout-manager (:$raw = False) is rw is also<layout_manager> {
    Proxy.new:
      FETCH => sub ($) {
        self.get-layout-manager(:$raw);
      },
      STORE => -> $, ClutterLayoutManager() \val {
        self.set-layout-manager(val)
      };
  }

  # Type: ClutterScalingFilter
  method magnification-filter is rw is also<magification_filter> {
    my GLib::Value $gv .= new( Clutter::Raw::Enums.scaling_filter_get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('magnification-filter', $gv);
        ClutterScalingFilterEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('magnification-filter', $gv);
      }
    );
  }

  # Type: gboolean
  method mapped is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mapped', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "'mapped' does not allow writing"
      }
    );
  }

  method margins is rw {
    Proxy.new:
      FETCH => sub ($) {
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
      FETCH => sub ($)             { self.get-margin-bottom },
      STORE => -> $, Num() \val { self.set-margin-bottom(val) };
  }

  # Type: gfloat
  method margin-left is rw is also<margin_left> {
    Proxy.new:
      FETCH => sub ($)             { self.get-margin-left },
      STORE => -> $, Num() \val { self.set-margin-left(val) };
  }

  # Type: gfloat
  method margin-right is rw is also<margin_right> {
  Proxy.new:
    FETCH => sub ($)             { self.get-margin-right },
    STORE => -> $, Num() \val { self.set-margin-right(val) };
  }

  # Type: gfloat
  method margin-top is rw is also<margin_top> {
    Proxy.new:
      FETCH => sub ($)             { self.get-margin-top },
      STORE => -> $, Num() \val { self.set-margin-top(val) };
  }

  # Type: gfloat
  method min-height is rw is also<min_height> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-height', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-height-set', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-width', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('min-width-set', $gv);
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
    my GLib::Value $gv .= new( Clutter::Raw::Enums.scaling_filter_get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('minification-filter', $gv);
        ClutterScalingFilterEnum( $gv.enum );
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
      FETCH => sub ($)             { self.get-name },
      STORE => -> $, Str() $val { self.set-name($val) };
  }

  # Type: gfloat
  method natural-height is rw is also<natural_height> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-height', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-height-set', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-width', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('natural-width-set', $gv);
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
      FETCH => sub ($)          { self.get-offscreen-redirect },
      STORE => -> $, Num() \val { self.set-offscreen-redirect(val) };
  }

  # Type: ClutterPoint
  method pivot-point is rw is also<pivot_point> {
    my GLib::Value $gv .= new( Clutter::Point.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pivot-point', $gv);
        cast(ClutterPoint, $gv.boxed);
      },
      STORE => -> $, ClutterPoint() $val is copy {
        $gv.boxed = $val;
        self.prop_set('pivot-point', $gv);
      }
    );
  }

  # Type: ClutterPoint
  method position is rw  {
    my GLib::Value $gv .= new( Clutter::Point.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('realized', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "realized does not allow writing"
      }
    );
  }

  # Type: gdouble
  method rotation-angle-x is rw is also<rotation_angle_x> {
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-angle-x', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-angle-y', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-angle-z', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('rotation-angle-z', $gv);
      }
    );
  }

  # Type: ClutterVertex
  method rotation-center-x (:$raw = False) is rw is also<rotation_center_x>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-center-x', $gv);

        return Nil unless $gv.boxed;

        my $v = cast(ClutterVertex, $gv.boxed);

        $raw ?? $v !! Clutter::Vertex.new($v);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-x', $gv);
      }
    );
  }

  # Type: ClutterVertex
  method rotation-center-y (:$raw = False) is rw is also<rotation_center_y>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-center-y', $gv);

        return Nil unless $gv.boxed;

        my $v = cast(ClutterVertex, $gv.boxed);

        $raw ?? $v !! Clutter::Vertex.new($v);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-y', $gv);
      }
    );
  }

  # Type: ClutterVertex
  method rotation-center-z (:$raw = False) is rw is also<rotation_center_z>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( Clutter::Vertex.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-center-z', $gv);

        return Nil unless $gv.boxed;

        my $v = cast(ClutterVertex, $gv.boxed);

        $raw ?? $v !! Clutter::Vertex.new($v);
      },
      STORE => -> $, ClutterVertex() $val is copy {
        $gv.boxed = $val;
        self.prop_set('rotation-center-z', $gv);
      }
    );
  }

  # Type: ClutterGravity
  method rotation-center-z-gravity is rw is also<rotation_center_z_gravity>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rotation-center-z-gravity', $gv);
        ClutterGravityEnum( $gv.enum );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('rotation-center-z-gravity', $gv);
      }
    );
  }

  # Type: gfloat
  method scale-center-x is rw is also<scale_center_x>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-center-x', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('scale-center-x', $gv);
      }
    );
  }

  # Type: gfloat
  method scale-center-y is rw is also<scale_center_y>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-center-y', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('scale-center-y', $gv);
      }
    );
  }

  # Type: ClutterGravity
  method scale-gravity is rw is also<scale_gravity>
    is DEPRECATED( 'pivot-point' )
  {
    my GLib::Value $gv .= new( Clutter::Raw::Enums.gravity_get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-gravity', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-x', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-y', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-on-set-parent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-on-set-parent', $gv);
      }
    );
  }

  # Type: ClutterSize
  method size (:$raw = False) is rw  {
    my GLib::Value $gv .= new( Clutter::Size.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size', $gv);

        return Nil unless $gv.boxed;

        my $s = cast(ClutterSize, $gv.boxed);

        $raw ?? $s !! Clutter::Size.new($s);
      },
      STORE => -> $, ClutterSize() $val is copy {
        $gv.boxed = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: ClutterMatrix
  method transform is rw  {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transform', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transform-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "transform-set does not allow writing"
      }
    );
  }

  # Type: gfloat
  method translation-x is rw is also<translation_x> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('translation-x', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('translation-y', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('translation-z', $gv);
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible', $gv);
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
    my guint $f = $flags;

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
    my gdouble ($xa, $ya)  = ($x_align, $y_align);
    my gboolean ($xf, $yf) = ($x_fill, $y_fill).map( *.so.Int);
    my guint $f = $flags;

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
    my guint $f = $flags;

    clutter_actor_allocate_available_size($!ca, $xx, $yy, $aw, $ah, $f);
  }

  method allocate_preferred_size (
    Int() $flags # ClutterAllocationFlags $flags
  )
    is also<allocate-preferred-size>
  {
    my guint $f = $flags;

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

  method create_pango_context (:$raw = False) is also<create-pango-context> {
    my $pc = clutter_actor_create_pango_context($!ca);

    $pc ??
      ( $raw ?? $pc !! Pango::Context.new($pc) )
      !!
      Nil;
  }

  method create_pango_layout (Str() $text, :$raw = False)
    is also<create-pango-layout>
  {
    my $pl = clutter_actor_create_pango_layout($!ca, $text);

    $pl ??
      ( $raw ?? $pl !! Pango::Layout.new($pl) )
      !!
      Nil;
  }

  method destroy_actor is also<destroy-actor> {
    clutter_actor_destroy($!ca);
  }

  method destroy_all_children is also<destroy-all-children> {
    clutter_actor_destroy_all_children($!ca);
  }

  method emit-event (ClutterEvent() $event, Int() $capture) {
    my gboolean $c = $capture.so.Int;

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

  multi method get_background_color (:$raw = False) {
    samewith($, :$raw);
  }
  multi method get_background_color ($color is copy, :$raw = False) {
    $color //= ClutterColor.new;

    die 'Cannot allocate ClutterColor!' unless $color;

    my $compatible = $color ~~ ClutterColor;
    my $coercible  = $color.^lookup('ClutterColor');
    my $oldcolor   = $coercible ?? $color !! Nil;

    die '$color must be a ClutterColor compatible values'
      unless $compatible || $coercible;

    $color .= ClutterColor if $coercible;

    clutter_actor_get_background_color($!ca, $color);

    $raw ?? $color !! ( $oldcolor ?? $oldcolor !! Clutter::Color.new($color) )
  }

  method get_child_at_index (Int() $index, :$raw = False)
    is also<get-child-at-index>
  {
    my gint $i = $index;
    my $a = clutter_actor_get_child_at_index($!ca, $index);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil;
  }

  proto method get_child_transform (|)
    is also<get-child-transform>
  { * }

  multi method get_child_transform (:$raw = False) {
    samewith($);
  }
  multi method get_child_transform ($transform is copy, :$raw = False) {
    $transform //= ClutterMatrix.new;

    die 'Cannot allocate ClutterMatrix!' unless $transform;

    my $compatible   = $transform ~~ ClutterMatrix;
    my $coercible    = $transform.^lookup('ClutterMatrix');
    my $oldtransform = $coercible ?? $transform !! Nil;

    die '$color must be a ClutterColor compatible values'
      unless $compatible || $coercible;

    $transform .= ClutterMatrix if $coercible;

    clutter_actor_get_child_transform($!ca, $transform);

    $raw ?? $transform
         !! ( $oldtransform ?? $oldtransform
                            !! Clutter::Matrix.new($transform) );
  }

  method get_children (:$glist = False, :$raw = False)
    is also<
      get-children
      children
    >
  {
    my $l = clutter_actor_get_children($!ca);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[ClutterActor];
    $raw ?? $l.Array !! $l.Array.map({ Clutter::Actor.new($_) });
  }

  proto method get_clip (|)
    is also<get-clip>
  { * }

  multi method get_clip {
    samewith($, $, $, $);
  }
  multi method get_clip (
    $xoff   is rw,
    $yoff   is rw,
    $width  is rw,
    $height is rw
  ) {
    my num32 ($xo, $yo, $w, $h) = 0e0 xx 4;

    clutter_actor_get_clip($!ca, $xo, $yo, $w, $h);
    ($xoff, $yoff, $width, $height) = ($xo, $yo, $w, $h);
  }

  method get_clip_to_allocation
    is also<get-clip-to-allocation>
  {
    clutter_actor_get_clip_to_allocation($!ca);
  }

  method get_content is also<get-content> {
    Clutter::Roles::Content.new_cluttercontent_obj(
      clutter_actor_get_content($!ca)
    );
  }

  method get_content_box (ClutterActorBox() $box) is also<get-content-box>
  {
    clutter_actor_get_content_box($!ca, $box);
  }

  method get_content_gravity is also<get-content-gravity> {
    ClutterContentGravityEnum( clutter_actor_get_content_gravity($!ca) );
  }

  method get_content_repeat is also<get-content-repeat> {
    ClutterContentRepeatEnum( clutter_actor_get_content_repeat($!ca) );
  }

  method get_content_scaling_filters (
    ClutterScalingFilter() $min_filter,
    ClutterScalingFilter() $mag_filter
  )
    is also<get-content-scaling-filters>
  {
    clutter_actor_get_content_scaling_filters($!ca, $min_filter, $mag_filter);
  }

  method get_default_paint_volume (:$raw = False)
    is also<
      get-default-paint-volume
      default_paint_volume
      default-paint-volume
    >
  {
    my $pv = clutter_actor_get_default_paint_volume($!ca);

    $pv ??
      ( $raw ?? $pv !! Clutter::PaintVolume.new($pv) )
      !!
      Nil;
  }

  method get_easing_delay is also<get-easing-delay> {
    clutter_actor_get_easing_delay($!ca);
  }

  method get_easing_duration is also<get-easing-duration> {
    clutter_actor_get_easing_duration($!ca);
  }

  method get_easing_mode is also<get-easing-mode> {
    ClutterAnimationModeEnum( clutter_actor_get_easing_mode($!ca) );
  }

  method get_first_child (:$raw = False)
    is also<
      get-first-child
      first_child
      first-child
    >
  {
    my $a = clutter_actor_get_first_child($!ca);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil;
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
    ClutterActorFlagsEnum( clutter_actor_get_flags($!ca) );
  }

  method get_height is also<get-height> {
    clutter_actor_get_height($!ca);
  }

  method get_last_child (:$raw = False)
    is also<
      get-last-child
      last_child
      last-child
    >
  {
    my $a = clutter_actor_get_last_child($!ca);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil;
  }

  method get_layout_manager(:$raw = False) is also<get-layout-manager> {
    my $lm = clutter_actor_get_layout_manager($!ca);

    $lm ??
      ( $raw ?? $lm !! Clutter::LayoutManager.new($lm) )
      !!
      Nil;
  }

  method get_margin (ClutterMargin() $margin) is also<get-margin> {
    clutter_actor_get_margin($!ca, $margin);
  }

  method get_margin_bottom is also<get-margin-bottom> {
    clutter_actor_get_margin_bottom($!ca);
  }

  method get_margin_left is also<get-margin-left> {
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

  method get_next_sibling (:$raw = False)
    is also<
      get-next-sibling
      next_sibling
      next-sibling
    >
  {
    my $a = clutter_actor_get_next_sibling($!ca);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil;
  }

  method get_offscreen_redirect is also<get-offscreen-redirect> {
    ClutterOffscreenRedirectEnum( clutter_actor_get_offscreen_redirect($!ca) );
  }

  method get_opacity is also<get-opacity> {
    clutter_actor_get_opacity($!ca);
  }

  method get_opacity_override is also<get-opacity-override> {
    clutter_actor_get_opacity_override($!ca);
  }

  method get_paint_box (ClutterActorBox() $box) is also<get-paint-box> {
    return False unless $box;

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

  method get_paint_volume (:$raw = False)
    is also<
      get-paint-volume
      paint_volume
      paint-volume
    >
  {
    my $pv = clutter_actor_get_paint_volume($!ca);

    $pv ??
      ( $raw ?? $pv !! Clutter::PaintVolume.new($pv) )
      !!
      Nil;
  }

  method get_pango_context (:$raw = False)
    is also<
      get-pango-context
      pango_context
      pango-context
    >
  {
    my $pc = clutter_actor_get_pango_context($!ca);

    $pc ??
      ( $raw ?? $pc !! Pango::Context.new($pc) )
      !!
      Nil;
  }

  method get_parent (:$raw = False)
    is also<
      get-parent
      parent
    >
  {
    my $p = clutter_actor_get_parent($!ca);

    $p ??
      ( $raw ?? $p !! Clutter::Actor.new($p) )
      !!
      Nil;
  }

  multi method get_pivot_point {
    samewith($, $);
  }
  multi method get_pivot_point (
    $pivot_x is rw,
    $pivot_y is rw
  )
    is also<get-pivot-point>
  {
    my gfloat ($px, $py) = 0e0 xx 2;

    clutter_actor_get_pivot_point($!ca, $px, $py);
    ($pivot_x, $pivot_y) = ($px, $py);
  }

  method get_pivot_point_z is also<get-pivot-point-z> {
    clutter_actor_get_pivot_point_z($!ca);
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    samewith($, $);
  }
  multi method get_position (
    $x is rw,
    $y is rw
  ) {
    my gfloat ($xx, $yy) = 0e0 xx 2;

    clutter_actor_get_position($!ca, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height (Num() $for_width) {
    samewith($for_width, $, $);
  }
  multi method get_preferred_height (
    Num() $for_width,
    $min_height_p     is rw,
    $natural_height_p is rw
  ) {
    my gfloat ($fw, $mh, $nh) = ($for_width, 0e0, 0e0);

    clutter_actor_get_preferred_height($!ca, $fw, $mh, $nh);
    ($min_height_p, $natural_height_p) = ($mh, $nh);
  }

  proto method get_preferred_size (|)
    is also<get-preferred-size>
  { * }

  multi method get_preferred_size {
    samewith($, $, $, $);
  }
  multi method get_preferred_size (
    $min_width_p      is rw,
    $min_height_p     is rw,
    $natural_width_p  is rw,
    $natural_height_p is rw
  ) {
    my gfloat ($mw, $mh, $nw, $nh) = 0e0 xx 4;

    clutter_actor_get_preferred_size($!ca, $mw, $mh, $nw, $nh);
    ($min_width_p, $min_height_p, $natural_width_p, $natural_height_p) =
      ($mw, $mh, $nw, $nh);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width (Num() $for_height) {
    samewith($for_height, $, $);
  }
  multi method get_preferred_width (
    Num() $for_height,
    $min_width_p       is rw,
    $natural_width_p   is rw
  ) {
    my ($fh, $mw, $nw) = ($fh, 0e0, 0e0);

    clutter_actor_get_preferred_width($!ca, $fh, $mw, $nw);
    ($min_width_p, $natural_width_p) = ($mw, $nw);
  }

  method get_previous_sibling (:$raw = False)
    is also<
      get-previous-sibling
      previous_sibling
      previous-sibling
    >
  {
    my $sa = clutter_actor_get_previous_sibling($!ca);

    $sa ??
      ( $raw ?? $sa !! Clutter::Actor.new($sa) )
      !!
      Nil;
  }

  method get_reactive is also<get-reactive> {
    so clutter_actor_get_reactive($!ca);
  }

  method get_request_mode is also<get-request-mode> {
    ClutterRequestModeEnum( clutter_actor_get_request_mode($!ca) );
  }

  method get_rotation_angle (
    Int() $axis # ClutterRotateAxis $axis
  )
    is also<get-rotation-angle>
  {
    my guint $a = $axis;

    clutter_actor_get_rotation_angle($!ca, $axis);
  }

  proto method get_scale (|)
    is also<get-scale>
  { * }

  multi method get_scale {
    samewith($, $);
  }
  multi method get_scale (
    $scale_x is rw,
    $scale_y is rw
  ) {
    my gdouble ($sx, $sy) = 0e0 xx 2;

    clutter_actor_get_scale($!ca, $sx, $sy);
    ($scale_x, $scale_y) = ($sx, $sy);
  }

  method get_scale_z is also<get-scale-z> {
    clutter_actor_get_scale_z($!ca);
  }


  # cw: Rationalize this with .size, which returns a ClutterSize.
  #     May need a new name to resolve the confusion!
  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size (
    $width  is rw,
    $height is rw
  ) {
    my gfloat ($w, $h) = 0e0 xx 2;

    clutter_actor_get_size($!ca, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_stage (:$raw = False)
    is also<
      get-stage
      stage
    >
  {
    my $s = clutter_actor_get_stage($!ca);

    $s ??
      ( $raw ?? $s !! ::('Clutter::Stage').new($s) )
      !!
      Nil;
  }

  method get_text_direction is also<get-text-direction>
  {
    ClutterTextDirectionEnum( clutter_actor_get_text_direction($!ca) );
  }

  proto method get_transform (|)
    is also<get-transform>
  { * }

  multi method get_transform (:$raw = False) {
    my $t = ClutterMatrix.new;

    die 'Cannot allocate ClutterMatrix' unless $t;

    samewith($t, :$raw);
  }
  multi method get_transform (ClutterMatrix() $transform, :$raw = False)  {
    clutter_actor_get_transform($!ca, $transform);

    $transform ??
      ( $raw ?? $transform !! Clutter::Matrix.new($transform) )
      !!
      Nil;
  }

  method get_transformed_paint_volume (
    ClutterActor() $relative_to_ancestor,
    :$raw = False
  )
    is also<get-transformed-paint-volume>
  {
    my $pv = clutter_actor_get_transformed_paint_volume(
      $!ca,
      $relative_to_ancestor
    );

    $pv ??
      ( $raw ?? $pv !! Clutter::PaintVolume.new($pv) )
      !!
      Nil;
  }

  proto method get_transformed_position (|)
    is also<get-transformed-position>
  { * }

  multi method get_transformed_position {
    samewith($, $);
  }
  multi method get_transformed_position (
    $x is rw,
    $y is rw
  ) {
    my gfloat ($xx, $yy) = 0e0 xx 2;

    clutter_actor_get_transformed_position($!ca, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  proto method get_transformed_size (|)
    is also<get-transformed-size>
  { * }

  multi method get_transformed_size {
    samewith($, $);
  }
  multi method get_transformed_size (
    $width  is rw,
    $height is rw
  ) {
    my gfloat ($w, $h) = 0e0 xx 2;

    clutter_actor_get_transformed_size($!ca, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_transition (Str() $name, :$raw = False) is also<get-transition> {
    my $t = clutter_actor_get_transition($!ca, $name);

    $t ??
      ($raw ?? $t !! Clutter::Transition.new($t) )
      !!
      Nil;
  }

  proto method get_translation (|)
    is also<get-translation>
  { * }

  multi method get_translation {
    samewith($, $, $);
  }
  multi method get_translation (
    $translate_x is rw,
    $translate_y is rw,
    $translate_z is rw
  ) {
    my gfloat ($tx, $ty, $tz) = 0e0 xx 3;

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
    ClutterActorAlignEnum( clutter_actor_get_x_align($!ca) );
  }

  method get_x_expand is also<get-x-expand> {
    clutter_actor_get_x_expand($!ca);
  }

  method get_y is also<get-y> {
    clutter_actor_get_y($!ca);
  }

  method get_y_align is also<get-y-align> {
    ClutterActorAlignEnum( clutter_actor_get_y_align($!ca) );
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
    my gint $i = $index;

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
    my guint $o = $orientation;

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
    my guint $f = $flags;

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
    my gint $i = $index;
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
    my gboolean $c = $clip_set.so.Int;

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
    my guint $g = $gravity;

    clutter_actor_set_content_gravity($!ca, $g);
  }

  method set_content_repeat (
    Int() $repeat # ClutterContentRepeat $repeat
  )
    is also<set-content-repeat>
  {
    my guint $r = $repeat;

    clutter_actor_set_content_repeat($!ca, $r);
  }

  method set_content_scaling_filters (
    Int() $min_filter,
    Int() $mag_filter
  )
    is also<set-content-scaling-filters>
  {
    my ClutterScalingFilter ($mnf, $mgf) = ($min_filter, $mag_filter);

    clutter_actor_set_content_scaling_filters($!ca, $mnf, $mgf);
  }

  method set_easing_delay (Int() $msecs) is also<set-easing-delay> {
    my guint $ms = $msecs;

    clutter_actor_set_easing_delay($!ca, $ms);
  }

  method set_easing_duration (Int() $msecs) is also<set-easing-duration> {
    my guint $ms = $msecs;

    clutter_actor_set_easing_duration($!ca, $ms);
  }

  method set_easing_mode (
    Int() $mode # ClutterAnimationMode $mode
  )
    is also<set-easing-mode>
  {
    my guint $m = $mode;

    clutter_actor_set_easing_mode($!ca, $m);
  }

  method set_fixed_position_set (Int() $is_set)
    is also<set-fixed-position-set>
  {
    my gboolean $is = $is_set.so.Int;

    clutter_actor_set_fixed_position_set($!ca, $is);
  }

  method set_flags (
    Int() $flags # ClutterActorFlags $flags
  )
    is also<set-flags>
  {
    my guint $f = $flags;

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
    my gfloat $m = $margin;

    clutter_actor_set_margin_bottom($!ca, $margin);
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
    my guint $r = $redirect;

    clutter_actor_set_offscreen_redirect($!ca, $r);
  }

  method set_opacity (Int() $opacity) is also<set-opacity> {
    my guint8 $o = $opacity;

    clutter_actor_set_opacity($!ca, $opacity);
  }

  method set_opacity_override (Int() $opacity) is also<set-opacity-override> {
    my gint $o = $opacity;

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

  proto method set_position (|)
    is also<set-position>
  { * }

  multi method set_position (ClutterPoint() $p) {
    samewith($p.x, $p.y);
  }
  multi method set_position (Num() $x, Num() $y)  {
    my gfloat ($xx, $yy) = ($x, $y);

    clutter_actor_set_position($!ca, $xx, $yy);
  }

  method set_reactive (Int() $reactive) is also<set-reactive> {
    my gboolean $r = $reactive.so.Int;

    clutter_actor_set_reactive($!ca, $r);
  }

  method set_request_mode (
    Int() $mode # ClutterRequestMode $mode
  )
    is also<set-request-mode>
  {
    my guint $m = $mode;

    clutter_actor_set_request_mode($!ca, $m);
  }

  method set_rotation_angle (
    Int() $axis, # ClutterRotateAxis $axis,
    Num() $angle
  )
    is also<set-rotation-angle>
  {
    my guint $a = $axis;
    my gdouble $ang = $angle;

    clutter_actor_set_rotation_angle($!ca, $a, $ang);
  }

  method set_scale (Num() $scale_x, Num() $scale_y) is also<set-scale> {
    my gdouble ($sx, $sy) = ($scale_x, $scale_y);

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
    my guint $td = $text_dir;

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
    my guint $xa = $x_align;

    clutter_actor_set_x_align($!ca, $xa);
  }

  method set_x_expand (Num() $expand) is also<set-x-expand> {
    my gboolean $e = $expand.so.Int;

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
    my guint $ya = $y_align;

    clutter_actor_set_y_align($!ca, $ya);
  }

  method set_y_expand (Int() $expand) is also<set-y-expand> {
    my gboolean $e = $expand.so.Int;

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

  proto method transform_stage_point (|)
    is also<transform-stage-point>
  { * }

  multi method transform_stage_point (Num() $x, Num() $y) {
    samewith($x, $y, $, $);
  }
  multi method transform_stage_point (
    Num() $x,
    Num() $y,
    $x_out is rw,
    $y_out is rw
  ) {
    my gfloat ($xx, $yy, $xo, $yo) = ($x, $y, 0e0, 0e0);

    clutter_actor_transform_stage_point($!ca, $xx, $yy, $xo, $yo);
    ($x_out, $y_out) = ($xo, $yo);
  }

  method unmap {
    clutter_actor_unmap($!ca);
  }

  method unrealize_actor is also<unrealize-actor> {
    clutter_actor_unrealize($!ca);
  }

  method unset_flags (
    Int() $flags
  )
    is also<unset-flags>
  {
    my ClutterActorFlags $f = $flags;

    clutter_actor_unset_flags($!ca, $f);
  }

  method add_action (ClutterAction() $action) is also<add-action> {
    clutter_actor_add_action($!ca, $action);
  }

  method add_actions (*@actions) is also<add-actions> {
    for @actions {
      unless $_ ~~ Clutter::Action || .^lookup('ClutterAction') {
        die 'actions value must only contain Clutter::Action compatible types!'
      }
      self.add_action($_);
    }
  }

  method add_action_with_name (Str() $name, ClutterAction() $action)
    is also<
      add-action-with-name
      add_action_by_name
      add-action-by-name
    >
  {
    clutter_actor_add_action_with_name($!ca, $name, $action);
  }

  method add_actions_with_name (*@actions)
    is also<
      add-actions-with-name
      add_actions_by_name
      add-actions-by-name
    >
  {
    unless .[1] ~~ Clutter::Action || .[1].^lookup('ClutterAction') {
      die qq:to/DIE/;
        'constraints-with-name' value must only contain Clutter::Action {''
        }compatible types
        DIE
    }
    say "Action: { .[0] }" if $DEBUG;
    self.add-action-with-name(|$_);
  }

  method clear_actions is also<clear-action> {
    clutter_actor_clear_actions($!ca);
  }

  method get_action (Str() $name, :$raw = False) is also<get-action> {
    my $a = clutter_actor_get_action($!ca, $name);

    $a ??
      ( $raw ?? $a !! Clutter::Action.new($a) )
      !!
      Nil
  }

  method get_actions (:$glist = False, :$raw = False) is also<get-actions> {
    my $l = clutter_actor_get_actions($!ca);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[ClutterAction];
    $raw ?? $l.Array !! $l.Array.map({ Clutter::Actor.new($_) });
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

  method add_constraints (*@constraints) is also<add-constraints> {
    for @constraints {
      die "\@constraints must contain only Clutter::Constraint compatible {''
          }values"
      unless $_ ~~ ClutterConstraint || .^lookup('ClutterConstraint')
    }

    self.add_constraint($_) for @constraints;
  }

  method add_constraint (ClutterConstraint() $constraint)
    is also<add-constraint>
  {
    clutter_actor_add_constraint($!ca, $constraint);
  }

  method add_constraint_with_name (
    Str() $name,
    ClutterConstraint() $constraint
  )
    is also<
      add-constraint-with-name
      add_constraint_by_name
      add-constraint-by-name
    >
  {
    clutter_actor_add_constraint_with_name($!ca, $name, $constraint);
  }

  method add_constraints_with_name (*@constraints)
    is also<
      add-constraints-with-name
      add_constraints_by_name
      add-constraints-by-name
    >
  {
    # Turn back into proper pairs
    for @constraints.rotor(2) {
      die "'constraints-with-name' value must only contain {''
          }ClutterConstraint compatible types"
      unless .[1] ~~ ClutterConstraint ||
             .[1].^lookup('ClutterConstraint').elems;

      say "Constraint: { .[0] }" if $DEBUG;
      self.add-constraint-with-name(|$_);
    }
  }

  method clear_constraints is also<clear-constraints> {
    clutter_actor_clear_constraints($!ca);
  }

  method get_constraint (Str() $name, :$raw = False) is also<get-constraint> {
    my $c = clutter_actor_get_constraint($!ca, $name);

    $c ??
      ( $raw ?? $c !! Clutter::Constraint.new($c) )
      !!
      Nil;
  }

  method get_constraints (:$glist = False, :$raw = False)
    is also<get-constraints>
  {
    my $l = clutter_actor_get_constraints($!ca);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[ClutterConstraint];
    $raw ?? $l.Array !! $l.Array.map({ Clutter::Constraint.new($_) });
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
    is also<
      add-effect-with-name
      add_effect_by_name
      add-effect-by-name
    >
  {
    clutter_actor_add_effect_with_name($!ca, $name, $effect);
  }

  method add_effects_with_name(*@effects)
    is also<
      add-effects-with-name
      add_effects_by_name
      add-effects-by-name
    >
  {
    # Turn back into a list of proper pairs.
    for @effects.rotor(2) {
      unless .[1] ~~ Clutter::Effect || .[1].^lookup('ClutterEffect').elems {
        die "'effects-with-name' value must only contain ClutterEffects {''
            }compatible types"
      }

      say "Effect: { .[0] }" if $DEBUG;
      self.add-effect-with-name(|$_);
    }
  }

  method clear_effects is also<clear-effects> {
    clutter_actor_clear_effects($!ca);
  }

  method get_effect (Str() $name, :$raw) is also<get-effect> {
    my $e = clutter_actor_get_effect($!ca, $name);

    $e ??
      ( $raw ?? $e !! Clutter::Effect.new($e) )
      !!
      Nil
  }

  method get_effects (:$glist = False, :$raw = False) is also<get-effects> {
    my $l = clutter_actor_get_effects($!ca);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[ClutterEffect];
    $raw ?? $l.Array !! $l.Array.map({ Clutter::Effect.new($_) });
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


use GLib::Object::Type;
use GLib::Class::Object;
BEGIN {
  my $t = GLib::Object::Type.new(Clutter::Actor.get-type);
  my $c = cast(GObjectClass, $t.class_ref);
  my $co = GLib::Class::Object.new($c);
  %properties{.name} = [.valueTypeName, .getTypeName] for $co.list-properties;
  ($t, $c, $co) = Nil xx 3;
}
