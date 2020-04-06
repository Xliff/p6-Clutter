use v6.c;

use Clutter::Raw::Keysyms;
use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::AlignConstraint;
use Clutter::BindConstraint;
use Clutter::BoxLayout;
use Clutter::Color;
use Clutter::Event;
use Clutter::Main;
use Clutter::ScrollActor;
use Clutter::Stage;
use Clutter::Text;

use GLib::Roles::Pointers;
use GLib::Roles::Object;

my %data;
our subset ObjectOrPointer of Mu where * ~~ (
  GLib::Roles::Object,
  GLib::Roles::Pointers,
).any;

sub get-data (ObjectOrPointer $i is copy, $k) {
  return unless $i;

  $i .= GObject if $i ~~ GLib::Roles::Object;
  %data{+$i.p}{$k};
}
sub set-data (ObjectOrPointer $i is copy, $k, $v) {
  return unless $i;

  $i .= GObject if $i ~~ GLib::Roles::Object;
  %data{+$i.p}{$k} = $v;
}

my @options = 'Option ' «~» (1..11);

sub select-item-at-index ($s, $i is copy) {
  CATCH { default { .message.say } }

  my $menu = $s.first-child;
  my $old-selected = get-data($s, 'selected-item');
  if $old-selected.defined {
    my $item = Clutter::Text.new(
      $menu.get-child-at-index($old-selected, :raw)
    );
    $item.color = $CLUTTER_COLOR_White;
  }

  $i = $menu.elems - 1 if $i < 0;
  $i = 0               if $i >= $menu.elems;

  my $p = Clutter::Point.new;
  my $item = Clutter::Text.new(
    $menu.get-child-at-index($i, :raw)
  ).setup(
    color => $CLUTTER_COLOR_LightSkyBlue
  );
  ($p.x, $p.y) = $item.get-position;

  $s.save-easing-state;
  $s.scroll-to-point($p);
  $s.restore-easing-state;

  set-data($s, 'selected-item', $i);
}

sub select-next-item ($s) {
  select-item-at-index($s, get-data($s, 'selected-item') + 1);
}

sub select-prev-item ($s) {
  select-item-at-index($s, get-data($s, 'selected-item') - 1);
}

sub create-menu-item($n) {
  Clutter::Text.new.setup(
    font-name    => 'Sans Bold 24',
    text         => $n,
    color        => $CLUTTER_COLOR_White,
    margin-left  => 12,
    margin-right => 12
  );
}

sub create-menu-actor ($s) {
  my $layout = Clutter::BoxLayout.new.setup(
    orientation => CLUTTER_ORIENTATION_VERTICAL,
    spacing     => 12
  );
  my $menu = Clutter::Actor.new.setup(
    layout-manager => $layout,
    background-color => $CLUTTER_COLOR_Black
  );
  $menu.add-child( create-menu-item($_) ) for @options;
  $menu;
}

sub create-scroll-actor ($stage) {
  my $s = Clutter::ScrollActor.new.setup(
    position    => (0, 18),
    scroll-mode => CLUTTER_SCROLL_VERTICALLY,
    constraints => [
      Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_X_AXIS, 0.5),
      Clutter::BindConstraint.new($stage, CLUTTER_BIND_HEIGHT, -36)
    ],
  );
  $s.add-child( create-menu-actor($s) );
  select-item-at-index($s, 0);
  $s
}

sub on-key-press ($s, $e, $u, $r) {
  given Clutter::Event.new($e).key-symbol {
    when CLUTTER_KEY_Up   { select-prev-item($s) }
    when CLUTTER_KEY_Down { select-next-item($s) }
  }
  $r.r = CLUTTER_EVENT_STOP;
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  my $stage = Clutter::Stage.new.setup(
    name           => 'Scroll Actor',
    user-resizable => True,
  );
  $stage.add-child( my $scroll = create-scroll-actor($stage) );
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.key-press-event.tap(-> *@a { @a[0] = $scroll; on-key-press( |@a ) });
  $stage.show-actor;

  Clutter::Main.run;
}
