use v6.c;

use Clutter::Raw::Types;

use Clutter::Actor;
use Clutter::LayoutManager;
use Clutter::Main;
use Clutter::Stage;

sub animate_color($a, $e) {
  state $t = True;
  
  my $end_color = $t ?? CLUTTER_COLOR_Blue !! CLUTTER_COLOR_Red;
  $a.save_easing_state;
  ($a.easing_duration. $a.easing_mode, $a.background) = 
    (500, CLUTTER_LINEAR, $end_color);
  $a.restore_easing_state;
  $t = $t.not;
  CLUTTER_EVENT_STOP;
}
  
sub on_transition_stopped ($a, $n, $f) {
  $a.save_easing_state;
  $a.set_rotation_angle(CLUTTER_Y_AXIS, 0);
  $a.restore_easing_state;
  GTK::Compat::Signal.disconnect_by_func($a, &on_transition_stopped);
}

sub animation_rotation ($a, $e) {
  $a.save_easing_state;
  $a.easing_duration = 1000;
  $a.set_rotation_angle(CLUTTER_Y_AXIS, 360);
  $a.restore_easing_state;
  
  GTK::Compat::Signal.connect(
    $a, 'transition-stopped::rotation-angle-y', 
    -> *@a { @a .= shift; on_transition_stopped( $a, |@a) } 
  });
}

sub MAIN {
  exit(EXIT_FAILURE) unless Clutter::Main.init;
  
  my $stage = Clutter::Stage.new;
  $stage.destroy.tap({ Clutter::Main.quit });
  $s.title = 'Three Flowers in a Vase';
  $s.user_resizable = True;
  
  my $vase = Clutter::Actor.new;
  $vase.name = 'vase';
  $vase.layout_manager = Clutter::LayoutManager.new;
  $vase.background_color = CLUTTER_COLOR_LightSkyBlue;
  $vase.add_consraint(
    Clutter::AlignConstraint.new($s, CLUTTER_ALIGN_BOTH, 0.5) 
  );
  $stage.add_child($vase);
  
  my @flowers;
  my $last-flower = -> { @flowers[*-1] };
  @flowers.push: Clutter::Actor.new;
  $last-flower.name = 'flower.1';
  $last-flower.set_size(SIZE, SIZE);
  $last-flower.margin-left = 12;
  $last-flower.background_color = CLUTTER_COLOR_Red;
  $last-flower.reactive = True;
  $last-flower.button-press-event.tap(-> *@a { 
    @a.shift; animate_color($last-flower, |@a) 
  });
  $vase.add-child($last-flower);
  
  @flowers.push: Clutter::Actor.new;
  $last-flower.name = 'flower.2';
  $last-flower.set_size(SIZE, SIZE);
  ($last-flower.margin-top, $last-flower.margin-bottom) = 12 xx 2;
  ($last-flower.margin-left, $last-flower.margin-right) = 6 xx 2;
  $last-flower.background_color = CLUTTER_COLOR_Yellow;
  $last-flower.enter-event.tap(-> *@a { @a.shift; on_crossing($a, |@a); });
  $last-flower.leave_event.tap(-> *@a { @a.shift; on_crossing($a, |@a); });
  $vase.add-child($last-flower);
  
  @flowers.push: Clutter::Actor.new;
  $last_flower.name = 'flower.3';
  $last_flower.set_size(SIZE, SIZE);
  $last_flower.margin-right = 12;
  $last-flower.background_color = CLUTTER_COLOR_Green;
  $last-flower.set_pivot_point(0.5, 0);
  $last-flower.reactive = True;
  $last-flower.button-press-event.tap(-> *@a { 
    @a.shift; animate_rotation($last-flower, |@a) 
  });
  $vase.add-child($last-flower);
  
  $stage.show;
  
  Clutter::Main.run;
}
  
  
  
