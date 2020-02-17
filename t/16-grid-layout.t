use v6.c;

use Pango::Raw::Types;

use Clutter::Raw::Types;
use Clutter::Raw::Keysyms;

use GLib::Signal;

use Clutter::Actor;
use Clutter::BinLayout;
use Clutter::BoxLayout;
use Clutter::Color;
use Clutter::Event;
use Clutter::GridLayout;
use Clutter::LayoutMeta;
use Clutter::Stage;
use Clutter::Text;

use Clutter::Main;

my %globals;

use NativeCall;

constant INSTRUCTIONS = qq:to/INSTRUCT/.chomp;
Press r\t→\tSwitch row homogeneous
Press c\t→\tSwitch column homogeneous
Press s\t→\tIncrement spacing (up to 12px)
Press q\t→\tQuit

Left/right click\t\t→\tChange actor align
Shift left/right click\t→\tChange actor expand
INSTRUCT

sub on-button-release($a, $e, $d, $r) {
  CATCH { default { .message.say } }

  $r.r = 1;
  my ($xa, $ya, $xe, $ye) = ($a.x-align, $a.y-align, $a.x-expand, $a.y-expand);

  given Clutter::Event.new($e) {
    when .button == CLUTTER_BUTTON_PRIMARY {
      if  .has-shift-modifier { $xe .= not            }
      else                    { $xa = 0 if ++$xa >= 4 }
    }
    when .button == CLUTTER_BUTTON_SECONDARY {
      if .has-shift-modifier  { $ye .= not  }
      else                    { $ya = 0 if ++$ya >= 4 }
    }
    default { $r.r = 0 }
  }
  ($a.x-align, $a.y-align, $a.x-expand, $a.y-expand) = ($xa, $ya, $xe, $ye);
}

sub get-align-name ($a) {
  $a.Str.split('_')[* - 1].lc;
}

sub on-changed ($a, $p, $label) {
  CATCH { default { .message.say } }

  my $box = $a.parent;
  my ($xa, $ya, $xe, $ye) = ($a.x-align, $a.y-align, $a.x-expand, $a.y-expand);
  my $m = %globals<grid-layout>.get-child-meta($box, $a);

  my ($l, $t, $w, $h) = ($m.left, $m.top, $m.width, $m.height);
  $label.text = qq:to/TEXT/.chomp;
    attach: { $l }, { $t }
    span:   { $w }, { $h }
    expand: { $xe.Int }, { $ye.Int }
    align:  { get-align-name($xa) },{ get-align-name($ya) }
    TEXT
}

sub add-actor ($box, $l, $t, $w, $h) {
  CATCH { default { .message.say } }

  my $color = Clutter::Color.new-from-hls(360 * rand, 0.5, 0.5);
  $color.alpha = 255;

  my $layout = Clutter::BinLayout.new(
    CLUTTER_BIN_ALIGNMENT_CENTER, CLUTTER_BIN_ALIGNMENT_CENTER
  );
  my $a = %globals<expand> ??
    CLUTTER_ACTOR_ALIGN_FILL !! CLUTTER_ACTOR_ALIGN_CENTER;
  my $rect = Clutter::Actor.new.setup(
    layout-manager   => $layout,
    background-color => $color,
    reactive         => True,
    size             => %globals<random-size>  ?? (40...80).pick xx 2
                                               !! (60, 60),
    expand           => %globals<expand>,
    x-align          => %globals<random-align> ?? ClutterActorAlignEnum.pick
                                               !! $a,
    y-align          => %globals<random-align> ?? ClutterActorAlignEnum.pick
                                               !! $a,
  );
  my $text = Clutter::Text.new-with-text("Sans 8px", Str).setup(
    color => $CLUTTER_COLOR_Black
  );
  $text.line-alignment = PANGO_ALIGN_CENTER;
  $rect.add-child($text);

  $rect.button-release-event.tap(-> *@a { on-button-release(|@a) });

  # This is through GTK!! -- The first parameter is a pointer, not an object!
  GLib::Signal.connect($rect, "notify::$_", -> *@a {
    CATCH { default { .message.say } }

    my @b = ($rect, @a[1], $text);
    on-changed(|@b)
  }) for <x-expand y-expand x-align y-align>;
  #
  # Reusing $layout.
  %globals<box-layout> ?? $box.add-child($rect) !!
                          %globals<grid-layout>.attach($rect, $l, $t, $w, $h);
  on-changed($rect, Nil, $text);
}

