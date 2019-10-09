use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::Stage;
use Clutter::Timeline;
use Clutter::Main;

sub create-rect($col) {
  $*stage.add-child(
    my $a = Clutter::Actor.new.setup(
      size             => (256, 128),
      position         => (128, 128),
      background-color => $col,
      anchor-x         => 128,
      anchor-y         => 64
    )
  );
  $a.show-actor;

  $a;
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

	my $stage-color = Clutter::Color.new(   0,   0,   0, 255);
  my $red         = Clutter::Color.new( 255,   0,   0, 128);
  my $green       = Clutter::Color.new(   0, 255,   0, 128);
  my $blue        = Clutter::Color.new(   0,   0, 255, 128);
  my $yellow      = Clutter::Color.new( 255, 255,   0, 128);
  my $cyan        = Clutter::Color.new(   0, 255, 255, 128);
  my $purple      = Clutter::Color.new( 255,   0, 255, 128);

  my $*stage = Clutter::Stage.new.setup(
    background-color => $stage-color,
    size             => (256, 256),
  );
  $*stage.destroy.tap({ Clutter::Main.quit });

  my @rect;
  @rect.push: create-rect($red);
  @rect.push: create-rect($green);
  @rect.push: create-rect($blue);
  @rect.push: create-rect($yellow);
  @rect.push: create-rect($cyan);
  @rect.push: create-rect($purple);

  my ($timeline, $rotation) = (Clutter::Timeline.new(60), 0);
  $timeline.repeat-count = -1;
  $timeline.new-frame.tap(-> *@a {
    $rotation += 0.3;
    for @rect {
      .rotation-angle-z = $rotation * (@rect.elems - $++);
    }
  });
  $timeline.start;

  $*stage.show-actor;

	Clutter::Main.run;
}
