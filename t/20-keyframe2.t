use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::Animator;
use Clutter::Container;
use Clutter::Main;
use Clutter::Stage;

sub new-rect {
  my $image_file = 'redhand.png';
  $image_file = "t/{$image_file}" unless $image_file.IO.e;
  die "Cannot find image file '{ $image_file }'" unless $image_file.IO.e;

  my $pixbuf = GDK::Pixbuf.new_from_file($image_file);
  my $rect = Clutter::Image.new;
  $image.set_data(
    $pixbuf.pixels,
    $pixbuf.has_alpha ??
      COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
    $pixbuf.width,
    $pixbuf.height,
    $pixbuf.rowstride
  );

  my $rect = Clutter::Actor.new;
  $icon.setup(
    name                    => 'rect',
    size                    => 128 xx 2,
    content                 => $image,
    content-scaling-filters => (
      CLUTTER_SCALING_FILTER_TRILINEAR,
      CLUTTER_SCALING_FILTER_LINEAR
    ),
  );
  $rect;
}

sub reverse-time ($t, $d) {
  $t.direction = $t.direction == CLUTTER_TIMELINE_FORWARD
    ?? CLUTTER_TIMELINE_BACKWARD
    !! CLUTTER_TIMELINE_FORWARD;

  $t.start;
}

constant COUNT = 4;

sub MAIN {
  exit(1) unless Clutter::Main.init;

  my $stage = Clutter::Stage.new.setup(
    title => 'Animator'
  );
  $stage.destroy.tap({ Clutter::Main.quit });

  my @rects;
  for ^COUNT {
    @rects.push: new-rect;
    given @rects[* - 1] {
      $stage.add-actor($_);
      .setup(
        anchor-point => (64, 64),
        position     => (320, 240),
        opacity      => 0x70
      );
    }
  }
  GLib::Timeout.add_seconds(10, -> *@a {
    @rects[2].destroy;
    G_SOURCE_REMOVE;
  });

  my $tx = Clutter::KeyframeTransition.new('x').setup(








}
