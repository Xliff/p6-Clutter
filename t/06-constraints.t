use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::AlignConstraint;
use Clutter::BindConstraint;
use Clutter::Color;
use Clutter::SnapConstraint;

use Clutter::Stage;

use Clutter::Main;

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $stage = Clutter::Stage.new;
  $stage.setup(
    title => 'Snap Constraint',
    background-color => $CLUTTER_COLOR_Aluminium1,
    user-resizable => True,
  );
  $stage.destroy.tap({ Clutter::Main.quit });

  my $layer_a = Clutter::Actor.new;
  $layer_a.setup(
    background-color => $CLUTTER_COLOR_ScarletRed,
    size => (100, 25),
    name => 'layerA'
  );
  $layer_a.add_constraint(
    Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.5)
  );
  $stage.add_child($layer_a);

  my $layer_b = Clutter::Actor.new;
  $layer_b.setup(
    background-color => $CLUTTER_COLOR_DarkButter,
    name => 'layerB',
  );
  $layer_b.add-constraints(
    Clutter::BindConstraint.new($layer_a, CLUTTER_BIND_X, 0),
    Clutter::BindConstraint.new($layer_a, CLUTTER_BIND_WIDTH, 0),
    Clutter::SnapConstraint.new(
      $layer_a, CLUTTER_SNAP_EDGE_TOP, CLUTTER_SNAP_EDGE_BOTTOM, 10
    ),
    Clutter::SnapConstraint.new(
      $stage, CLUTTER_SNAP_EDGE_BOTTOM, CLUTTER_SNAP_EDGE_BOTTOM, -10
    )
  );
  $stage.add-child($layer_b);

  my $layer_c = Clutter::Actor.new;
  $layer_c.setup(
    background-color => $CLUTTER_COLOR_LightChameleon,
    name => 'layerC'
  );
  $layer_c.add-constraints(
    Clutter::BindConstraint.new($layer_a, CLUTTER_BIND_X, 0),
    Clutter::BindConstraint.new($layer_a, CLUTTER_BIND_WIDTH, 0),
    Clutter::SnapConstraint.new(
      $layer_a, CLUTTER_SNAP_EDGE_BOTTOM, CLUTTER_SNAP_EDGE_TOP, -10
    ),
    Clutter::SnapConstraint.new(
      $stage, CLUTTER_SNAP_EDGE_TOP, CLUTTER_SNAP_EDGE_TOP, 10
    )
  );
  $stage.add-child($layer_c);

  $stage.show-actor;

  Clutter::Main.run;
}
