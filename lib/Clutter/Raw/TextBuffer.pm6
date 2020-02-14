use v6.c;

use NativeCall;


use Clutter::Raw::Types;

unit package Clutter::Raw::TextBuffer;

sub clutter_text_buffer_delete_text (
  ClutterTextBuffer $buffer, 
  guint $position, 
  gint $n_chars
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_emit_deleted_text (
  ClutterTextBuffer $buffer, 
  guint $position, 
  guint $n_chars
)
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_emit_inserted_text (
  ClutterTextBuffer $buffer, 
  guint $position, 
  Str $chars, 
  guint $n_chars
)
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_get_bytes (ClutterTextBuffer $buffer)
  returns gsize
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_get_length (ClutterTextBuffer $buffer)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_get_text (ClutterTextBuffer $buffer)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_insert_text (
  ClutterTextBuffer $buffer, 
  guint $position, 
  Str $chars, 
  gint $n_chars
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_new ()
  returns ClutterTextBuffer
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_new_with_text (Str $text, gssize $text_len)
  returns ClutterTextBuffer
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_set_text (
  ClutterTextBuffer $buffer, 
  Str $chars, 
  gint $n_chars
)
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_get_max_length (ClutterTextBuffer $buffer)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_text_buffer_set_max_length (
  ClutterTextBuffer $buffer, 
  gint $max_length
)
  is native(clutter)
  is export
{ * }
