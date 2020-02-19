use v6.c;

use Clutter::Raw::Types;

use GLib::Timeout;
use GLib::Value;
use GDK::Pixbuf;
use Clutter::Actor;
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
    my @transitions = do gather {
      my @frames = 0, 0.25 ... 1;
      my @xv = (180, 450, 450, 180, 180).map({ gv_flt($_) });
      my @yv = (100, 100, 380, 380, 100).map({ gv_flt($_) });

      when 0 {
        @rects[0].set-scale(1.4, 1.4);
        take Clutter::KeyframeTransition.new('x').setup(
          key-frames => @frames,
          modes      => CLUTTER_LINEAR xx @frames.elems,
          values     => @xv
        );
        take Clutter::KeyframeTransition.new('x').setup(
          key-frames => @frames,
          modes      => CLUTTER_LINEAR xx @frames.elems,
          values     => @yv
        );
      }

      when 1 {
        take Clutter::KeyframeTransition.new('scale-x').setup(
          key-frames => (0, 1),
          modes      => CLUTTER_LINEAR xx 2,
          values     => ( gv_flt(1), gv_flt(2) )
        );
        take Clutter::KeyframeTransition.new('scale-y').setup(
          key-frames => (0, 1),
          modes      => CLUTTER_LINEAR xx 2,
          values     => ( gv_flt(1), gv_flt(2) )
        );
      }

      when 2 {
        take Clutter::KeyframeTransition.new('rotation-angle-y').setup(
          key-frames => (0, 1),
          modes      => CLUTTER_LINEAR xx 2,
          values     => ( gv_flt(0), gv_flt(360) )
        );
      }

      when 3 {
        take Clutter::KeyframeTransition.new('x').setup(
          key-frames => @frames,
          modes      => CLUTTER_LINEAR xx @frames.elems,
          values     => @xv.rotate(-1)
        );
        take Clutter::KeyframeTransition.new('y').setup(
          key-frames => @frames,
          modes      => CLUTTER_LINEAR xx @frames.elems,
          values     => @yv.rotate(1)
        );
      }
    }

    my $g = Clutter::TransitionGroup.new.setup(
      duration     => 5000,
      auto-reverse => True,
      repeat-count => -1
    );
    say @transitions.elems;
    $g.add-transition($_) for @transitions;
    @rects[* - 1].add-transition("rect{$_}Animation", $g);
  }

  GLib::Timeout.add_seconds(10, -> *@a {
    @rects[2].destroy;
    G_SOURCE_REMOVE;
  });

  $stage.show-actor;

  Clutter::Main.run;
}
