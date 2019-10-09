use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::Stage;
use Clutter::Timeline;
use Clutter::Main;

my @g;
sub create-rect($front-col, $back-col) {
  for Clutter::Actor.new xx 3 {
    .setup(
      size             => (128, 128),
    );
    @g.push: $_;
  }

  with @g[0] {
    .show-actor;
    .set-position(64, 64);
    .add-child($_) for @g[1, 2];
    .set-child-below-sibling( @g[1], @g[2] );
    .set-pivot-point(0.5, 0.5);
  }

  @g[1].background-color = $front-col;
  @g[2].background-color = $back-col;

  $*stage.add-child( @g[0] );

  @g[0];
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

	my $stage-color = Clutter::Color.new(   0,   0,   0, 255);
  my $red         = Clutter::Color.new( 255,   0,   0, 255);
  my $green       = Clutter::Color.new(   0, 255,   0, 255);
  my $blue        = Clutter::Color.new(   0,   0, 255, 255);
  my $yellow      = Clutter::Color.new( 255, 255,   0, 255);
  my $cyan        = Clutter::Color.new(   0, 255, 255, 255);
  my $purple      = Clutter::Color.new( 255,   0, 255, 255);

  my $*stage = Clutter::Stage.new.setup(
    background-color => $stage-color,
    size             => (256, 256),
  );
  $*stage.destroy.tap({ Clutter::Main.quit });

  my @rect;
  @rect.push: create-rect($red, $green);
  # @rect.push: create-rect($green);
  # @rect.push: create-rect($blue);
  # @rect.push: create-rect($yellow);
  # @rect.push: create-rect($cyan);
  # @rect.push: create-rect($purple);

  my ($timeline, $rotation) = (Clutter::Timeline.new(60), 0);
  $timeline.repeat-count = -1;
  $timeline.new-frame.tap(-> *@a {
    $rotation += 0.3;
    if $rotation < 270 {
      @rect[0].set-child-above-sibling(@g[1], @g[2]) unless $rotation % 90;
    }
    @rect[0].set-child-below-sibling(@g[1], @g[2]) unless $rotation % 270;
    @rect[0].set-child-above-sibling(@g[1], @g[2]) unless $rotation % 450;
    @rect[0].rotation-angle-y = $rotation;
  });
  $timeline.start;

  $*stage.show-actor;

	Clutter::Main.run;
}
