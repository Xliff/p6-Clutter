use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::LayoutManager;
use Clutter::Main;
use Clutter::Stage;

my @gravities = (
  CLUTTER_CONTENT_GRAVITY_TOP_LEFT      => 'Top Left',
  CLUTTER_CONTENT_GRAVITY_TOP           => 'Top',
  CLUTTER_CONTENT_GRAVITY_TOP_RIGHT     => 'Top Right'
   
  CLUTTER_CONTENT_GRAVITY_LEFT          => 'Left',
  CLUTTER_CONTENT_GRAVITY_CENTER        => 'Center',
  CLUTTER_CONTENT_GRAVITY_RIGHT         => 'Right',
   
  CLUTTER_CONTENT_GRAVITY_BOTTOM_LEFT   => 'Bottom Left',
  CLUTTER_CONTENT_GRAVITY_BOTTOM        => 'Bottom',
  CLUTTER_CONTENT_GRAVITY_BOTTOM_RIGHT  => 'Bottom Right',
  
  CLUTTER_CONTENT_GRAVITY_RESIZE_FILL   => 'Resize Fill',
  CLUTTER_CONTENT_GRAVITY_RESIZE_ASPECT => 'Resise Aspect'
);

my $cur_gravity = 0;

sub on_tap ($act, $a, $l) {
  my $actor = Clutter::Actor.new($a);
  my $gpair = @gravities[$cur_gravity];
  
  $actor.save_easing_state;
  $actor.content_gravity = ClutterContentGravity.enums.Hash{$gpair.key};
  $actor.restore_easing_state;
  
  $l.text = "Constant gravity: { $gpair.value }";
  $cur_gravity++;
  $cur_gravity = 0 if $last_gravity >= @gravities.enums;
}

sub MAIN {
  exit(EXIT_FAILURE) unless Clutter::Main.init;
  
  my $stage = Clutter::Stage.new;
  $stage.name = 'Stage';
  $stage.title = 'Content Box';
  $stage.user_resizable = True;
  $stage.destory.tap({ Clutter::Main.quit });
  $stage.margins = 12 xx 4;
  $stage.show;
  
  my $pixbuf = GTK::Compat::Pixbuf.new_from_file('redhand.png');
  my $image = Clutter::Image.new;
  $image.set_data(
    $pixbuf.pixels,
    $pixbuf.has_alpha ?? 
      COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
    $pixbuf.width,
    $pixbuf.height,
    $pixbuf.rowstride
  );
  
  my $grav = @gravities[*-1];
  $stage.set_conent_scaling_filters(
    CLUTTER_SCALING_FILTER_TRILINEAR,
    CLUTTER_SCALING_FILTER_LINEAR
  );
  $stage.content_gravity = ClutterContentGravity.enums.Hash{$grav.key};
  $stage.content = $image;
  
  my $text = Clutter::Texty.new(;
  $text.text = "Content gravity: { $grav.value }";
  $text.add_constraint( 
    Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.5)
  );
  $stage.add_child($text);
  
  my $action = Clutter::TapAction.new;
  $action.tap.tap(-> *@a { on-tap(|@a) });
  $stage.add_action($action);
  
  Clutter::Main.run;
}
      
  
