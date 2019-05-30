use v6.c;

use Cairo;

use Clutter::Raw::Types;
use Clutter::Compat::Types;

use GTK::Compat::Pixbuf;
use GTK::Compat::Signal;

use Clutter::AlignConstraint;
use Clutter::BinLayout;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::ClickAction;
use Clutter::Image;
use Clutter::Stage;
use Clutter::Text;

use Clutter::Main;

constant BG_ROUND_RADIUS = 12;
constant BG_COLOR = ClutterColor.new(
  red => 0xcc, green => 0xcc, blue => 0xcc, alpha => 0x99
);

my $is_expanded = False;

sub on_canvas_draw($cc, $ct, $w, $h, $r) {
  CATCH { default { .message.say } }

  say 'on_canvas_draw';
  say "Painting at {$w} x {$h}";

  my $c = Cairo::Context.new($cc);

  $c.save;
  $c.set_operator(CAIRO_OPERATOR_CLEAR);
  $c.paint;
  $c.restore;

  my ($x, $y) = (0, 0);

  my $dr = sub {
    CATCH { default { .message.say } }
    say 'dr';
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
  $c.set_source_color(BG_COLOR);
  $c.stroke;
  ($x, $y, $w, $h) «+=» 4;
  $dr();

  my $p = Cairo::Pattern.new;
  $p.add_color_stop_rgba(1, 0.85, 0.85, 0.85, 1);
  $p.add_color_stop_rgba(0.95, 1, 1, 1, 1);
  $p.add_color_stop_rgba(0.05, 1, 1, 1, 1);
  $p.add_color_stop_rgba(0, 0.85, 0.85, 0.85, 1);

  $c.set_source($p);
  $c.fill;

  $r.r = 1
}

sub on_box_enter($b, $e, $emblem, $r) {
  CATCH { default { .message.say } }
  say 'box enter';
  $emblem.save-easing-state;
  ($emblem.easing-mode, $emblem.opacity) = (CLUTTER_LINEAR, 255);
  $emblem.restore-easing-state;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on_box_leave($a, $e, $emblem, $r) {
  CATCH { default { .message.say } }
  say 'box leave';
  $emblem.save-easing-state;
  ($emblem.easing-mode, $emblem.opacity) = (CLUTTER_LINEAR, 0);
  $emblem.restore-easing-state;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on-emblem-clicked($box) {
  CATCH { default { .message.say } }
  say 'clicked';
  $box.save-easing-state;
  ($box.easing-mode, $box.easing-duration) = (CLUTTER_EASE_OUT_BOUNCE, 500);
  my $size = (not $is_expanded) ?? 400 !! 200;
  say "size: $size";
  $box.set_size($size, $size);
  $box.restore-easing-state;
  $is_expanded .= not;
}

sub on_emblem_long_press($emblem, $e, $s, $b, $r) {
  CATCH { default { .message.say } }
  say 'long-press';
  $r.r = 1;
  given ClutterLongPressState($s) {
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
  say "redraw {$a.width}x{$a.height}";
  $c.set_size($a.width, $a.height);
}

sub MAIN {
  exit(1) unless Clutter::Main.init;

  my $stage = Clutter::Stage.new;
  # For some reason background-color does not work, here.
  $stage.setup(
     title => 'BinLayout',
     size => (640, 480)
  );
  my $bgcolor = Clutter::Color.new_from_hls(128, 0.5, 0.1);
  $bgcolor.alpha = 255;
  $stage.background-color = $bgcolor;
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.show_actor;

  my $layout = Clutter::BinLayout.new(
    CLUTTER_BIN_ALIGNMENT_CENTER, CLUTTER_BIN_ALIGNMENT_CENTER
  );

  my $box = Clutter::Actor.new;
  $box.layout-manager = $layout;
  $box.add_constraint(
    Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.50)
  );
  $box.set_position(320, 240);
  ($box.reactive, $box.name) = (True, 'box');
  $stage.add-child($box);

  my $canvas = Clutter::Canvas.new;
  $canvas.draw.tap(-> *@a { on_canvas_draw(|@a) });
  $canvas.set_size(200, 200);

  my $bg = Clutter::Actor.new;
  $bg.setup(
    name    => 'background',
    size    => (200, 200),
    content => $canvas,
    expand  => True,
    align   => CLUTTER_ACTOR_ALIGN_FILL
  );
  $box.transitions-completed.tap({
    CATCH { default { .message.say } };
    say 'transitions-completed';
    redraw_canvas($canvas, $box)
  });
  $box.add-child($bg);

  my $file = 'redhand.png';
  $file = "t/{$file}" unless $file.IO.e;
  die "Cannot find pixbuf file '{$file}'" unless $file.IO.e;
  my $pixbuf = GTK::Compat::Pixbuf.new_from_file($file);
  my $image = Clutter::Image.new;
  # Uninitialized data here?
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
    content-scaling-filters =>
      (CLUTTER_SCALING_FILTER_TRILINEAR, CLUTTER_SCALING_FILTER_LINEAR),
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
