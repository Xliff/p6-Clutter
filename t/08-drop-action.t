use v6.c;

# Original version of this test can be found, here:
# https://gitlab.gnome.org/GNOME/clutter/blob/e20594f83bd123c9904c18d6b3fd766c1433cd2c/examples/drop-action.c

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::AlignConstraint;
use Clutter::Color;
use Clutter::DragAction;
use Clutter::DropAction;
use Clutter::Stage;

use Clutter::Main;

constant TARGET_SIZE = 200;
constant HANDLE_SIZE = 128;

my %globals;

sub on-drag-end ($act, $a, $ex, $ey, $m, $ud) {
  CATCH { default { .message.say } }
  my $h = $act.drag-handle;
  say "Drag ended at: { $ex.fmt('%.0f')}, { $ey.fmt('%0.f') }";

  say "$act / $h / {$h.^name}";

  my $actor = Clutter::Actor.new($a);
  $actor.save-easing-state;
  $actor.easing-mode = CLUTTER_LINEAR;
  $actor.opacity = 255;
  $actor.restore-easing-state;

  $h.save-easing-state;
  if not %globals<drop-successful> {
    my $p = $actor.parent;
    $p.save-easing-state;
    $p.easing-mode = CLUTTER_LINEAR;
    $p.opacity = 255;
    $p.restore-easing-state;

    my ($x, $y) = $actor.get-transformed-position;
    $h.easing-mode = CLUTTER_EASE_OUT_BOUNCE;
    $h.set-position($x, $y);
    $h.opacity = 0;
  } else {
    $h.easing-mode = CLUTTER_LINEAR;
    $h.opacity = 0;
  }
  $h.restore-easing-state;

  $h.transitions-completed.tap({
    $h.destroy-actor;
  });
}

sub on-drag-begin ($act, $a, $ex, $ey, $m, $ud) {
  CATCH { default { .message.say } }
  say 'on-drag-begin';
  my $actor = Clutter::Actor.new($a);
  my ($x, $y) = $actor.get-position;

  my $h = Clutter::Actor.new;
  $h.setup(
    background-color => $CLUTTER_COLOR_SkyBlue,
    size             => 128 xx 2,
    position         => ($ex - $x, $ey - $y),
  );
  %globals<stage>.add-child($h);
  $act.drag-handle = $h;
  $actor.save-easing-state;
  $actor.easing-mode =  CLUTTER_LINEAR;
  $actor.opacity = 128;
  $actor.restore-easing-state;
  %globals<drop-successful> = False;
  say 'on-drag-begin exit';
}

sub add-drag-object($t) {
  CATCH { default { .message.say } }
  if not %globals<drag>.defined {
    my $action = Clutter::DragAction.new;
    $action.drag-begin.tap(-> *@a { on-drag-begin(|@a) });
    $action.drag-end.tap(  -> *@a {   on-drag-end(|@a) });

    %globals<drag> = Clutter::Actor.new;
    %globals<drag>.setup(
      background-color => $CLUTTER_COLOR_LightSkyBlue,
      size             => HANDLE_SIZE xx 2,
      position         => ((TARGET_SIZE - HANDLE_SIZE) / 2) xx 2,
      reactive         => True,
      action           => $action
    );
  }

  my $parent = %globals<drag>.get-parent;
  if [&&](
    $parent.defined,
    $t.defined,
    $parent.ClutterActor.p == $t.ClutterActor.p
  ) {
    $t.save-easing-state;
    $t.easing-mode = CLUTTER_LINEAR;
    $t.opacity = 255;
    $t.restore-easing-state;
    return;
  }

  %globals<drag>.upref;
  if $parent.defined &&
     $parent.ClutterActor.p != %globals<stage>.ClutterActor.p
  {
    $parent.remove-child(%globals<drag>);
    $parent.save-easing-state;
    $parent.easing-mode = CLUTTER_LINEAR;
    $parent.opacity = 64;
    $parent.restore-easing-state;
  }

  $t.add-child(%globals<drag>);
  $t.save-easing-state;
  $t.easing-mode = CLUTTER_LINEAR;
  $t.opacity = 255;
  $t.restore-easing-state;
  %globals<drag>.downref;
}

sub on-target-over ($act, $a, $io) {
  CATCH { default { .message.say } }
  say 'target-over';
  my $fo = $io ?? 128 !! 64;
  my $t = $act.get-actor;
  $t.save-easing-state;
  $t.easing-mode = CLUTTER_LINEAR;
  $t.opacity = $fo;
  $t.restore-easing-state;
}

sub on-target-drop($act, $a, $ex, $ey) {
  CATCH { default { .message.say } }
  say 'target-drop';
  my $actor = Clutter::Actor.new($a);
  my ($ax, $ay) = $actor.transform-stage-point($ex, $ey);
  say "Dropped at { $ax.fmt('%0.f') }, { $ay.fmt('%0.f') } (screen: {
      $ex.fmt('%0.f') }, { $ey.fmt('%0.f') })";
  %globals<drop-successful> = True;
  add-drag-object($actor);
}

sub setupDrop ($d) {
  $d.over-in.tap( -> *@a { @a.pop; on-target-over(|@a, True)  });
  $d.over-out.tap(-> *@a { @a.pop; on-target-over(|@a, False) });
  $d.drop.tap(    -> *@a { on-target-drop(|@a); });
}

sub MAIN {
  my $drop;
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  %globals<stage> = Clutter::Stage.new;
  %globals<stage>.title = 'Drop Action';
  %globals<stage>.destroy.tap({ Clutter::Main.quit });

  %globals<target1> = Clutter::Actor.new;
  %globals<target1>.setup(
    background-color   => $CLUTTER_COLOR_LightScarletRed,
    size               => TARGET_SIZE xx 2,
    opacity            => 64,
    x                  => 10,
    reactive           => True,
    action-with-name   => ('drop', ($drop = Clutter::DropAction.new)),
    constraint         => Clutter::AlignConstraint.new(
      %globals<stage>, CLUTTER_ALIGN_Y_AXIS, 0.5
    )
  );
  setupDrop($drop);
  add-drag-object(%globals<target1>);

  my $dummy = Clutter::Actor.new;
  $dummy.setup(
    background-color => $CLUTTER_COLOR_Orange,
    size             => ( 640 - 2 * 10 - 2 * (TARGET_SIZE + 10), TARGET_SIZE ),
    reactive         => True,
    constraints      => [
      Clutter::AlignConstraint.new(%globals<stage>, CLUTTER_ALIGN_X_AXIS, 0.5),
      Clutter::AlignConstraint.new(%globals<stage>, CLUTTER_ALIGN_Y_AXIS, 0.5)
    ],
  );

  %globals<target2> = Clutter::Actor.new;
  %globals<target2>.setup(
    background-color => $CLUTTER_COLOR_LightChameleon,
    size             => TARGET_SIZE xx 2,
    opacity          => 64,
    reactive         => True,
    x                => 640 - TARGET_SIZE - 10,
    action-with-name => ('drop', $drop = Clutter::DropAction.new),
    constraint       => Clutter::AlignConstraint.new(
      %globals<stage>, CLUTTER_ALIGN_Y_AXIS, 0.5
    ),
  );
  setupDrop($drop);

  %globals<stage>.add-child($_)
    for %globals<target1>, $dummy, %globals<target2>;
  %globals<stage>.show-actor;

  Clutter::Main.run;
}
