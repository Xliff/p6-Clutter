use v6.c;

use Cairo;

use GTK::Compat::Types;
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

sub draw_clock ($c, $cr, $w, $h, $r --> gboolean) {
  my $now = DateTime.now;
  
  my $sec = $now.seconds * π / 30;
  my $min = $now.minutes * π / 30;
  my $hrs = $now.hours   * π / 6;
  
  my $ct = Cairo::Context.new($cr);
  $ct.operator = CAIRO_OPERATOR_OVER;
  $ct.set_scale($w, $h);
  $ct.line_cap = CAIRO_LINE_CAP_ROUND;
  $ct.line_width = 0.1;
  Clutter::Cairo.set_source_color($ct, $CLUTTER_COLOR_Black);
  $ct.translate(0.5, 0.5);
  $ct.arc(0, 0, 0.4, 0, π * 2);
  $ct.stroke;
  
  my $color = $Clutter::Color_White;
  $color.alpha = 196;
  Clutter::Cairo.set_source_color($color);
  
  # Minute
  $ct.move_to(0, 0);
  $ct.line_to($min.sin * 0.4, -$min.cos * 0.4);
  $ct.stroke;
  # Hour
  $ct.move_to(0, 0);
  $ct.line_to($hrs.sin * 0.2, -$hrs.cos * 0.2);
  $ct.stroke;
  
  $r.r = 1;
}

sub invalidate_clock($c, $r --> gboolean) {
  $c.invalidate;
  $r.r = G_SOURCE_CONTINUE;
}

sub idle_resize ($a, $r) {
  my ($w, $h) = $a.get_size;  
  Clutter::Canvas.new($a.get_content).set_size($w.ceil, $h.ceil);
  $idle_resize_id = 0;
  $r.r = G_SOURCE_CONTINUE;
}

sub on_actor_resize ($a, $al, $f, $d) {
  return if $idle_resize_id;
  $idle_resize_id = Clutter::Threads.add-timeout(1000, -> *@a {
    idle_resize($a, @a[* - 1]);
  });
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;
  
  my $stage = Clutter::Stage.new;
  $stage.setup(
    title => '2D Clock',
    user-resizable => True,
    size => 300 xx 2,
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
  Clutter::Threads.add_timeout(100, -> *@a { 
    @a[*-1].r = invalidate_clock($canvas)  
  });
  
  Clutter::Main.run;
}
  
  
  
  
  
  
