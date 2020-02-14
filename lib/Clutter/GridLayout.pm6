use v6.c;

use Method::Also;


use Clutter::Raw::Types;



use Clutter::Raw::GridLayout;

use Clutter::LayoutManager;

our subset GridLayoutAncestry is export
  where ClutterGridLayout | ClutterLayoutManager;

my @attributes = <
  column_homogeneous      column-homogeneous
  column_spacing          column-spacing
  orientation
  row_homogeneous         row-homogeneous
  row_spacing             row-spacing
>;

class Clutter::GridLayout is Clutter::LayoutManager {
  has ClutterGridLayout $!cgl;

  submethod BUILD (:$gridlayout) {
    given $gridlayout {
      when GridLayoutAncestry {
        my $to-parent;
        $!cgl = do {
          when ClutterGridLayout {
            $to-parent = cast(ClutterLayoutManager, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(ClutterGridLayout, $_);
          }
        };
        self.setLayoutManager($to-parent)
      }
      when Clutter::GridLayout {
      }
      default {
      }
    }
  }

  method Clutter::Raw::Definitions::ClutterGridLayout
    is also<ClutterGridLayout>
  { $!cgl }

  multi method new (GridLayoutAncestry $gridlayout) {
    self.bless(:$gridlayout);
  }
  multi method new {
    self.bless( gridlayout => clutter_grid_layout_new() );
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "GL-A: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    self;
  }

  method column_homogeneous is rw is also<column-homogeneous> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_grid_layout_get_column_homogeneous($!cgl);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = resolve-bool($homogeneous);
        clutter_grid_layout_set_column_homogeneous($!cgl, $h);
      }
    );
  }

  method column_spacing is rw is also<column-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_grid_layout_get_column_spacing($!cgl);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my guint $s = resolve-uint($spacing);
        clutter_grid_layout_set_column_spacing($!cgl, $s);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterOrientation( clutter_grid_layout_get_orientation($!cgl) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = resolve-uint($orientation);
        clutter_grid_layout_set_orientation($!cgl, $o);
      }
    );
  }

  method row_homogeneous is rw is also<row-homogeneous> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_grid_layout_get_row_homogeneous($!cgl);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = resolve-bool($homogeneous);
        clutter_grid_layout_set_row_homogeneous($!cgl, $h);
      }
    );
  }

  method row_spacing is rw is also<row-spacing> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_grid_layout_get_row_spacing($!cgl);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my guint $s = resolve-uint($spacing);
        clutter_grid_layout_set_row_spacing($!cgl, $s);
      }
    );
  }

  method attach (
    ClutterActor() $child,
    Int() $left,
    Int() $top,
    Int() $width  = 1,
    Int() $height = 1
  ) {
    my gint ($l, $t, $w, $h) = resolve-int($left, $top, $width, $height);
    clutter_grid_layout_attach($!cgl, $child, $l, $t, $w, $h);
  }

  method attach_next_to (
    ClutterActor() $child,
    ClutterActor() $sib,
    Int() $side,            # ClutterGridPosition $side,
    Int() $width  = 1,
    Int() $height = 1
  )
    is also<attach-next-to>
  {
    my guint $s = resolve-uint($side);
    my gint ($w, $h) = resolve-int($width, $height);
    clutter_grid_layout_attach_next_to($!cgl, $child, $sib, $s, $w, $h);
  }

  method get_child_meta (
    ClutterContainer() $container,
    ClutterActor()     $child,
    :$raw = False
  )
    is also<get-child-meta>
  {
    nextwith($container, $child, :grid, :$raw);
  }

  method get_child_at (Int() $left, Int() $top) is also<get-child-at> {
    my gint ($l, $t)= resolve-int($left, $top);
    clutter_grid_layout_get_child_at($!cgl, $l, $t);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_grid_layout_get_type, $n, $t );
  }

  method insert_column (Int() $position) is also<insert-column> {
    my gint $p = resolve-int($position);
    clutter_grid_layout_insert_column($!cgl, $position);
  }

  method insert_next_to (
    ClutterActor() $sibling,
    Int() $side # ClutterGridPosition $side
  )
    is also<insert-next-to>
  {
    my guint $s = resolve-uint($side);
    clutter_grid_layout_insert_next_to($!cgl, $sibling, $s);
  }

  method insert_row (Int() $position) is also<insert-row> {
    my gint $p = resolve-int($position);
    clutter_grid_layout_insert_row($!cgl, $p);
  }

}
