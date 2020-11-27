use v6.c;

# Find the original implementation here:
# https://gitlab.gnome.org/GNOME/clutter/blob/master/examples/canvas.c

use Cairo;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::BindConstraint;
use Clutter::Cairo;
use Clutter::Canvas;
use Clutter::Color;
use Clutter::Stage;
use Clutter::Threads;

use Clutter::Main;

my $idle_resize_id;

sub draw_clock ($c, $cr, $w, $h, $ud, $r --> gboolean) {
  CATCH { default { .message.say; .message.concise.say } }

  my $now = DateTime.now;
  my $sec = $now.second * π / 30;
  my $min = $now.minute * π / 30;
  my $hrs = $now.hour   * π / 6;

  my $ct = Cairo::Context.new($cr);
  $ct.save;
  $ct.operator = CAIRO_OPERATOR_CLEAR;
  $ct.paint;
  $ct.restore;

  $ct.operator = CAIRO_OPERATOR_OVER;
  $ct.scale($w, $h);
  $ct.line_cap = CAIRO_LINE_CAP_ROUND;
  $ct.line_width = 0.1;
  Clutter::Cairo.set_source_color($ct, $CLUTTER_COLOR_Black);
  say "B: {  $CLUTTER_COLOR_Black.gist }";
  $ct.translate(0.5, 0.5);
  $ct.arc(0, 0, 0.4, 0, π * 2);
  $ct.stroke;

  # Seconds
  my $color = Clutter::Color.new_from_color($CLUTTER_COLOR_White);
  say "W: {  $color.gist }";
  $color.alpha = 128;
  Clutter::Cairo.set_source_color($ct, $color);
  $ct.move_to(0, 0);
  $ct.arc($sec.sin * 0.4, -$sec.cos * 0.4, 0.05, 0, π * 2);
  $ct.fill;

  # Minute
  # $color = Clutter::Color.new_from_color($CLUTTER_COLOR_DarkChameleon);
  # $color.alpha = 196;
  # say "DC: { $color.gist }";
  # Clutter::Cairo.set_source_color($ct, $color);
  # $ct.move_to(0, 0);
  # $ct.line_to($min.sin * 0.4, -$min.cos * 0.4);
  # $ct.stroke;

  # # Hour
  $ct.move_to(0, 0);
  $ct.line_to($hrs.sin * 0.2, -$hrs.cos * 0.2);
  $ct.stroke;

  $r.r = 1;
}

sub idle_resize ($a) {
  CATCH { default { .message.say } }
  my ($w, $h) = $a.get_size;
  # Clutter::Canvas.new($a.get_content).set_size($w.ceil, $h.ceil);
  # $idle_resize_id = 0;
  G_SOURCE_CONTINUE;
}

sub on_actor_resize ($a, $al, $f, $d) {
  CATCH { default { .message.say } }
  return if $idle_resize_id;
  $idle_resize_id = Clutter::Threads.add-timeout(1000, -> *@a {
    CATCH { default { .message.say } }
    idle_resize($a);
  });
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $stage = Clutter::Stage.new;
  $stage.setup(
    title          => '2D Clock',
    user-resizable => True,
    size           => 300 xx 2,
  );
  $stage.background-color = $CLUTTER_COLOR_LightSkyBlue;
  $stage.show-actor;

  my $canvas = Clutter::Canvas.new;
  $canvas.set-size(300, 300);

  my $actor = Clutter::Actor.new;
  $actor.content = $canvas;
  $actor.set-content-scaling-filters(
    CLUTTER_SCALING_FILTER_TRILINEAR, CLUTTER_SCALING_FILTER_LINEAR
  );
  $actor.add-constraint(
    Clutter::BindConstraint.new($stage, CLUTTER_BIND_SIZE, 0)
  );
  $stage.add-child($actor);

  $actor.allocation-changed.tap(-> *@a { on_actor_resize(|@a) });
  $stage.destroy.tap({ Clutter::Main.quit });
  $canvas.draw.tap(-> *@a { draw_clock(|@a) });

  $canvas.invalidate;
  # Clutter::Threads.add_timeout(1000, -> *@a {
  #   CATCH { default { .message.say; .backtrace.concise.say; } }
  #   $canvas.invalidate;
  #   1;
  # });

  Clutter::Main.run;
}
