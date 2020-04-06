use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::FlowLayout;

use GLib::Value;
use Clutter::LayoutManager;

my @attributes = <
  column_spacing      column-spacing
  homogeneous
  max-column-width    max_column_width
  max-row-height      max_row_height
  min-column-width    min_column_width
  min-row-height      min_row_height
  orientation
  row_spacing         row-spacing
  snap_to_grid        snap-to-grid
>;

my @set-methods = <
  column_width        column-width
  row_height          row-height
>;

our subset ClutterFlowLayoutAncestry is export of Mu
  where ClutterFlowLayout | ClutterLayoutManagerAncestry;

class Clutter::FlowLayout is Clutter::LayoutManager {
  has ClutterFlowLayout $!cfl;

  submethod BUILD (:$flowlayout) {
    my $to-parent;
    $!cfl = do given $flowlayout {
      when ClutterFlowLayout {
        $to-parent = cast(ClutterLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterFlowLayout, $_);
      }
    }
    self.setLayoutManager($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterFlowLayout
    is also<ClutterFlowLayout>
  { $!cfl }

  multi method new (ClutterFlowLayoutAncestry $flowlayout) {
    $flowlayout ?? self.bless(:$flowlayout) !! Nil;
  }
  multi method new (Int() $orientation) {
    my guint $o = $orientation;
    my $flowlayout = clutter_flow_layout_new($o);

    $flowlayout ?? self.bless(:$flowlayout) !! Nil;
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "FlA: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "FlSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} )
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    self;
  }

  method column_spacing is rw is also<column-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_flow_layout_get_column_spacing($!cfl);
      },
      STORE => sub ($, Num() $spacing is copy) {
        my gfloat $cs = $spacing;

        clutter_flow_layout_set_column_spacing($!cfl, $cs);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_flow_layout_get_homogeneous($!cfl);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = $homogeneous.so.Int;

        clutter_flow_layout_set_homogeneous($!cfl, $h);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterFlowOrientationEnum(
          clutter_flow_layout_get_orientation($!cfl)
        );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

        clutter_flow_layout_set_orientation($!cfl, $o);
      }
    );
  }

  method row_spacing is rw is also<row-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_flow_layout_get_row_spacing($!cfl);
      },
      STORE => sub ($, Num() $spacing is copy) {
        my gfloat $s = $spacing;

        clutter_flow_layout_set_row_spacing($!cfl, $s);
      }
    );
  }

  method snap_to_grid is rw is also<snap-to-grid> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_flow_layout_get_snap_to_grid($!cfl);
      },
      STORE => sub ($, Int() $snap_to_grid is copy) {
        my gboolean $s = $snap_to_grid.so.Int;

        clutter_flow_layout_set_snap_to_grid($!cfl, $s);
      }
    );
  }

  # Type: gfloat
  method max-column-width is rw  is also<max_column_width> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('max-column-width', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('max-column-width', $gv);
      }
    );
  }

  # Type: gfloat
  method max-row-height is rw  is also<max_row_height> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('max-row-height', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('max-row-height', $gv);
      }
    );
  }

  # Type: gfloat
  method min-column-width is rw  is also<min_column_width> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('min-column-width', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('min-column-width', $gv);
      }
    );
  }

  # Type: gfloat
  method min-row-height is rw  is also<min_row_height> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('min-row-height', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('min-row-height', $gv);
      }
    );
  }

  proto method get_column_width (|)
    is also<
      get-column-width
      column_width
      column-width
    >
  { * }

  multi method get_column_width {
    samewith($, $);
  }
  multi method get_column_width ($min_width is rw, $max_width is rw) {
    my gfloat ($mnw, $mxw) = 0e0 xx 2;

    clutter_flow_layout_get_column_width($!cfl, $mnw, $mxw);
    ($min_width, $max_width) = ($mnw, $mxw);
  }

  proto method get_row_height (|)
    is also<
      get-row-height
      row_height
      row-height
    >
  { * }

  multi method get_row_height {
    samewith($, $);
  }
  multi method get_row_height ($min_height is rw, $max_height is rw) {
    my gfloat ($mnh, $mxh) = 0e0 xx 2;

    clutter_flow_layout_get_row_height($!cfl, $mnh, $mxh);
    ($min_height, $max_height) = ($mnh, $mxh);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, clutter_flow_layout_get_type, $n, $t );
  }

  method set_column_width (Num() $min_width, Num() $max_width)
    is also<set-column-width>
  {
    my gfloat ($mnw, $mxw) = ($min_width, $max_width);

    clutter_flow_layout_set_column_width($!cfl, $mnw, $mxw);
  }

  method set_row_height (Num() $min_height, Num() $max_height)
    is also<set-row-height>
  {
    my gfloat ($mnh, $mxh) = ($min_height, $max_height);
    
    clutter_flow_layout_set_row_height($!cfl, $mnh, $mxh);
  }

}
