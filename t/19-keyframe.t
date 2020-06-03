use v6.c;

use Clutter::Raw::Types;

use GLib::Rand;
use GLib::Timeout;
use GLib::Value;

use Clutter::Actor;
use Clutter::Color;
use Clutter::TransitionGroup;
use Clutter::KeyframeTransition;
use Clutter::Main;
use Clutter::Stage;

constant PADDING = 64;
constant SIZE    = 64;

my @colors = ($CLUTTER_COLOR_Red, $CLUTTER_COLOR_Green, $CLUTTER_COLOR_Blue);

sub yes-no ($b) {
  $b ?? 'yes' !! 'no'
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $s = Clutter::Stage.new.setup(
    title => 'Keyframe Transitions'
  );
  $s.destroy.tap({ Clutter::Main.quit });

  for ^3 {
    my $cur-x = PADDING;
    my $cur-y = PADDING + (SIZE + PADDING) * $_;
    my $new-x = $s.width - PADDING - SIZE;
    my $new-y = GLib::Rand.double-range(PADDING, $s.height - PADDING - SIZE);
    my $name  = "rect{ .fmt('%02d') }";
    my $rect  = Clutter::Actor.new.setup(
      name             => $name,
      background-color => @colors[$_],
      size             => SIZE xx 2,
      position         => (PADDING, $cur-y),
    );

    $s.add-child($rect);

    my $g = Clutter::TransitionGroup.new.setup(
      duration     => 2000,
      repeat-count => 1,
      auto-reverse => True
    );

    my $tx = Clutter::KeyframeTransition.new('x').setup(
      from-value => gv_flt($cur-x),
      to-value   => gv_flt($new-x),
      key-frames => 0.5.Array
    );
    # Internals not initialized by using set-key-frame!
    $tx.set-values( gv_flt($new-x / 2e0) );
    $tx.set_modes( CLUTTER_EASE_OUT_EXPO );

    my $ty = Clutter::KeyframeTransition.new('y').setup(
      from-value => gv_flt($cur-y),
      to-value   => gv_flt($cur-y),
      key-frames => 0.5.Array
    );
    # Internals not initialized by using set-key-frame!
    $ty.set-values( gv_flt($new-y) );
    $ty.set_modes( CLUTTER_EASE_OUT_EXPO );

    $g.add-transition($_) for $tx, $ty;
    $rect.add-transition('rectAnimation', $g);
    $rect.transition-stopped.tap(-> *@a {
      say "{ $rect.get-name }: transition stopped: { @a[1] } (finished: {
           yes-no(@a[2]) })";
    });
  }

  $s.show-actor;

  Clutter::Main.run;
}
