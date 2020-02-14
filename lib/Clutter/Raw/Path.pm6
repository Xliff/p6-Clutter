use v6.c;

use NativeCall;

use Cairo;


use Clutter::Raw::Types;

unit package Clutter::Raw::Path;

sub clutter_path_add_close (ClutterPath $path)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_curve_to (
  ClutterPath $path,
  gint $x_1,
  gint $y_1,
  gint $x_2,
  gint $y_2,
  gint $x_3,
  gint $y_3
)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_line_to (ClutterPath $path, gint $x, gint $y)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_move_to (ClutterPath $path, gint $x, gint $y)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_node (ClutterPath $path, ClutterPathNode $node)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_rel_curve_to (
  ClutterPath $path,
  gint $x_1,
  gint $y_1,
  gint $x_2,
  gint $y_2,
  gint $x_3,
  gint $y_3
)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_rel_line_to (ClutterPath $path, gint $x, gint $y)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_rel_move_to (ClutterPath $path, gint $x, gint $y)
  is native(clutter)
  is export
{ * }

sub clutter_path_add_string (ClutterPath $path, Str $str)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_path_clear (ClutterPath $path)
  is native(clutter)
  is export
{ * }

sub clutter_path_foreach (
  ClutterPath $path,
  &callback (ClutterPathNode, Pointer),
  gpointer $user_data
)
  is native(clutter)
  is export
{ * }

sub clutter_path_get_length (ClutterPath $path)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_path_get_n_nodes (ClutterPath $path)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_path_get_node (
  ClutterPath $path,
  guint $index,
  ClutterPathNode $node
)
  is native(clutter)
  is export
{ * }

sub clutter_path_get_nodes (ClutterPath $path)
  returns GSList
  is native(clutter)
  is export
{ * }

sub clutter_path_get_position (
  ClutterPath $path,
  gdouble $progress,
  ClutterKnot $position
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_path_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_path_insert_node (
  ClutterPath $path,
  gint $index,
  ClutterPathNode $node
)
  is native(clutter)
  is export
{ * }

sub clutter_path_new ()
  returns ClutterPath
  is native(clutter)
  is export
{ * }

sub clutter_path_new_with_description (Str $desc)
  returns ClutterPath
  is native(clutter)
  is export
{ * }

sub clutter_path_remove_node (ClutterPath $path, guint $index)
  is native(clutter)
  is export
{ * }

sub clutter_path_replace_node (
  ClutterPath $path,
  guint $index,
  ClutterPathNode $node
)
  is native(clutter)
  is export
{ * }

sub clutter_path_to_cairo_path (ClutterPath $path, cairo_t $cr)
  is native(clutter)
  is export
{ * }

sub clutter_path_get_description (ClutterPath $path)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_path_set_description (ClutterPath $path, Str $str)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_path_add_cairo_path (ClutterPath $path, cairo_path_t $cpath) 
  is native(clutter)
  is export
{ * }
