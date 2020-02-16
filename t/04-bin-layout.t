use v6.c;

# Find the original implementation here:
# https://gitlab.gnome.org/GNOME/clutter/blob/master/examples/bin-layout.c

use Cairo;

use Clutter::Raw::Types;
use Clutter::Compat::Types;

use GLib::Signal;
use GDK::Pixbuf;

use Clutter::AlignConstraint;
use Clutter::BinLayout;
use Clutter::Cairo;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::ClickAction;
use Clutter::Image;
use Clutter::Stage;
use Clutter::Text;

use Clutter::Main;

constant BG_ROUND_RADIUS = 12;
my $BG_COLOR = Clutter::Color.new(0xcc, 0xcc, 0xcc, 0x99);
my $is_expanded = False;

sub on_canvas_draw($cc, $ct, $w is copy, $h is copy, $ud, $r) {
  CATCH { default { .message.say } }

  say "Painting at {$w} x {$h}";

  my $c = Cairo::Context.new($ct);
  $c.save;
  $c.operator = CAIRO_OPERATOR_CLEAR;
  $c.paint;
  $c.restore;

  my ($x, $y) = (0, 0);
  my $dr = sub {
    CATCH { default { .message.say } }
    $c.move_to(BG_ROUND_RADIUS, $y);
    $c.line_to($w - BG_ROUND_RADIUS, $y);
    $c.curve_to($w, $y, $w, $y, $w, BG_ROUND_RADIUS);
    $c.line_to($w, $h - BG_ROUND_RADIUS);
    $c.curve_to($w, $h, $w, $h, $w - BG_ROUND_RADIUS, $h);
    $c.line_to(BG_ROUND_RADIUS, $h);
    $c.curve_to($x, $h, $x, $h, $x, $h - BG_ROUND_RADIUS);
    $c.line_to($x, BG_ROUND_RADIUS);
    $c.curve_to($x, $y, $x, $y, BG_ROUND_RADIUS, $y);
    $c.close_path;
  };

  $dr();
  Clutter::Cairo.set_source_color($c, $BG_COLOR);
  $c.stroke;
  ($x, $y, $w, $h) «+=» 4;
  $dr();

  my $p = Cairo::Pattern::Gradient::Linear.create(0, 0, 0, $h);
  $p.add_color_stop_rgba(1, 0.85, 0.85, 0.85, 1);
  $p.add_color_stop_rgba(0.95, 1, 1, 1, 1);
  $p.add_color_stop_rgba(0.05, 1, 1, 1, 1);
  $p.add_color_stop_rgba(0, 0.85, 0.85, 0.85, 1);

  $c.pattern($p);
  $c.fill;

  $r.r = 1
}

