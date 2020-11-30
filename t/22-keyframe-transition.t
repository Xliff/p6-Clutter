use v6.c;

# Raku port of:
# https://gitlab.gnome.org/GNOME/mutter/blob/3.31.2/clutter/tests/interactive/test-animator.c
# Note the use of ClutterKeyframeTransition in lieu of the deprecated ClutterAnimator

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

  my (@rects, $g);
  for ^COUNT {
    @rects.push: new-rect;
    $stage.add-child(
      @rects.tail.setup(
        pivot-point => (64, 64),
        position    => (320, 240),
        #opacity     => 0x70
      )
    ) if $_ == 1;

    my (@transitions, @frames, @xv, @yv);

    when 0 | 3 {
      @frames = 0, 0.25 ... 1;
      @xv = (180, 450, 450, 180, 180).map({ gv_flt($_) });
      @yv = (100, 100, 380, 380, 100).map({ gv_flt($_) });
      proceed;
    }

    # when 0 {
    #   @rects[0].set-scale(1.4, 1.4);
    #   @transitions.push: Clutter::KeyframeTransition.new('x').setup(
    #     key-frames => (0, 0.25, 0.5, 0.75, 1),
    #   );
    #   @transitions.tail.set-values(@xv);
    #   @transitions.tail.set-modes(CLUTTER_LINEAR xx @frames.elems);
    #   @transitions.push: Clutter::KeyframeTransition.new('x').setup(
    #     key-frames => (0, 0.25, 0.5, 0.75, 1),
    #   );
    #   @transitions.tail.set-values(@yv) ;
    #   @transitions.tail.set-modes(CLUTTER_LINEAR xx @frames.elems);
    #   proceed;
    # }

    when 1 {
      @transitions.push: Clutter::KeyframeTransition.new('opacity').setup(
        key-frames => 0.5.Array,
        from_value => gv_flt(0.25),
        to_value   => gv_flt(1)
      );
      @transitions.tail.set-values( gv_flt(0.625) );
      @transitions.tail.set-modes(CLUTTER_LINEAR);
      # @transitions.push: Clutter::KeyframeTransition.new('scale_y').setup(
      #   key-frames => 0.5.Array,
      #   from_value => gv_flt(1),
      #   to_value   => gv_flt(2)
      # );
      # @transitions.tail.set-values( gv_flt(1.5) );
      # @transitions.tail.set-modes(CLUTTER_LINEAR);
      proceed;
    }

    when 2 {
      @transitions.push: Clutter::KeyframeTransition.new('rotation-angle-y').setup(
        key-frames => (0, 1),
      );
      @transitions.tail.set-values( gv_flt(0), gv_flt(360) );
      @transitions.tail.set-modes(CLUTTER_LINEAR xx 2);
      proceed;
    }

    # when 3 {
    #   @transitions.push: Clutter::KeyframeTransition.new('x').setup(
    #     key-frames => @frames,
    #   );
    #   @transitions.tail.set-values( @xv.rotate(-1) );
    #   @transitions.tail.set-modes(CLUTTER_LINEAR xx @xv.elems);
    #   @transitions.push: Clutter::KeyframeTransition.new('y').setup(
    #     key-frames => @frames,
    #   );
    #   @transitions.tail.set-values( @yv.rotate(1) );
    #   @transitions.tail.set-modes(CLUTTER_LINEAR xx @yv.elems);
    #   proceed;
    # }

    default {
      @transitions.gist.say;

      $g = Clutter::TransitionGroup.new.setup(
        duration     => 5000,
        auto-reverse => True,
        repeat-count => 2
      );
      for @transitions {
        .elems.say;
        $g.add-transition($_);
        .started.tap({
          say "Animation started"
        });
      }
      say "{ @rects.tail }";
      @rects.tail.add-transition("rect{$_}Animation", $g);

      @rects.tail.transition-stopped.tap(-> *@a {
        say "rect{$_}Animation stopped"
      });
      @rects.tail.transitions-completed.tap(-> *@a {
        say "rect{$_}Animation completed"
      });
    }
  }
  @rects.map( *.Str ).gist.say;

  GLib::Timeout.add_seconds(10, -> *@a {
    # @rects[2].destroy;
    G_SOURCE_REMOVE;
  });

  $stage.show-actor;

  Clutter::Main.run;
}
