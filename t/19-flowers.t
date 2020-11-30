use v6.c;

use Clutter::Raw::Types;

use Cairo;
use GLib::Timeout;
use Clutter::Actor;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::Main;
use Clutter::Stage;
use Clutter::Timeline;

constant PETAL_MIN = 20;
constant PETAL_VAR = 40;
constant N_FLOWERS = 40;

class Flower {
  has $.actor is rw;
  has $.x     is rw;
  has $.y     is rw;
  has $.rot   is rw;
  has $.v     is rw;
  has $.rv    is rw;
}

my @colors = (
  0.71, 0.81, 0.83,
  1.00, 0.78, 0.57,
  0.64, 0.30, 0.35,
  0.73, 0.40, 0.39,
  0.91, 0.56, 0.64,
  0.70, 0.47, 0.45,
  0.92, 0.75, 0.60,
  0.82, 0.86, 0.85,
  0.51, 0.56, 0.67,
  1.00, 0.79, 0.58
);
@colors .= rotor(3);

sub draw-flower ($c, $cr, $w, $h, $ps, $r) {
  CATCH { default { .message.say; $r.r = 1 } }

  my $ctx = Cairo::Context.new($cr);
  my $petal-size = $ps;
  my $size = 8 * $petal-size;
  my $n-groups = 3.rand.floor + 1;

  $ctx.tolerance = 0.1;
  $ctx.operator = CAIRO_OPERATOR_CLEAR;
  $ctx.paint;
  $ctx.operator = CAIRO_OPERATOR_OVER;
  $ctx.translate($size / 2, $size / 2);

  say $n-groups;

  my $last-idx = -1;
  for ^$n-groups {
    my $n-petals = 5.rand.floor + 4;

    $ctx.save;
    $ctx.rotate(6.rand.floor);
    my $idx = do {
      my $i;
      repeat {
        $i = @colors.elems.rand.Int;
      } while $i == $last-idx;
      $i;
    }

    $ctx.rgba( |@colors[$idx], 0.5 );
    $last-idx = $idx;

    my $pm1 = 20.rand.floor;
    my $pm2 = 4.rand.floor;

    for ^($n-petals + 1) {
      $ctx.save;
      $ctx.rotate(2 * π / $n-petals * $_);
      $ctx.new_path;
      $ctx.move_to(0, 0);
      $ctx.curve_to(
        $petal-size, $petal-size,
        ($pm2 + 2) * $petal-size, $petal-size,
        2 * $petal-size + $pm1, 0,
        :relative
      );
      $ctx.curve_to(
        $pm2 * $petal-size, -$petal-size,
        -$petal-size, -$petal-size,
        -(2 * $petal-size + $pm1), 0,
        :relative
      );
      $ctx.close_path;
      $ctx.fill;
      $ctx.restore;
    }
    $petal-size -= ($size / 8).rand.floor;
  }

  my $idx = do {
    my $i;
    repeat {
      $i = (@colors.elems / 3).rand * 3
    } while $i == $last-idx;
    $i;
  }

  $petal-size = 10.rand.floor;
  $ctx.rgba( |@colors[$idx], 0.5 );
  $ctx.arc(0, 0, $petal-size, 0, π * 2);
  $ctx.fill;
  $r.r = 1;
}

sub make-flower-actor {
  my $petal-size = PETAL_MIN + PETAL_VAR.rand.floor;
  my $size = 8 * $petal-size;
  my $canvas = Clutter::Canvas.new;

  $canvas.set-size($size, $size);
  $canvas.draw.tap(-> *@a {
    CATCH { default { .message.say } }

    draw-flower( |@a[0..3], $petal-size, @a[* - 1] );
  });
  $canvas.invalidate;

  Clutter::Actor.new.setup(
    content     => $canvas,
    width       => $size,
    height      => $size,
    pivot-point => ($size / 2) xx 2
  );
}

my $stage;

sub tick ($t, $ms, $flowers) {
  CATCH { default { .message.say } }

  for $flowers[] -> $f {
    $f.y   += $f.v;
    $f.rot += $f.rv;
    $f.y    = -$f.actor.height if $f.y > $stage.height;

    $f.actor.set-position($f.x, $f.y);
    $f.actor.rotation-angle-z = $f.rot;
  }
}

sub MAIN {
  exit(1) unless Clutter::Main.init;

  my $timeline = Clutter::Timeline.new(6000).setup(
    repeat-count => -1
  );

  $stage = Clutter::Stage.new.setup(
    title            => 'Cairo Flowers',
    background-color => $CLUTTER_COLOR_Black
  );
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.key-press-event.tap(-> *@a {
    CATCH { default { .message.say } }

    GLib::Timeout.add(100, -> *@a { Clutter::Main.quit; G_SOURCE_REMOVE });
    @a[* - 1].r = 1;
  });

  my @flowers;
  for ^N_FLOWERS {
    my $f = Flower.new;

    $f.actor = make-flower-actor;
    $f.x = $stage.width.rand.floor - (PETAL_MIN + PETAL_VAR) * 2;
    $f.y = $stage.height.rand.floor;
    ($f.rv, $f.v) = (5.rand.floor + 1, 10.rand.floor + 2);
    $stage.add-child($f.actor);
    $f.actor.set-position($f.x, $f.y);
    @flowers.push: $f;
  }

  $timeline.new-frame.tap(-> *@a { tick($timeline, @a[1], @flowers) });
  $stage.show-actor;
  $timeline.start;

  Clutter::Main.run;
}
