# Original Vala code can be found here:
# https://wiki.gnome.org/Projects/Vala/ClutterSamples

use v6.c;

use Clutter::Raw::Types;

use Pango::FontDescription;
use Clutter::Actor;
use Clutter::Color;
use Clutter::Main;
use Clutter::PropertyTransition;
use Clutter::Stage;
use Clutter::Text;
use Clutter::TransitionGroup;

my ($stage, @rectangles);
my @colors = «
  "blanched almond"
  OldLace
  MistyRose
  White
  LavenderBlush
  CornflowerBlue
  chartreuse
  chocolate
  "light coral"
  "medium violet red"
  RosyBrown
  LemonChiffon2
»;

sub create-rectangles {
  my $dim = $stage.height / @colors.elems;

  for @colors.kv -> $k, $v {
    @rectangles.push: Clutter::Actor.new.setup(
      size             => $dim xx 2,
      background-color => Clutter::Color.new-from-string($v),
      pivot-point      => Clutter::Point.new(0.5, 0.5),
      y                => $dim * $k
    );
    $stage.add-child( @rectangles.tail );
  }
}

sub start-demo {
  my @transitions = gather for @rectangles {
    my $group = Clutter::TransitionGroup.new.setup( duration => 2000 );
    my $trans-x = Clutter::PropertyTransition.new('x').setup(
      to            => $stage.width / 2 - .width / 2,
      duration      => 2000,
      progress-mode => CLUTTER_LINEAR
    );
    $group.add-transition($trans-x);
    my $trans-rz = Clutter::PropertyTransition.new('rotation_angle_z').setup(
      to            => 500,
      duration      => 2000,
      progress-mode => CLUTTER_LINEAR
    );
    $group.add-transition($trans-rz);
    .add-transition('rectAnimation', $group);
    take $trans-rz;
  }

  @transitions.tail.completed.tap({
    constant CONGRATS_EXPLODE_DURATION = 3000;

    my $fd = Pango::FontDescription.new-from-string('Btistream Vera Sans 40');
    my $text = Clutter::Text.new.setup(
      font-description => $fd,
      text             => 'Congratulations!',
      color            => Clutter::Color.new-from-string('white'),
      pivot-point      => Clutter::Point.new(0.5, 0.5),
    );
    $text.x = $stage.width / 2 - $text.width / 2;
    $text.y = -$text.height;
    $stage.add-child($text);

    my $trans-y = Clutter::PropertyTransition.new('y').setup(
      to            => $stage.height / 2 - $text.height / 2,
      duration      => CONGRATS_EXPLODE_DURATION / 2,
      progress_mode => CLUTTER_EASE_OUT_BOUNCE
    );
    $text.add-transition('rectAnimation', $trans-y);

    for @rectangles {
      my $group    = Clutter::TransitionGroup.new;
      my $trans-x  = Clutter::PropertyTransition.new('x').setup(
        to            => rand * $stage.width,
        duration      => CONGRATS_EXPLODE_DURATION,
        progress-mode => CLUTTER_EASE_OUT_BOUNCE,
      );
      my $trans-y2 = Clutter::PropertyTransition.new('y').setup(
        to            => rand * $stage.height + $stage.height / 2,
        duration      => CONGRATS_EXPLODE_DURATION,
        progress-mode => CLUTTER_EASE_OUT_BOUNCE,
      );
      my $trans-o = Clutter::PropertyTransition.new('opacity').setup(
        to            => 0,
        duration      => CONGRATS_EXPLODE_DURATION,
        progress-mode => CLUTTER_EASE_OUT_BOUNCE,
      );
      $group.add-transition($_) for $trans-x, $trans-y2, $trans-o;
      $group.duration = CONGRATS_EXPLODE_DURATION;
      $group.delay    = CONGRATS_EXPLODE_DURATION / 3;
      .add-transition('transbox', $group);
    }
  });
}

sub MAIN {
  exit(1) unless Clutter::Main.init;

  $stage = Clutter::Stage.new.setup(
    size             => 512 xx 2,
    background-color => $CLUTTER_COLOR_Black
  );

  $stage.hide.tap({ Clutter::Main.quit });
  create-rectangles;
  $stage.show-actor;
  start-demo;
  Clutter::Main.run;
}
