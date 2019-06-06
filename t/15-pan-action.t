use v6.c;

use GTK::Compat::Types;

use Clutter::Compat::Types;
use Clutter::Raw::Types;
use Clutter::Raw::Keysyms;

use GTK::Compat::Pixbuf;

use Clutter::Actor;
use Clutter::BoxLayout;
use Clutter::Image;
use Clutter::ScrollActor;
use Clutter::Stage;
use Clutter::Text;

use Clutter::Main;

sub create-content-actor {
  my $file = 'redhand.png';
  $file = "t/{$file}" unless $file.IO.e;
  die "Cannot find image file '{$file}'" unless $file.IO.e;
  
  my $pixbuf = GTK::Compat::Pixbuf.new_from_file($file);
  (my $image = Clutter::Image.new).set-data(
    $pixbuf.pixels,
    $pixbuf.has-alpha ?? COGL_PIXEL_FORMAT_RGBA_8888 !! COGL_PIXEL_FORMAT_RGB_888,
    $pixbuf.width,
    $pixbuf.height,
    $pixbuf.rowstride
  );
  Clutter::Actor.new.setup(
    size                    => (720, 720),
    content                 => $image,
    content-gravity         => CLUTTER_CONTENT_GRAVITY_RESIZE_ASPECT,
    content-scaling-filters => (
      CLUTTER_SCALING_FILTER_TRILINEAR,
      CLUTTER_SCALING_FILTER_LINEAR
    )
  );
}

sub on-pan ($a, $s, $ii, $ud, $r) {
  my ($e, $dx, $dy) = ( ClutterEvent.new );
  
  if $ii {
    ($dx, $dy) = $a.get-motion-delta(0);
  } else {
     my $ga = Clutter::GestureAction.new($a.ClutterAction);
     ($dx, $dy) = $ga.get-motion-delta(0);
     $e = $ga.get-last-event(0);
  }
   
  say "[{ do if    $e.defined.not                  { 'INTERPOLATED' }
             elsif $e.type == CLUTTER_MOTION       { 'MOTION'       }
             elsif $e.type == CLUTTER_TOUCH_UPDATE {'TOUCH_UPDATE'  }
             else                                  { '?' }
      }] panning dx:{ $dx.round(1e-2) } dy:{ $dy.round(1e-2) }";
  $r.r = 1;
}

sub create-scroll-actor ($s) {
  my $pa = Clutter::PanAction.new;
  $pa.set-interpolate = True;
  $pa.pan.tap(-> *@a { on-pan(|@a) });
  
  Clutter::Actor.new.setup(
    name => 'scroll',
    constraints => [
      Clutter::AlignConstraint.new($s, CLUTTER_ALIGN_X_AXIS, 0),
      Clutter::BindConstraint.new($s, CLUTTER_BIND_SIZE, 0)
    ],
    child => create-content-actor;
    reactive => True,
    action-with-name => ('pan', $pa)
  );
}

sub on-key-press ($s, $e, $ud, $r) {
  my $scroll = $s.get-first-child;
  if Clutter::Eventnew($e).key-symbol == CLUTTER_KEY_space {
    $scroll.save-easing-state;
    $scroll.easing-duration = 100;
    $scroll.set-child-transform(ClutterMatrix);
    $scroll.restore-easing-stage;
  }
  $r.r = CLUTTER_EVENT_STOP;
}
  
sub on-label-clicked($l, $e, $scroll, $r) {
  my $action = Clutter::PanAction.new( 
    cast( ClutterPanAction, $scroll.get-action('pan', :raw) ) 
  );
  $action.set-pan-axis( 
    do given $l.text {
      when 'X AXIS' { CLUTTER_PAN_X_AXIS    }
      when 'Y AXIS' { CLUTTER_PAN_Y_AXIS    }
      when 'AUTO'   { CLUTTER_PAN_AXIS_AUTO }
      default       { CLUTTER_PAN_AXIS_NONE }
    }
  );
  $r.r = 1;
}

sub add-label($t, $b, $s) {
  my $label = Clutter::Text.new-with-text(Str, $t).setup(
    reactive => True,
    x-align  => CLUTTER_ACTOR_ALIGN_START,
    x-expand => True
  );
  $b.add-child($label);
  $label.button-release-event(-> *@a { @a[2] = $s; on-label-clicked(|@a) });
}

sub MAIN {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;
  
  (my $stage = Clutter::Stage.new.setup(
    name           => 'Pan Action',
    user-resizable => True,
  )).show-actor;
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.key-press-event.tap(-> *@a { on-key-press(|@a) });
  
  my $scroll = Clutter::ScrollActor.new;
  my $layout = Clutter::BoxLayout.new;
  $layout.orientation = CLUTTER_ORIENTATION_VERTICAL;
  my $box = Clutter::Actor.new.setup(
    position => (12, 12),
    layout-manager => $layout
  );
  
  my $info1 = Clutter::Text.new-with-text(
    Str, 'Press <space> to reset the image position.'
  );
  my $info2 = Clutter::Text.new-with-text(
    Str, 'Click labels below to change AXIS pinning.'
  );
  $box.add-child($_) for $info1, $info2;
  add-label($_, $box, $scroll) for 'NONE', 'X AXIS', 'Y AXIS', 'AUTO';
  $stage.add-child($_) for $scroll, $box;
  
  Clutter::Main.run;
}
  
