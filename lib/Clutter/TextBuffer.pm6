use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::TextBuffer;

use GLib::Roles::Object;

class Clutter::TextBuffer {
  also does GLib::Roles::Object;
  
  has ClutterTextBuffer $!ctb;
  
  submethod BUILD (:$textbuffer) {
    self!setObject( cast(ClutterTextBuffer, $!ctb = $textbuffer) );
  }
  
  method Clutter::Raw::Definitions::ClutterTextBuffer
    is also<ClutterTextBuffer>
  { $!ctb }
  
  method new {
    self.bless( textbuffer => clutter_text_buffer_new() );
  }

  method new_with_text (Str() $text, Int() $text_len) 
    is also<new-with-text> 
  {
    my gssize $t = resolve-long($text_len);
    clutter_text_buffer_new_with_text($text, $t);
  }
  
  method max_length is rw is also<max-length> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_buffer_get_max_length($!ctb);
      },
      STORE => sub ($, Int() $max_length is copy) {
        my gint $ml = resolve-int($max_length);
        clutter_text_buffer_set_max_length($!ctb, $ml);
      }
    );
  }
  
  method delete_text (Int() $position, Int() $n_chars) is also<delete-text> {
    my guint $p = resolve-uint($position);
    my gint $n = resolve-int($n_chars);
    clutter_text_buffer_delete_text($!ctb, $p, $n);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars) 
    is also<emit-deleted-text> 
  {
    my guint $p = resolve-uint($position);
    my gint $n = resolve-int($n_chars);
    clutter_text_buffer_emit_deleted_text($!ctb, $p, $n);
  }

  method emit_inserted_text (Int() $position, Str() $chars, Int() $n_chars) 
    is also<emit-inserted-text> 
  {
    my guint $p = resolve-uint($position);
    my gint $n = resolve-int($n_chars);
    clutter_text_buffer_emit_inserted_text($!ctb, $p, $chars, $n);
  }

  method get_bytes 
    is also<
      get-bytes
      bytes
    > 
  {
    clutter_text_buffer_get_bytes($!ctb);
  }

  method get_length 
    is also<
      get-length
      length
    > 
  {
    clutter_text_buffer_get_length($!ctb);
  }

  method get_text 
    is also<
      get-text
      text
    > 
  {
    clutter_text_buffer_get_text($!ctb);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_text_buffer_get_type, $n, $t );
  }

  method insert_text (Int() $position, Str() $chars, Int() $n_chars) 
    is also<insert-text> 
  {
    my guint $p = resolve-uint($position);
    my gint $n = resolve-int($n_chars);
    clutter_text_buffer_insert_text($!ctb, $p, $chars, $n);
  }

  method set_text (Str() $chars, Int() $n_chars) is also<set-text> {
    my gint $n = resolve-int($n_chars);
    clutter_text_buffer_set_text($!ctb, $chars, $n);
  }
  
}
