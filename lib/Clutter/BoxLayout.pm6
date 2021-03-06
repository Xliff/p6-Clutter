use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::BoxLayout;

use Clutter::LayoutManager;

our subset ClutterBoxLayoutAncestry is export of Mu
  where ClutterBoxLayout | ClutterLayoutManager;

my @attributes = <
  easing_duration  easing-duration
  easing_mode      easing-modfe
  homogeneous
  orientation
  pack_start       pack-start
  spacing
  use_animation    use-animation
>;

my @set-methods = <expand alignment>;

class Clutter::BoxLayout is Clutter::LayoutManager {
  has ClutterBoxLayout $!cb;

  submethod BUILD (:$boxlayout) {
    given $boxlayout {
      when ClutterBoxLayoutAncestry {
        my $to-parent;
        $!cb = do {
          when ClutterBoxLayout {
            $to-parent = cast(ClutterLayoutManager, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterBoxLayout, $_);
          }
        }
        self.setLayoutManager($to-parent)
      }
      when Clutter::BoxLayout {
      }
      default {
      }
    }
  }

  method Clutter::Raw::Definitions::ClutterBoxLayout
    is also<ClutterBoxLayout>
  { $!cb }

  multi method new (ClutterBoxLayoutAncestry $boxlayout) {
    $boxlayout ?? self.bless(:$boxlayout) !! Nil
  }
  multi method new {
    my $boxlayout = clutter_box_layout_new();

    $boxlayout ?? self.bless(:$boxlayout) !! Nil
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "BA: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "BSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} )
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    self;
  }

  method easing_duration is rw is DEPRECATED is also<easing-duration> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_easing_duration($!cb);
      },
      STORE => sub ($, Int() $msecs is copy) {
        my guint $ms = $msecs;

        clutter_box_layout_set_easing_duration($!cb, $ms);
      }
    );
  }

  # XXX - ULONG, not UINT! -- Check other objects
  method easing_mode is rw is DEPRECATED is also<easing-mode> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_easing_mode($!cb);
      },
      STORE => sub ($, Int() $mode is copy) {
        my gulong $m = $mode;

        clutter_box_layout_set_easing_mode($!cb, $m);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_box_layout_get_homogeneous($!cb);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = $homogeneous.so.Int;

        clutter_box_layout_set_homogeneous($!cb, $h);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_orientation($!cb);
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

        clutter_box_layout_set_orientation($!cb, $o);
      }
    );
  }

  method pack_start is rw is also<pack-start> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_pack_start($!cb);
      },
      STORE => sub ($, Int() $pack_start is copy) {
        my gboolean $ps = $pack_start.so.Int;

        clutter_box_layout_set_pack_start($!cb, $ps);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_spacing($!cb);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my guint $s = $spacing;

        clutter_box_layout_set_spacing($!cb, $s);
      }
    );
  }

  method use_animations is rw is DEPRECATED is also<use-animations> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_use_animations($!cb);
      },
      STORE => sub ($, Int() $animate is copy) {
        my gboolean $a = $animate.so.Int;

        clutter_box_layout_set_use_animations($!cb, $a);
      }
    );
  }

  method get_alignment (
    ClutterActor $actor,
    Int() $x_align, # ClutterBoxAlignment $x_align,
    Int() $y_align  # ClutterBoxAlignment $y_align
  )
    is DEPRECATED
    is also<get-alignment>
  {
    my guint ($xa, $ya) = ($x_align, $y_align);

    clutter_box_layout_get_alignment($!cb, $actor, $xa, $ya);
  }

  method get_expand (ClutterActor() $actor)
    is DEPRECATED
    is also<get-expand>
  {
    so clutter_box_layout_get_expand($!cb, $actor);
  }

  # DEPRECATED
  # method get_fill (ClutterActor $actor, gboolean $x_fill, gboolean $y_fill) {
  #   clutter_box_layout_get_fill($!cb, $actor, $x_fill, $y_fill);
  # }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_box_layout_get_type, $n, $t );
  }

  method pack (
    ClutterActor() $actor,
    Int() $expand,
    Int() $x_fill,
    Int() $y_fill,
    Int() $x_align, # ClutterBoxAlignment $x_align,
    Int() $y_align  # ClutterBoxAlignment $y_align
  )
    is DEPRECATED
  {
    my gboolean ($e, $xf, $yf) = ($expand, $x_fill, $y_fill).map( *.so.Int );
    my guint ($xa, $ya) = ($x_align, $y_align);

    clutter_box_layout_pack($!cb, $actor, $e, $xf, $yf, $xa, $ya);
  }

  method set_alignment (
    ClutterActor() $actor,
    Int() $x_align, # ClutterBoxAlignment $x_align,
    Int() $y_align  # ClutterBoxAlignment $y_align
  )
    is DEPRECATED
    is also<set-alignment>
  {
    my guint ($xa, $ya) = ($x_align, $y_align);

    clutter_box_layout_set_alignment($!cb, $actor, $xa, $ya);
  }

  method set_expand (ClutterActor() $actor, Int() $expand)
    is DEPRECATED
    is also<set-expand>
  {
    my gboolean $e = $expand.so.Int;

    clutter_box_layout_set_expand($!cb, $actor, $e);
  }

  method set_fill (ClutterActor() $actor, Int() $x_fill, Int() $y_fill)
    is DEPRECATED
    is also<set-fill>
  {
    my gboolean ($xf, $yf) = ($x_fill, $y_fill).map( *.so.Int );
    
    clutter_box_layout_set_fill($!cb, $actor, $xf, $yf);
  }

}
