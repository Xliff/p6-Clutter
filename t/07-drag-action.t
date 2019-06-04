use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::Color;
use Clutter::DragAction;
use Clutter::DesaturateEffect;
use Clutter::PageTurnEffect;
use Clutter::PropertyTransition;
use Clutter::Point;
use Clutter::Stage;

# For gv_<Type> helpers.
use GTK::Compat::Value;

use Clutter::Main;

my %globals;

sub on_enter($a, $e, $ud, $r) {
  my $t = $a.get_transition('curl');
  unless $t.defined {
    $t = Clutter::PropertyTransition.new('@effects.curl.period');
    $t.duration = 250;
    $a.add_transition('curl', $t);
  }
  $t.set-from-value( gv_dbl(0) );
  $t.set-to-value( gv_dbl(0.25) );
  $t.rewind;
  $t.start;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on_leave ($a, $e, $ud, $r) {
  my $t = $a.get_transition('curl');
  unless $t.defined {
    $t = Clutter::PropertyTransition.new('@effects.curl.period');
    $t.duration = 250;
    $a.add_transition('curl', $t);
  }
  $t.set-from-value( gv_dbl(0.25) );
  $t.set-to-value( gv_dbl(0) );
  $t.rewind;
  $t.start;
  $r.r = CLUTTER_EVENT_STOP;
}

sub on-drag-begin ($act, $a, $ex, $ey, $m, $ud) {
  CATCH { default { .message.say } }
  my $dh;
  my $actor = Clutter::Actor.new($a);
  if $m +& CLUTTER_SHIFT_MASK  {
    my $s = $actor.get-stage;
    $dh = Clutter::Actor.new;
    $dh.set_size(48, 48);
    $dh.background-color = $CLUTTER_COLOR_DarkSkyBlue;;
    $s.add-child($dh);
    $dh.show-actor;
    $dh.set_position($ex, $ey);
  } else {
    $dh = $actor;
  }
  $act.drag-handle = $dh;

  # Fully desaturate the actor
  my $t = $actor.get_transition('disable');
  if not $t.defined {
    $t = Clutter::PropertyTransition.new('@effects.disable.factor');
    $t.duration = 250;
    $actor.add_transition('disable', $t);
  }
  $t.set-from-value( gv_dbl(0) );
  $t.set-to-value( gv_dbl(1) );
  $t.rewind;
  $t.start;
}

sub on-drag-end ($act, $a, $ex, $ey, $m, $ud) {
  CATCH { default { .message.say } }

  my ($dh, $actor, $p) = ( $act.drag-handle, Clutter::Actor.new($a) );
  # Compare pointers
  if $a.p != $dh.ClutterActor.p {
    $dh.save-easing-state;
    $dh.easing-mode = CLUTTER_LINEAR;
    $dh.opacity = 0;
    $dh.restore-easing-state;
    $p = $actor.parent;

    my ($rx, $ry) = $p.transform-stage-point($ex, $ey);
    $actor.save-easing-state;
    $actor.easing-mode = CLUTTER_EASE_OUT_CUBIC;
    $actor.set-position($rx, $ry);
    $actor.restore-easing-state;
  }

  my $t = $actor.get_transition('disable');
  unless $t.defined {
    $t = Clutter::PropertyTransition.new('@effects.disable.factor');
    $t.duration = 250;
    $actor.add-transition($t);
  }

  $t.set-from-value( gv_dbl(1) );
  $t.set-to-value( gv_dbl(0) );
  $t.rewind;
  $t.start;
}

sub get_drag_axis ($str) {
  return CLUTTER_DRAG_AXIS_NONE unless $str.defined && str.chars;
  do given $str.lc {
    when 'x' { CLUTTER_DRAG_X_AXIS    }
    when 'y' { CLUTTER_DRAG_Y_AXIS    }
    default  { CLUTTER_DRAG_AXIS_NONE }
  }
}

sub MAIN (
  Int :$x-threshold = 0,   #= Set the horizontal drag threshold (in pixels)
  Int :$y-threshold = 0,   #= Set the vertical drag threshold (in pixels)
  Int :$axis        = 0    #= Set the drag axis. Valid values are: 0 = None, 1 = X, 2 = Y
) {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $action = Clutter::DragAction.new;
  $action.set-drag-threshold($x-threshold, $y-threshold);
  $action.drag-axis = $axis;
  $action.drag-begin.tap(-> *@a { CATCH { default { .message.say } }; say 'odb'; on-drag-begin(|@a) });
  $action.drag-end.tap(  -> *@a { on-drag-end(|@a) });

  my $handle = Clutter::Actor.new;
  $handle.setup(
    background-color  => $CLUTTER_COLOR_SkyBlue,
    size              => 128 xx 2,
    position          => Clutter::Point.new( (800 - 128) / 2, (600 - 128) / 2 ),
    reactive          => True,
    action            => $action,
    effects-with-name => (
      [ 'disable', Clutter::DesaturateEffect.new(0)       ],
      [ 'curl',    Clutter::PageTurnEffect.new(0, 45, 12) ]
    )
  );
  $handle.enter-event.tap(-> *@a { on_enter(|@a) });
  $handle.leave-event.tap(-> *@a { on_leave(|@a) });

  %globals<stage> = Clutter::Stage.new;
  %globals<stage>.setup(
    title   => 'Drag Test',
    size    => (800, 600),
    child   => $handle
  );
  %globals<stage>.destroy.tap({ Clutter::Main.quit });
  %globals<stage>.show-actor;

  Clutter::Main.run;
}
