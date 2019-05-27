use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Signal;

use Clutter::Actor;
use Clutter::AlignConstraint;
use Clutter::BoxLayout;
use Clutter::Main;
use Clutter::Stage;

constant SIZE = 128;

sub animate_color($a, $e) {
  CATCH { default { .message.say } }
  state $t = True;
  
  my $end_color = $t ?? CLUTTER_COLOR_Blue !! CLUTTER_COLOR_Red;
  $a.save_easing_state;;
  $a.easing-duration = 500;
  $a.easing-mode = CLUTTER_LINEAR;
  $a.background-color = $end_color;
  $a.restore_easing_state;
  $t = $t.not;
  CLUTTER_EVENT_STOP;
}

sub on_crossing ($a, $e) {
  CATCH { default { .message.say } }
  my $zpos = $e.type == CLUTTER_ENTER ?? -250 !! 0;
  $a.save_easing_state;
  $a.easing_duration = 500;
  $a.easing_mode = CLUTTER_EASE_OUT_BOUNCE;
  $a.z_position = $zpos;
  $a.restore_easing_state;
  CLUTTER_EVENT_STOP
}
  
sub on_transition_stopped ($a, $n, $f) {
  use NativeCall;
  
  sub sprintf-ts(Blob, Str, & (ClutterActor, Str, gboolean) --> int64)
    is native 
    is symbol('sprintf') {}
  
  $a.save_easing_state;
  $a.set_rotation_angle(CLUTTER_Y_AXIS, 0);
  $a.restore_easing_state;
      
  GTK::Compat::Signal.disconnect_by_func(
    $a, 
    set_func_pointer(
      &on_transition_stopped,
      &sprintf-ts
    )
  );
}

sub animation_rotation ($a, $e) {
  $a.save_easing_state;
  $a.easing_duration = 1000;
  $a.set_rotation_angle(CLUTTER_Y_AXIS, 360);
  $a.restore_easing_state;
  
  GTK::Compat::Signal.connect(
    $a, 'transition-stopped::rotation-angle-y', 
    -> *@a { 
      CATCH { default { .message.say } }
      on_transition_stopped( $a, |@a[1, 2]) 
    } 
  );
}

sub MAIN {
  exit(1) unless Clutter::Main.init;
  
  my $stage = Clutter::Stage.new;
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.title = 'Three Flowers in a Vase';
  $stage.user_resizable = True;
  
  my $vase = Clutter::Actor.new;
  $vase.name = 'vase';
  $vase.layout_manager = Clutter::BoxLayout.new;
  $vase.background_color = CLUTTER_COLOR_LightSkyBlue;
  $vase.add_constraint(
    Clutter::AlignConstraint.new($stage, CLUTTER_ALIGN_BOTH, 0.5) 
  );
  $stage.add_child($vase);
  
  my @flowers;
  @flowers.push: Clutter::Actor.new;
  @flowers[0].set_name('flower.1');
  @flowers[0].set_size(SIZE, SIZE);
  @flowers[0].margin-left = 12;
  @flowers[0].background_color = CLUTTER_COLOR_Red;
  @flowers[0].reactive = True;
  @flowers[0].button-press-event.tap(-> *@a { 
    CATCH { default { .message.say } }
    @a[* - 1].r = animate_color(@flowers[0], @a[1]);
  });
  $vase.add-child(@flowers[0]);
  
  @flowers.push: Clutter::Actor.new;
  @flowers[1].name = 'flower.2';
  @flowers[1].set_size(SIZE, SIZE);
  (@flowers[1].margin-top,  @flowers[1].margin-bottom) = 12 xx 2;
  (@flowers[1].margin-left, @flowers[1].margin-right) = 6 xx 2;
  @flowers[1].background_color = CLUTTER_COLOR_Yellow;
  @flowers[1].reactive = True;
  @flowers[1].enter-event.tap(-> *@a { 
    CATCH { default { .message.say } }
    say 'enter-event';
    @a[* - 1].r = on_crossing(@flowers[1], @a[1]); 
    say "exit-event { @a[* - 1].r }";
  });
  @flowers[1].leave-event.tap(-> *@a {
    CATCH { default { .message.say } } 
    say 'leave-event';
    @a[* - 1].r = on_crossing(@flowers[1], @a[1]); 
  });
  $vase.add-child(@flowers[1]);  
  
  @flowers.push: Clutter::Actor.new;
  @flowers[2].name = 'flower.3';
  @flowers[2].set_size(SIZE, SIZE);
  @flowers[2].margin-right = 12;
  @flowers[2].background_color = CLUTTER_COLOR_Green;
  @flowers[2].set_pivot_point(0.5, 0);
  @flowers[2].reactive = True;
  @flowers[2].button-press-event.tap(-> *@a { 
    CATCH { default { .message.say } }
    @a[* - 1].r = animation_rotation(@flowers[2], @a[1]) 
  });
  $vase.add-child(@flowers[2]);
  
  $stage.show-actor;
  
  Clutter::Main.run;
}
  
  
  
