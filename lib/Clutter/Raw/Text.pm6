use v6.c;

use NativeCall;

use Pango::Raw::Types;

use Clutter::Raw::Types;

unit package Clutter::Raw::Text;

sub clutter_text_activate (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_coords_to_position (ClutterText $self, gfloat $x, gfloat $y)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_text_delete_chars (ClutterText $self, guint $n_chars)
  is native(clutter)
  is export
{ * }

sub clutter_text_delete_selection (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_delete_text (
  ClutterText $self,
  gssize $start_pos,
  gssize $end_pos
)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_chars (
  ClutterText $self,
  gssize $start_pos,
  gssize $end_pos
)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_get_color (ClutterText $self, ClutterColor $color)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_cursor_color (ClutterText $self, ClutterColor $color)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_cursor_rect (ClutterText $self, ClutterRect $rect)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_layout (ClutterText $self)
  returns PangoLayout
  is native(clutter)
  is export
{ * }

sub clutter_text_get_layout_offsets (ClutterText $self, gint $x, gint $y)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_selected_text_color (
  ClutterText $self,
  ClutterColor $color
)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_selection (ClutterText $self)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_get_selection_color (ClutterText $self, ClutterColor $color)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_text_insert_text (ClutterText $self, Str $text, gssize $position)
  is native(clutter)
  is export
{ * }

sub clutter_text_insert_unichar (ClutterText $self, Str $wc)
  is native(clutter)
  is export
{ * }

sub clutter_text_new ()
  returns ClutterText
  is native(clutter)
  is export
{ * }

sub clutter_text_new_full (Str $font_name, Str $text, ClutterColor $color)
  returns ClutterText
  is native(clutter)
  is export
{ * }

sub clutter_text_new_with_buffer (ClutterTextBuffer $buffer)
  returns ClutterText
  is native(clutter)
  is export
{ * }

sub clutter_text_new_with_text (Str $font_name, Str $text)
  returns ClutterText
  is native(clutter)
  is export
{ * }

sub clutter_text_position_to_coords (
  ClutterText $self,
  gint $position,
  gfloat $x,
  gfloat $y,
  gfloat $line_height
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_set_color (ClutterText $self, ClutterColor $color)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_cursor_color (ClutterText $self, ClutterColor $color)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_markup (ClutterText $self, Str $markup)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_preedit_string (
  ClutterText $self,
  Str $preedit_str,
  PangoAttrList $preedit_attrs,
  guint $cursor_pos
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_selected_text_color (
  ClutterText $self,
  ClutterColor $color
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_selection (
  ClutterText $self,
  gssize $start_pos,
  gssize $end_pos
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_selection_color (
  ClutterText $self,
  ClutterColor $color
)
  is native(clutter)
  is export
{ * }

sub clutter_text_get_activatable (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_attributes (ClutterText $self)
  returns PangoAttrList
  is native(clutter)
  is export
{ * }

sub clutter_text_get_buffer (ClutterText $self)
  returns ClutterTextBuffer
  is native(clutter)
  is export
{ * }

sub clutter_text_get_cursor_position (ClutterText $self)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_text_get_cursor_size (ClutterText $self)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_text_get_cursor_visible (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_editable (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_ellipsize (ClutterText $self)
  returns guint # PangoEllipsizeMode
  is native(clutter)
  is export
{ * }

sub clutter_text_get_font_description (ClutterText $self)
  returns PangoFontDescription
  is native(clutter)
  is export
{ * }

sub clutter_text_get_font_name (ClutterText $self)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_get_justify (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_line_alignment (ClutterText $self)
  returns guint # PangoAlignment
  is native(clutter)
  is export
{ * }

sub clutter_text_get_line_wrap (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_line_wrap_mode (ClutterText $self)
  returns guint # PangoWrapMode
  is native(clutter)
  is export
{ * }

sub clutter_text_get_max_length (ClutterText $self)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_text_get_password_char (ClutterText $self)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_get_selectable (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_selection_bound (ClutterText $self)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_text_get_single_line_mode (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_get_text (ClutterText $self)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_get_use_markup (ClutterText $self)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_text_set_activatable (ClutterText $self, gboolean $activatable)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_attributes (
  ClutterText $self,
  PangoAttrList $attrs
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_buffer (
  ClutterText $self,
  ClutterTextBuffer $buffer
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_cursor_position (ClutterText $self, gint $position)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_cursor_size (ClutterText $self, gint $size)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_cursor_visible (
  ClutterText $self,
  gboolean $cursor_visible
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_editable (ClutterText $self, gboolean $editable)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_ellipsize (
  ClutterText $self,
  guint $mode # PangoEllipsizeMode $mode
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_font_description (
  ClutterText $self,
  PangoFontDescription $font_desc
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_font_name (ClutterText $self, Str $font_name)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_justify (ClutterText $self, gboolean $justify)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_line_alignment (
  ClutterText $self,
  guint $alignment # PangoAlignment $alignment
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_line_wrap (ClutterText $self, gboolean $line_wrap)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_line_wrap_mode (
  ClutterText $self,
  guint $mode # PangoWrapMode $wrap_mode
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_max_length (ClutterText $self, gint $max)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_password_char (ClutterText $self, guint $wc)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_selectable (ClutterText $self, gboolean $selectable)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_selection_bound (
  ClutterText $self,
  gint $selection_bound
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_single_line_mode (
  ClutterText $self,
  gboolean $single_line
)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_text (ClutterText $self, Str $text)
  is native(clutter)
  is export
{ * }

sub clutter_text_set_use_markup (ClutterText $self, gboolean $setting)
  is native(clutter)
  is export
{ * }
