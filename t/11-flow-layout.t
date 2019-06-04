use v6.c;

# Find the original implementation here:
# https://gitlab.gnome.org/GNOME/clutter/blob/master/examples/flow-layout.c

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::BindConstraint;
use Clutter::Color;
use Clutter::FlowLayout;
use Clutter::Stage;

use Clutter::Main;

constant N_RECTS = 20;

sub MAIN (
  :$random-size     = 0,          #= Randomly size the rectangles
  :$num-rects       = N_RECTS,    #= Number of rectangles
  :$vertical        = 0,          #= Set vertical orientation
  :$homogeneous     = 0,          #= Whether the layout should be homogeneous
  :$x-spacing       = 0,          #= Horizontal spacing between elements
  :$y-spacing       = 0,          #= Vertical spacing between elements
  :$fixed-size      = 0,          #= Fix the layout size
  :$no-snap-to-grid = 0           #= Don't snao elements to grid
) {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $stage = Clutter::Stage.new.setup(
    background-color => $CLUTTER_COLOR_LightSkyBlue,
    title => 'Flow Layout',
    user-resizable => True
  );
  $stage.destroy.tap({ Clutter::Main.quit });

  my $layout = Clutter::FlowLayout.new(
    $vertical ?? CLUTTER_FLOW_VERTICAL !! CLUTTER_FLOW_HORIZONTAL
  ).setup(
    homogeneous    => $homogeneous.so,
    column-spacing => $x-spacing,
    row-spacing    => $y-spacing,
    snap-to-grid   => $no-snap-to-grid.so.not,
  );

  my $box = Clutter::Actor.new.setup(
    name             => 'box',
    layout-manager   => $layout,
    background-color => $CLUTTER_COLOR_Aluminium2,
    position         => (0, 0),
  );
  $stage.add-child($box);
  $box.add-constraint(
    Clutter::BindConstraint.new($stage, CLUTTER_BIND_SIZE, 0)
  ) if $fixed-size.so.not;

  for ^$num-rects {
    my $color = Clutter::Color.new_from_hls(
      360 * $_ / $num-rects, 0.5, 0.8, :alpha(255)
    );
    $box.add-child( Clutter::Actor.new.setup(
        background-color => $color,
        name             => "rect{ $_.fmt('%02d') }",
        size             => ( $random-size ?? (50..100).rand.Int !! 50 ) xx 2,
      )
    );
  }

  $stage.show-actor;

  Clutter::Main.run;
}
