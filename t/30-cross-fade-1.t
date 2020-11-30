use v6.c;

use Clutter::Raw::Types;

use GLib::Value;
use GDK::Pixbuf;
use Clutter::Actor;
use Clutter::BinLayout;
use Clutter::Color;
use Clutter::Image;
use Clutter::KeyframeTransition;
use Clutter::Main;
use Clutter::Stage;

sub fade-in ($a) {
  $a.save-easing-state;
  $a.easing-mode = CLUTTER_LINEAR;
  $a.easing-duration = $*duration;
  $a.opacity = 255;
  $a.restore-easing-state;
}

sub fade-out ($a) {
  $a.save-easing-state;
  $a.easing-mode = CLUTTER_LINEAR;
  $a.easing-duration = $*duration;
  $a.opacity = 0;
  $a.restore-easing-state;
}

sub MAIN (
  Str :$source is copy = 'redhand.png',     #= The source image of the cross-fade
  Str :$target is copy = 'kitty-face.jpg',  #= The target image of the cross-fade
  Int :$duration       = 1000               #= The duration of the cross-fade, in milliseconds
) {
  my (%textures, %actors);
  my $top-fade = False;
  my  $*duration = $duration;

  exit(1) unless Clutter::Main.init;

  my $stage = Clutter::Stage.new.setup(
    title            => 'cross-fade',
    size             => (400, 300),
  );

  my $box = Clutter::Actor.new.setup(
    size           => (400, 300),
    layout-manager => Clutter::BinLayout.new(
      CLUTTER_BIN_ALIGNMENT_CENTER,
      CLUTTER_BIN_ALIGNMENT_CENTER
    )
  );

  my $fade-in = Clutter::KeyframeTransition.new('opacity').setup(
    from-value => gv-uint(0),
    to-value   => gv-uint(255),
    key-frames => 0.5.Array,
    duration   => $duration
  );

  my $fade-out = Clutter::KeyframeTransition.new('opacity').setup(
    from-value => gv-uint(255),
    to-value   => gv-uint(0),
    key-frames => 0.5.Array,
    duration   => $duration
  );

  for $target, $source -> $_ is rw {
    my $var-name = .VAR.name.substr(1);

    $_ = "t/{$_}" unless .IO.e;
    die "Could not find {$var-name} file '{ $_ }'" unless .IO.e;

    my $pixbuf = GDK::Pixbuf.new_from_file($_);

    %textures{$var-name} = Clutter::Image.new;
    %textures{$var-name}.set_data(
      $pixbuf.pixels,
      $pixbuf.has_alpha ??
        COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
      $pixbuf.width,
      $pixbuf.height,
      $pixbuf.rowstride
    );

    my $a-name = $var-name eq 'source' ?? 'top' !! 'bottom';
    %actors{$a-name} = Clutter::Actor.new.setup(
      content          => %textures{$var-name},
      opacity          => $a-name eq 'source' ?? 255 !! 0,
      size             => $pixbuf.size
    );
    $box.add-child( %actors{$a-name} );
    %actors{$a-name}.show;
  }
  $stage.add-child($box);

  $stage.key-press-event.tap(-> *@a {
    # if $top-fade {
    #   %actors<top>.get-transition('fade-in').start;
    #   %actors<bottom>.get-transition('fade-out').start;
    # } else {
    #   if %actors<top>.get-transition('fade-out') -> $t {
    #     $t.start;
    #   } else {
    #     %actors<top>.add-transition('fade-out', $fade-out);
    #   }
    #
    #   if %actors<bottom>.get-transition('fade-in') -> $t {
    #     $t.start;
    #   } else {
    #     %actors<bottom>.add-transition('fade-in', $fade-in);
    #   }
    # }\
    if $top-fade {
      %actors<top>.&fade-in;
      %actors<bottom>.&fade-out;
    } else {
      %actors<top>.&fade-out;
      %actors<bottom>.&fade-in;
    }

    $top-fade .= not;
    @a[* - 1].r = 1;
  });

  $stage.destroy.tap({ Clutter::Main.quit });

  .show-actor for $box, $stage;

  Clutter::Main.run;
}
