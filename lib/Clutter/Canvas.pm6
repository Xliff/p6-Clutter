use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use GLib::Value;

use GLib::Roles::Object;
use Clutter::Roles::Signals::Canvas;
use Clutter::Roles::Content;

our subset ClutterCanvasAncestry is export of Mu
  where ClutterContent | ClutterCanvas | GObject;

my @set-methods = 'size'.Array;

my @attributes = <
  scale-factor      scale_factor
  height
  scale-factor-set  scale_factor_set
  width
>;

class Clutter::Canvas {
  also does GLib::Roles::Object;
  also does Clutter::Roles::Content;
  also does Clutter::Roles::Signals::Canvas;

  has ClutterCanvas $!cc is implementor;

  submethod BUILD (:$canvas) {
    self.setClutterCanvas($canvas) if $canvas;
  }

  method setClutterCanvas (ClutterCanvasAncestry $_) {
    my $to-parent;

    $!cc = do {
      when ClutterCanvas {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when ClutterContent {
        $!c-con = $_;
        $to-parent = cast(GObject, $_);
        cast(ClutterCanvas, $_);
      }

      default {
        $to-parent = $_;
        cast(ClutterCanvas, $_);
      }
    }

    # Clutter::Roles::Content
    self!setObject($to-parent);
    self.roleInit-ClutterContent;
  }

  multi method new (ClutterCanvasAncestry $canvas, :$ref = True) {
    return Nil unless $canvas;

    my $o = self.bless( :$canvas );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $canvas = clutter_canvas_new();

    $canvas ?? self.bless(:$canvas) !! Nil;
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "CCA: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      when @set-methods.any {
        my $proper-name = S:g /'-'/_/;
        say "CCSM: {$_}" if $DEBUG;
        self."set_{ $proper-name }"( |%data{$_} )
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    # Role attribute and set methods should be respected, somehow. Think
    # about a proper mechanism to do that. Bonus points for maintaining
    # abstraction!

    self;
  }

  # Is originally:
  # ClutterCanvas, CairoContext, gint, gint, gpointer --> gboolean
  method draw {
    self.connect-draw($!cc);
  }

  method scale_factor is rw is also<scale-factor> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_canvas_get_scale_factor($!cc);
      },
      STORE => sub ($, Int() $scale is copy) {
        my gint $s = $scale;

        clutter_canvas_set_scale_factor($!cc, $s);
      }
    );
  }

  # Type: gint
  method height is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('height', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: gboolean
  method scale-factor-set is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('scale-factor-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scale-factor-set does not allow writing'
      }
    );
  }

  # Type: gint
  method width is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('width', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_canvas_get_type, $n, $t);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my gint ($w, $h) = ($width, $height);

    so clutter_canvas_set_size($!cc, $w, $h);
  }

}

sub clutter_canvas_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_canvas_new ()
  returns ClutterCanvas
  is native(clutter)
  is export
{ * }

sub clutter_canvas_set_size (ClutterCanvas $canvas, gint $width, gint $height)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_canvas_get_scale_factor (ClutterCanvas $canvas)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_canvas_set_scale_factor (ClutterCanvas $canvas, gint $scale)
  is native(clutter)
  is export
{ * }