sub on_box_enter($b, $e, $emblem, $r) {
  CATCH { default { .message.say } }
  $emblem.save-easing-state;
  ($emblem.easing-mode, $emblem.opacity) = (CLUTTER_LINEAR, 255);
  $emblem.restore-easing-state;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on_box_leave($a, $e, $emblem, $r) {
  CATCH { default { .message.say } }
  $emblem.save-easing-state;
  ($emblem.easing-mode, $emblem.opacity) = (CLUTTER_LINEAR, 0);
  $emblem.restore-easing-state;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on-emblem-clicked($box) {
  CATCH { default { .message.say } }
  $box.save-easing-state;
  ($box.easing-mode, $box.easing-duration) = (CLUTTER_EASE_OUT_BOUNCE, 500);
  my $size = $is_expanded ?? 200 !! 400;
  $box.set_size($size, $size);
  $box.restore-easing-state;
  $is_expanded .= not;
}

sub on_emblem_long_press($emblem, $e, $s, $b, $r) {
  CATCH { default { .message.say } }
  $r.r = 1;
  given ClutterLongPressStateEnum($s) {
    when CLUTTER_LONG_PRESS_QUERY    {
      say '*** long press: query    ***';
      $r.r = $is_expanded.Int;
    }
    when CLUTTER_LONG_PRESS_CANCEL   { say '*** long press: cancel   ***' }
    when CLUTTER_LONG_PRESS_ACTIVATE { say '*** long press: activate ***' }
  }
}

sub redraw_canvas ($c, $a) {
  CATCH { default { .message.say } }
  # $c.set_size($a.width, $a.height);
}

sub MAIN {
  exit(1) unless Clutter::Main.init;

  my $stage = Clutter::Stage.new;
  $stage.setup(
     title => 'BinLayout',
     size  => (640, 480),
     background-color => $CLUTTER_COLOR_Aluminium2,
  );
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.show_actor;

  my $layout = Clutter::BinLayout.new(
    CLUTTER_BIN_ALIGNMENT_CENTER, CLUTTER_BIN_ALIGNMENT_CENTER
  );

  my $box = Clutter::Actor.new;
  $box.setup(
    name => 'box',
    layout-manager => $layout,
    constraint => Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.50),
    position => Clutter::Point.new(320, 240),
    reactive => True,
  );
  $stage.add-child($box);

  my $canvas = Clutter::Canvas.new;
  $canvas.draw.tap(-> *@a { on_canvas_draw(|@a) });
  $canvas.set_size(200, 200);

  my $bg = Clutter::Actor.new;
  $bg.setup(
    name    => 'background',
    size    => (200, 200),
    expand  => True,
    content => $canvas,
    align   => CLUTTER_ACTOR_ALIGN_FILL
  );
  $box.transitions-completed.tap({ redraw_canvas($canvas, $box) });
  $box.add-child($bg);

  my $file = 'redhand.png';
  $file = "t/{$file}" unless $file.IO.e;
  die "Cannot find pixbuf file '{$file}'" unless $file.IO.e;
  my $pixbuf = GDK::Pixbuf.new_from_file($file);
  my $image = Clutter::Image.new;
  $image.set-data(
    $pixbuf.pixels,
    $pixbuf.has_alpha ??
      COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
    $pixbuf.width,
    $pixbuf.height,
    $pixbuf.rowstride
  );

  # From the original:
  #   this is the icon; it's going to be centered inside the box actor.
  #   we use the content gravity to keep the aspect ratio of the image,
  #   and the scaling filters to get a better result when scaling the
  #   image down.
  my $icon = Clutter::Actor.new;
  $icon.setup(
    name    => 'icon',
    size    => (196, 196),
    expand  => True,
    align   => CLUTTER_ACTOR_ALIGN_CENTER,
    content-scaling-filters => (
      CLUTTER_SCALING_FILTER_TRILINEAR,
      CLUTTER_SCALING_FILTER_LINEAR
    ),
    content         => $image,
    content_gravity => CLUTTER_CONTENT_GRAVITY_RESIZE_ASPECT
  );

  my $color = Clutter::Color.new( |((^255).rand.floor xx 3), 224 );
  my $emblem = Clutter::Actor.new;
  $emblem.setup(
    name             => 'emblem',
    size             => (48, 48),
    background-color => $color,
    reactive         => True,
    expand           => True,
    align            => CLUTTER_ACTOR_ALIGN_END,
    opacity          => 0,
  );

  my $action = Clutter::ClickAction.new;
  $action.clicked.tap({ on-emblem-clicked($box) });
  $action.long-press.tap(-> *@a { on_emblem_long_press(|@a) });
  $emblem.add_action($action);
  $box.enter-event.tap(-> *@a { @a[2] = $emblem; on_box_enter(|@a) });
  $box.leave-event.tap(-> *@a { @a[2] = $emblem; on_box_leave(|@a) });

  my $label = Clutter::Text.new;
  $label.setup(
    name    => 'text',
    text    => 'A simple test',
    expand  => True,
    x-align => CLUTTER_ACTOR_ALIGN_CENTER,
    y-align => CLUTTER_ACTOR_ALIGN_START,
  );

  $box.add-child($_) for $icon, $emblem, $label;

  Clutter::Main.run;
}
