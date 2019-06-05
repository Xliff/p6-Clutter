use v6.c;

use Cairo;

# For gv_* helpers.
use GTK::Compat::Value;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::AlignConstraint;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::PropertyTransition;
use Clutter::Stage;

use Clutter::Main;

sub draw-content($c, $cr, $sw, $sh, $ud, $r) {
  CATCH { default { .message.say } }

  my ($x, $y, $w, $h, $a, $corRad) = (1, 1, $sw - 1, $sh - 2, 1, $sh / 20);
  my ($radius, $degrees, $ct) = ( $corRad / $a, π / 180, Cairo::Context.new($cr) );

  $ct.save;
  $ct.operator = CAIRO_OPERATOR_CLEAR;
  $ct.paint;
  $ct.restore;

  $ct.sub_path;
  $ct.arc($x + $w - $radius, $y + $radius, $radius, -90 * $degrees, 0);
  $ct.arc($x + $w - $radius, $y + $h - $radius, $radius, 0, 90 * $degrees);
  $ct.arc($x + $radius, $y + $h - $radius, $radius, 90 * $degrees, 180 * $degrees);
  $ct.arc($x + $radius, $y + $radius, $radius, 180 * $degrees, 270 * $degrees);
  $ct.close_path;
  $ct.rgba(0.5, 0.5, 1, 0.95);
  $ct.fill;
  $r.r = 1;
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $stage = Clutter::Stage.new.setup(
    title            => 'Rectangle with Rounded Corners',
    use-alpha        => True,
    background-color => $CLUTTER_COLOR_Black,
    size             => 500 xx 2,
    opacity          => 64,
  );
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.show-actor;

  my $canvas = Clutter::Canvas.new;
  $canvas.set_size(300, 300);
  $canvas.draw.tap(-> *@a { draw-content( |@a ) });
  $canvas.invalidate;

  my $actor = Clutter::Actor.new.setup(
    content                 => $canvas,
    content-gravity         => CLUTTER_CONTENT_GRAVITY_CENTER,
    content-scaling-filters => (
      CLUTTER_SCALING_FILTER_TRILINEAR,
      CLUTTER_SCALING_FILTER_LINEAR
    ),
    pivot-point            => 0.5 xx 2,
    constraints            => [
      Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.5)
    ],
    request-mode           => CLUTTER_REQUEST_CONTENT_SIZE,
  );
  $stage.add-child($actor);

  my $transition = Clutter::PropertyTransition.new('rotation-angle-y').setup(
    from         => gv_dbl(0),
    to           => gv_dbl(360),
    duration     => 2000,
    repeat-count => -1
  );
  $actor.add-transition('rotateActor', $transition);
  $transition.start;

  Clutter::Main.run;
}
