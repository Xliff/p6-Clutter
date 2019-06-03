use v6.c;

use Cairo;

use Pango::Raw::Types;
use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::Stage;
use Clutter::Text;

use Clutter::Main;

constant HELP_TEXT = qq:to/TEXT/.chomp;
<b>Easing mode: %s (%d of %d)</b>
Left click to tween
Middle click to jump
Right click to change the easing mode
TEXT

my @modes = ClutterAnimationMode.enums.pairs.sort( *.value ).map({
  my $k = .key;
  $k = $k.split('_')[1..*-1].map( *.lc.tc ).join();
  $k.substr-rw(0,1).lc ~ $k.substr(1) => .value
})[1..*-2];

my %globals = (
  current-mode      => 0,
  duration          => 1,
  main-stage        => 0,
  easing-mode-label => ''
);

sub update-text {
  %globals<easing_mode_label>.set-markup(
    HELP_TEXT.sprintf(
      @modes[%globals<current-mode>].key,
      %globals<current_mode> + 1,
      @modes.elems
    )
  );
}

sub on-button-press ($actor, $e, $rect, $r) {
  my $event = cast(ClutterButtonEvent, $e);
  given $event.button {
    when CLUTTER_BUTTON_SECONDARY {
      %globals<current_mode> = 0 if ++%globals<current_mode> >= @modes.elems;
      update-text;
    }
    when CLUTTER_BUTTON_MIDDLE {
      $rect.set-position($event.x, $event.y);
    }
    when CLUTTER_BUTTON_PRIMARY {
      $rect.save-easing-state;
      $rect.easing-mode = @modes[%globals<current-mode>].value;
      $rect.easing-duration = %globals<duration> * 1000;
      $rect.set-position($event.x, $event.y);
      $rect.restore-easing-state;
    }
  }
  $r.r = CLUTTER_EVENT_STOP;
}

sub draw-bouncer ($c, $cr, $w, $h, $r) {
  my $ct = Cairo::Context.new($cr);
  $ct.operator = CAIRO_OPERATOR_CLEAR;
  $ct.paint;
  $ct.operator = CAIRO_OPERATOR_OVER;

  my $rad = ($w, $h).max;
  $ct.arc($rad/2, $rad/2, $rad/2, 0, 2 * π);
  my $bc = $CLUTTER_COLOR_DarkScarletRed;

  my $pat = Cairo::Pattern::Radial.new($rad/2, $rad/2, 0, $rad, $rad, $rad);
  $pat.add_stop(0,    $bc.red/255, $bc.green/255, $bc.blue/255, $bc.alpha/255);
  $pat.add_stop(0.85, $bc.red/255, $bc.green/255, $bc.blue/255, 0.25);
  $ct.source = $pat;
  $ct.fill(:preserve);
  $r.r = 1;
}

sub make-bouncer ($w, $h) {
  my $canvas = Clutter::Canvas.new;
  $canvas.draw(-> *@a { draw-bouncer(|@a) });

  my $rv = Clutter::Actor.new.setup(
    name        => 'bouncer',
    size        => ($w, $h),
    pivot-point => 0.5 xx 2,
    translation => ($w/-2, $h/-2, 0),
    reactive    => True,
    content     => $canvas
  );
}

sub MAIN (
  :$duration  = 0     #= Duration of the animation, in seconds
) {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  %globals<main-stage> = Clutter::Stage.new.setup(
    title => 'Easing Modes',
    background-color => $CLUTTER_COLOR_LightSkyBlue
  );
  %globals<main-stage>.destroy.tap({ Clutter::Main.quit });
  %globals<main-stage>.button-press-event.tap(-> *@a { on-button-press(|@a) });
  %globals<main-stage>.show-actor;

  my ($w, $h) = %globals<main-stage>.get-size;
  ( my $rect = make-bouncer(50, 50) ).set-position($w/2, $h/2);
  %globals<main-stage>.add-child($rect);

  %globals<easing-mode-text> = Clutter::Text.new.setup(
    line-alignment => PANGO_ALIGN_RIGHT,
    constraints => [
      Clutter::AlignConstraint.new(%globals<main-stage>, CLUTTER_ALIGN_X_AXIS, 0.5),
      Clutter::AlignConstraint.new(%globals<main-stage>, CLUTTER_ALIGN_Y_AXIS, 0.5)
    ]
  );
  update-text;

  Clutter::Main.run;
}
