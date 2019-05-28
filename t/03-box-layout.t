use v6.c;

use GTK::Compat::Types;
use Pango::Raw::Types;
use Clutter::Raw::Types;
use Clutter::Raw::Keysyms;

use GTK::Compat::Signal;

use Clutter::Actor;
use Clutter::ActorIter;
use Clutter::BinLayout;
use Clutter::BoxLayout;
use Clutter::Event;
use Clutter::Text;

use Clutter::Main;

constant INSTRUCTIONS = qq:to/INSTRUCT/.chomp;
  Press v\t\→\tSwitch horizontal/vertical
  Press h\t\→\tToggle homogeneous
  Press p\t\→\tToggle pack start/end
  Press s\t\→\tIncrement spacing (up to 12px)
  Press +\t\→\tAdd a new actor      
  Press a\t\→\tToggle animations
  Press q\t\→\tQuit
  INSTRUCT

my %align-name{Any} = (
  (CLUTTER_ACTOR_ALIGN_FILL)   => 'fill',
  (CLUTTER_ACTOR_ALIGN_START)  => 'start',
  (CLUTTER_ACTOR_ALIGN_CENTER) => 'center',
  (CLUTTER_ACTOR_ALIGN_END)    => 'end';
);

sub button_release_cb ($r, $e, $d, $ret) {
  CATCH { default { .message.say } }
  
  my  ($x-align,   $y-align,   $x-expand,   $y-expand) = 
    ($r.x-align, $r.y-align, $r.x-expand, $r.y-expand);
  
  my $event = Clutter::Event.new($e);
  given ClutterButtonPress( $event.button ) {
    when CLUTTER_BUTTON_PRIMARY {
      my $var := $event.has-shift-modifier ?? $y-align !! $x-align;
      $var = $var < 3 ?? $var + 1 !! 0;  
    }
    
    when CLUTTER_BUTTON_SECONDARY {
      my $var := $event.has-shift-modifier ?? $y-expand !! $x-expand;
      $var .= not;
    }
  }
  ($r.x-align, $r.y-align, $r.x-expand, $r.y-expand) = 
    ($x-align,   $y-align,   $x-expand,   $y-expand);
  $ret.r = 1;
}

sub changed_cb ($act, $ps, $t) {
  CATCH { default { .message.say } }
  
  my $a = $act ~~ Clutter::Actor ?? 
    $act !! Clutter::Actor.new( cast(ClutterActor, $act) );
  my  ($x-align,   $y-align,   $x-expand,   $y-expand) = 
    ($a.x-align, $a.y-align, $a.x-expand, $a.y-expand);
  
  $t.text = qq:to/TEXT/.chomp;
{ $x-expand.Int },{ $y-expand.Int }\n{ %align-name{$x-align} }\n{ %align-name{$y-align} }
TEXT

}

sub add_actor($b, $p) {
  my $c = Clutter::Color.new_from_hls(360 * rand, 0.5, 0.5);
  $c.alpha = 255;
  
  my $layout = Clutter::BinLayout.new(
    CLUTTER_BIN_ALIGNMENT_CENTER, CLUTTER_BIN_ALIGNMENT_CENTER
  );
  my $rect = Clutter::Actor.new;
  $rect.layout_manager = $layout;
  $rect.background_color = $c;
  ($rect.reactive, $rect.x-expand, $rect.y-expand) = True xx 3;
  ($rect.x-align, $rect.y-align) = CLUTTER_ACTOR_ALIGN_CENTER xx 2;
  $rect.set_size(32, 64);
  
  my $text = Clutter::Text.new_with_text('Sans 8px', Str);
  $text.line-alignment = PANGO_ALIGN_CENTER;
  $rect.add_child($text);
  
  $rect.button-release-event.tap(-> *@a { button_release_cb(|@a) });
  GTK::Compat::Signal.connect($rect, "notify::$_", -> *@a { 
    &changed_cb(|@a[0,1], $text) 
  }) for <x-expand y-expand x-align y-align>;
  
  $b.insert_child_at_index($rect, $p);
  changed_cb($rect, Nil, $text);
}

sub key_release_cb ($stage, $e, $b) {
  CATCH { default { .message.say } }
  
  my $layout = Clutter::BoxLayout.new(
    $b.layout_manager.ClutterLayoutManager
  );
  
  my $r = 1;
  given Clutter::Event.new($e).key_symbol {
    when CLUTTER_KEY_a {
      my $i = Clutter::ActorIter.new($b);
      while (my $c = $i.next) {
        my $d = $c.easing-duration;
        $c.easing-duration = $d ?? 0 !! 250;
      }
    }
    
    when CLUTTER_KEY_v {
      my $o = $layout.orientation;
      $layout.orientation = $o == CLUTTER_ORIENTATION_VERTICAL ??
        CLUTTER_ORIENTATION_HORIZONTAL !! CLUTTER_ORIENTATION_VERTICAL;
    }
    
    when CLUTTER_KEY_h { $layout.homogeneous .= not }
    when CLUTTER_KEY_p { $layout.pack_start  .= not }
    
    when CLUTTER_KEY_s { 
      my $s = $layout.spacing;
      $layout.spacing = $s > 12 ?? 0 !! ++$s;
    }
    
    when CLUTTER_KEY_plus { add_actor($b, $b.n-children.rand.floor) }
    when CLUTTER_KEY_q    { Clutter::Main.quit }
    default               { $r = 0 }
  }
  $r;
}

sub MAIN {
  Clutter::Main.init;
  
  my $stage = Clutter::Stage.new;
  ($stage.title, $stage.user-resizable) = ('Box Layout', True);
  
  my $layout = Clutter::BoxLayout.new;
  $layout.orientation = CLUTTER_ORIENTATION_VERTICAL;
  $stage.layout-manager = $layout;
  
  my $box = Clutter::Actor.new;
  $box.background-color = CLUTTER_COLOR_LightGray;
  ($box.x-expand, $box.y-expand) = True xx 2;
  $box.layout-manager = Clutter::BoxLayout.new;
  $stage.add-child($box);
  
  my $instructions = Clutter::Text.new_with_text('Sans 12px', INSTRUCTIONS);
  ($instructions.x-expand, $instructions.y-expand) = (True, False);
  $instructions.x-align = CLUTTER_ACTOR_ALIGN_START;
  $instructions."margin-$_"() = 4 for <top left bottom>;
  $stage.add-child($instructions);
  
  add_actor($box, $_) for ^5;
  
  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.key-release-event.tap(-> *@a { 
    @a[* - 1].r = key_release_cb(|@a[0,1], $box) 
  });
  $stage.show-actor;
  
  Clutter::Main.run;
}
  
