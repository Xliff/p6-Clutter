use v6.c;

# Raku port of:
# https://gitlab.gnome.org/GNOME/mutter/blob/3.31.2/clutter/tests/interactive/test-animator.c
# Note the use of ClutterKeyframeTransition in lieu of the deprecated ClutterAnimator

use Clutter::Raw::Types;

use GLib::Timeout;
use GLib::Value;
use GDK::Pixbuf;
use Clutter::Actor;
use Clutter::Animator;
use Clutter::Image;
use Clutter::KeyframeTransition;
use Clutter::Main;
use Clutter::TransitionGroup;
use Clutter::Stage;

sub new-rect {
  my $image_file = 'redhand.png';
  $image_file = "t/{$image_file}" unless $image_file.IO.e;
  die "Cannot find image file '{ $image_file }'" unless $image_file.IO.e;

  my $pixbuf = GDK::Pixbuf.new_from_file($image_file);
  my $image = Clutter::Image.new;
  $image.set_data(
    $pixbuf.pixels,
    $pixbuf.has_alpha ??
      COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
    $pixbuf.width,
    $pixbuf.height,
    $pixbuf.rowstride
  );

  Clutter::Actor.new.setup(
    name                    => 'rect',
    size                    => 128 xx 2,
    content                 => $image,
    content-scaling-filters => (
      CLUTTER_SCALING_FILTER_TRILINEAR,
      CLUTTER_SCALING_FILTER_LINEAR
    ),
  );
}

constant COUNT = 4;

sub MAIN {
  exit(1) unless Clutter::Main.init;

  my $stage = Clutter::Stage.new.setup(
    title => 'Animator (Keyframes)'
  );
  $stage.destroy.tap({ Clutter::Main.quit });

  my @rects;
  my $a = Clutter::Animator.new;
  for ^COUNT {
    @rects.push: new-rect;
    given @rects[* - 1] {
      $stage.add-child($_);
      .setup(
        pivot-point => (64, 64),
        position    => (320, 240),
        opacity     => 0x70
      );
    }
    unless $_ {
      @rects[0].set-scale(1.4, 1.4);
      for <x y> {
        $a.property_set_ease_in(@rects[0], $_, True);
        $a.property_set_interpolation(
          @rects[0],
          $_,
          CLUTTER_INTERPOLATION_CUBIC
        );
      }
    }
  }

  $a.set(
    @rects[0], 'x',                      1,                    0.0,  180.0,
    @rects[0], 'x',                      CLUTTER_LINEAR,       0.25, 450.0,
    @rects[0], 'x',                      CLUTTER_LINEAR,       0.5,  450.0,
    @rects[0], 'x',                      CLUTTER_LINEAR,       0.75, 180.0,
    @rects[0], 'x',                      CLUTTER_LINEAR,       1.0,  180.0,

    @rects[0], 'y',                      -1,                   0.0,  100.0,
    @rects[0], 'y',                      CLUTTER_LINEAR,       0.25, 100.0,
    @rects[0], 'y',                      CLUTTER_LINEAR,       0.5,  380.0,
    @rects[0], 'y',                      CLUTTER_LINEAR,       0.75, 380.0,
    @rects[0], 'y',                      CLUTTER_LINEAR,       1.0,  100.0,

    @rects[1], 'scale-x',                0,                    0.0,  1.0,
    @rects[1], 'scale-x',                CLUTTER_LINEAR,       1.0,  2.0,
    @rects[1], 'scale-y',                0,                    0.0,  1.0,
    @rects[1], 'scale-y',                CLUTTER_LINEAR,       1.0,  2.0,

    @rects[2], 'rotation-angle-y',       0,                    0.0,  0.0,
    @rects[2], 'rotation-angle-y',       CLUTTER_LINEAR,       1.0,  360.0,

    @rects[3], 'x',                      0,                    0.0,  180.0,
    @rects[3], 'x',                      CLUTTER_LINEAR,       0.25, 180.0,
    @rects[3], 'x',                      CLUTTER_LINEAR,       0.5,  450.0,
    @rects[3], 'x',                      CLUTTER_LINEAR,       0.75, 450.0,
    @rects[3], 'x',                      CLUTTER_LINEAR,       1.0,  180.0,

    @rects[3], 'y',                      0,                    0.0,  100.0,
    @rects[3], 'y',                      CLUTTER_LINEAR,       0.25, 380.0,
    @rects[3], 'y',                      CLUTTER_LINEAR,       0.5,  380.0,
    @rects[3], 'y',                      CLUTTER_LINEAR,       0.75, 100.0,
    @rects[3], 'y',                      CLUTTER_LINEAR,       1.0,  100.0
  );

  my $t = $a.start;
  $t.completed.tap(-> *$a {
    $t.direction = $t.direction == CLUTTER_TIMELINE_FORWARD
      ?? CLUTTER_TIMELINE_BACKWARD
      !! CLUTTER_TIMELINE_FORWARD;
    $t.start;
  });

  GLib::Timeout.add_seconds(10, -> *@a {
    @rects[2].destroy;
    G_SOURCE_REMOVE;
  });

  $stage.hide-cursor;
  $stage.show-actor;

  Clutter::Main.run;
}