sub on-key-release ($s, $e, $b, $r) {
  CATCH { default { .message.say } }

  my $l = Clutter::GridLayout.new($b.get-layout-manager);

  $r.r = 1;
  given Clutter::Event.new($e).key-symbol {
    when CLUTTER_KEY_c { $l.column-homogeneous = $l.column-homogeneous.not }
    when CLUTTER_KEY_r { $l.row-homogeneous    = $l.row-homogeneous.not    }

    when CLUTTER_KEY_s { (my $s = $l.column-spacing + 1)++;
                         $l.column-spacing =
                         $l.row-spacing    = $s <= 12 ?? $s !! 0           }

    when CLUTTER_KEY_q { Clutter::Main.quit }

    default            { $r.r == 0 }
  }
}

sub MAIN (
  :$random-size  is copy = False,   #= Randomly size the rectangles
  :$random-align is copy = False,   #= Randomly set the align values
  :$expand       is copy = True,    #= Determins whether the actors are expanded by default
  :$box-layout   is copy = False,   #= Use the layout in a ClutterBoxLayout style
  :$vertical     is copy = False,   #= Use a vertical orientation when used with --box
) {
  exit(1) unless Clutter::Main.init == CLUTTER_INIT_SUCCESS;

  %globals{ .VAR.name.substr(1) } = $_
    for $random-size, $random-align, $expand, $box-layout, $vertical;

  my $stage = Clutter::Stage.new.setup(
    user-resizable => True,
    layout-manager => (
      my $stage-layout = Clutter::BoxLayout.new.setup(
        orientation  => CLUTTER_ORIENTATION_VERTICAL,
      )
    ),
  );

  %globals<grid-layout> = Clutter::GridLayout.new.setup(
    orientation   => $vertical ??
                     CLUTTER_ORIENTATION_VERTICAL   !!
                     CLUTTER_ORIENTATION_HORIZONTAL
  );

  my $box = Clutter::Actor.new.setup(
    background-color => $CLUTTER_COLOR_LightGray,
    expand           => True,
    layout-manager   => %globals<grid-layout>,
  );
  $stage-layout.pack(
    $box,
    True, True, True,
    CLUTTER_BOX_ALIGNMENT_CENTER,
    CLUTTER_BOX_ALIGNMENT_CENTER
  );

  add-actor($box, 0, 0, 1, 1);
  add-actor($box, 1, 0, 1, 1);
  add-actor($box, 2, 0, 1, 1);
  add-actor($box, 0, 1, 1, 1);
  add-actor($box, 1, 1, 2, 1);
  add-actor($box, 0, 2, 3, 1);
  add-actor($box, 0, 3, 2, 2);
  add-actor($box, 2, 3, 1, 1);
  add-actor($box, 2, 4, 1, 1);

  my $instructions = Clutter::Text.new-with-text('Sans 12px', INSTRUCTIONS);
  $instructions.margin-top  = $instructions.margin-left =
                              $instructions.margin-bottom = 4;

  $stage-layout.pack(
    $instructions, False, True, False,
    CLUTTER_BOX_ALIGNMENT_START,
    CLUTTER_BOX_ALIGNMENT_CENTER
  );

  $stage.destroy.tap({ Clutter::Main.quit });
  $stage.key-release-event.tap(-> *@a {
    CATCH { default { .message.say } }

    my @b = (@a[0], @a[1], $box, @a[3]);
    on-key-release(|@b)
  });
  $stage.show-actor;

  Clutter::Main.run;
}
