use v6.c;

# Example code lifted from:
# https://developer.gnome.org/clutter-cookbook/stable/animations-path.html
# Example 5.17

use Clutter::Raw::Types;

use GTK::Compat::Timeout;
use GTK::Compat::Value;

use Clutter::Main;

use Clutter::Actor;
use Clutter::Color;
use Clutter::KeyframeTransition;
use Clutter::Path;
use Clutter::PathConstraint;
use Clutter::Stage;

constant STAGE_SIDE = 400;

my $stage-color = Clutter::Color.new(0x33, 0x33, 0x55, 0xff);
my $red-color = Clutter::Color.new(0xff, 0, 0, 0xff);

sub build_circular_path($cx, $cy, $r) {
  constant κ = 4 * (2.sqrt - 1) / 3;
  
  my $path = Clutter::Path.new;
  
  given $path {
    .add-move-to($cx + $r, $cy);
    .add-curve-to(
      $cx + $r,     $cy + $r * κ,
      $cx + $r * κ, $cy + $r,
      $cx,          $cy + $r
    );
    .add-curve-to(
      $cx - $r * κ, $cy + $r,
      $cy - $r,     $cy + $r * κ,
      $cx - $r,     $cy 
    );
    .add-curve-to(
      $cx - $r,     $cy - $r * κ,
      $cx - $r * κ, $cy - $r,
      $cx,          $cy - $r
    );
    .add-curve-to(
      $cx + $r * κ, $cy - $r,
      $cx + $r,     $cy - $r * κ,
      $cx + $r,     $cy
    );
    .add-close;
  }
  $path;
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;
  
  my $path = build_circular_path(STAGE_SIDE / 2, STAGE_SIDE / 2, STAGE_SIDE / 4);
  my $constraint = Clutter::PathConstraint.new($path, 0);
  
  my $stage = Clutter::Stage.new.setup(
    size             => STAGE_SIDE xx 2,
    background-color => $stage-color
  );
  
  my $rectangle = Clutter::Actor.new.setup(
    size             => (STAGE_SIDE / 8) xx 2,
    background-color => $CLUTTER_COLOR_Red,
    position         => (STAGE_SIDE / 2) xx 2,
    constraint       => $constraint
  );
  $stage.add-child($rectangle);
  
  # Keyframe creation should have a helper function where things can 
  # be simplified. Propose two variants to the below:
  #   .set-modevalues -> Takes an array of tuples: 
  #      (Transition = CLUTTER_LINEAR, GValue)
  #   Keyframes are then set equally between the number of tuples.
  # 
  #   .set-values -> Takes an array of GValues and a mode (defaults to CLUTTER_LINEAR).
  #   As with set-modevalues, keyframes are split equally with MODE applied to 
  #   ALL keyframes. 
  #   
  #   Method resolution would be .set-values -> .set-modevalues
  # my $animator = Clutter::KeyframeTransition.new('offset').setup(
  #   duration     => 4000,
  #   repeat-count => -1,
  #   auto-reverse => True,
  #   key-frames   => (0, 1),
  #   modes        => CLUTTER_LINEAR xx 2,
  #   values       => ( gv_flt(0), gv_flt(1) )
  # );

  # Animator is not currently working, so equivalent code.
  my $o = 0;
  my $s = 1 / 30;
  GTK::Compat::Timeout.simple_timeout($s ** -1).act(
    -> @ ($t, $dt) {
      $constraint.offset = $o;
      $o += $s;
      $s *= -1 if $o > 1 or $o < 0;
      $o = 1 if $o > 1;
      $o = 0 if $o < 0;
    }
  );
  
  # $stage.key-press-event.tap(-> *@a {
  #   say "S: { $animator.is-playing }";
  #   $animator.start unless $animator.is-playing;
  #   @a[* - 1].r = 1;
  # });
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.show-actor;
  
  Clutter::Main.run;
}
