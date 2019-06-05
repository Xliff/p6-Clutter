use v6.c;

use Method::Also;

use Cairo;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Path;

use GTK::Raw::Utils;

use GTK::Compat::GSList;
use GTK::Compat::Value;

use GTK::Compat::Roles::ListData;
use GTK::Compat::Roles::Object;

class Clutter::Path {
  also does GTK::Compat::Roles::Object;

  has ClutterPath $!cp;

  submethod BUILD (:$path) {
    self!setObject( cast(GObject, $!cp = $path) ):
  }

  method Clutter::Raw::Types::ClutterPath
    is also<ClutterPath>
  { $!cp }

  method new {
    self.bless( path => clutter_path_new() );
  }

  method new_with_description (Str() $desc) is also<new-with-description> {
    self.bless( path => clutter_path_new_with_description($desc) );
  }

  method description is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_path_get_description($!cp);
      },
      STORE => sub ($, $str is copy) {
        clutter_path_set_description($!cp, $str);
      }
    );
  }

  method add_cairo_path (cairo_path_t $cpath) is also<add-cairo-path> {
    clutter_path_add_cairo_path($!cp, $cpath);
  }

  method add_close is also<add-close> {
    clutter_path_add_close($!cp);
  }

  method add_curve_to (
    Int() $x_1,
    Int() $y_1,
    Int() $x_2,
    Int() $y_2,
    Int() $x_3,
    Int() $y_3
  )
    is also<add-curve-to>
  {
    my gint @a = resolve-int($x_1, $y_1. $x_2, $y_2, $x_3, $y_3);
    clutter_path_add_curve_to($!cp, |@a);
  }

  method add_line_to (Num() $x, Num() $y) is also<add-line-to> {
    my gint ($xx, $yy) = ($x, $y);
    clutter_path_add_line_to($!cp, $x, $y);
  }

  method add_move_to (Num() $x, Num() $y) is also<add-move-to> {
    my gint ($xx, $yy) = ($x, $y);
    clutter_path_add_move_to($!cp, $x, $y);
  }

  method add_node (ClutterPathNode $node) is also<add-node> {
    clutter_path_add_node($!cp, $node);
  }

  method add_rel_curve_to (
    Int() $x_1,
    Int() $y_1,
    Int() $x_2,
    Int() $y_2,
    Int() $x_3,
    Int() $y_3
  )
    is also<add-rel-curve-to>
  {
    my gint @a = resolve-int($x_1, $y_1. $x_2, $y_2, $x_3, $y_3);
    clutter_path_add_rel_curve_to($!cp, |@a);
  }

  method add_rel_line_to (Num() $x, Num() $y) is also<add-rel-line-to> {
    my gint ($xx, $yy) = ($x, $y);
    clutter_path_add_rel_line_to($!cp, $xx, $yy);
  }

  method add_rel_move_to (Num() $x, Num() $y) is also<add-rel-move-to> {
    my gint ($xx, $yy) = ($x, $y);
    clutter_path_add_rel_move_to($!cp, $x, $yy);
  }

  method add_string (Str() $str) is also<add-string> {
    clutter_path_add_string($!cp, $str);
  }

  method clear {
    clutter_path_clear($!cp);
  }

  method foreach (
    &callback,
    gpointer $user_data = gpointer
  ) {
    clutter_path_foreach($!cp, &callback, $user_data);
  }

  method get_length is also<get-length> {
    clutter_path_get_length($!cp);
  }

  method get_n_nodes is also<get-n-nodes> {
    clutter_path_get_n_nodes($!cp);
  }

  method get_node (Int() $index, ClutterPathNode $node) is also<get-node> {
    my guint $i = resolve-guint($index);
    clutter_path_get_node($!cp, $index, $node);
  }

  method get_nodes is also<get-nodes> {
    my $n = clutter_path_get_nodes($!cp);
    return Nil unless $n.defined;
    my $l = GTK::Compat::Types::GSList.new($n)
      but GTK::Compat::Roles::ListData[ClutterPathNode];
    $l.Array;
  }

  method get_position (Num() $progress, ClutterKnot $position)
    is also<get-position>
  {
    my gdouble $p = $progress;
    clutter_path_get_position($!cp, $p, $position);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_path_get_type, $n, $t );
  }

  # $index can be negative, so it is signed!
  method insert_node (Int() $index, ClutterPathNode $node)
    is also<insert-node>
  {
    my gint $i = resove-int($index);
    clutter_path_insert_node($!cp, $i, $node);
  }

  method remove_node (Int() $index) is also<remove-node> {
    my guint $i = resolve-guint($index);
    clutter_path_remove_node($!cp, $i);
  }

  method replace_node (Int() $index, ClutterPathNode $node)
    is also<replace-node>
  {
    my guint $i = resolve-guint($index);
    clutter_path_replace_node($!cp, $index, $node);
  }

  method to_cairo_path (cairo_t $cr) is also<to-cairo-path> {
    clutter_path_to_cairo_path($!cp, $cr);
  }

}
