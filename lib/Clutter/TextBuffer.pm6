use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::TextBuffer;

use GLib::Roles::Object;

our subset ClutterTextBufferAncestry is export of Mu
  where ClutterTextBuffer | GObject;

class Clutter::TextBuffer {
  also does GLib::Roles::Object;

  has ClutterTextBuffer $!ctb;

  submethod BUILD (:$textbuffer) {
    given $textbuffer {
      when ClutterTextBufferAncestry  {
        my $to-parent;
        $!ctb = do {
          when ClutterTextBuffer {
            $to-parent = cast(GObject, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterTextBuffer, $_);
          }
        }
        self!setObject($to-parent);
      }
    }
  }

  method Clutter::Raw::Definitions::ClutterTextBuffer
    is also<ClutterTextBuffer>
  { $!ctb }

  multi method new (ClutterTextBufferAncestry $textbuffer) {
    $textbuffer ?? self.bless(:$textbuffer) !! Nil;
  }
  multi method new {
    my $textbuffer = clutter_text_buffer_new();

    $textbuffer ?? self.bless(:$textbuffer) !! Nil;
  }

  method new_with_text (Str() $text, Int() $text_len)
    is also<new-with-text>
  {
    my gssize $t = $text_len;
    my $textbuffer = clutter_text_buffer_new_with_text($text, $t);

    $textbuffer ?? self.bless(:$textbuffer) !! Nil;
  }

  method max_length is rw is also<max-length> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_buffer_get_max_length($!ctb);
      },
      STORE => sub ($, Int() $max_length is copy) {
        my gint $ml = $max_length;

        clutter_text_buffer_set_max_length($!ctb, $ml);
      }
    );
  }

  method delete_text (Int() $position, Int() $n_chars) is also<delete-text> {
    my guint $p = $position;
    my gint $n = $n_chars;

    clutter_text_buffer_delete_text($!ctb, $p, $n);
  }

  method emit_deleted_text (Int() $position, Int() $n_chars)
    is also<emit-deleted-text>
  {
    my guint $p = $position;
    my gint $n = $n_chars;

    clutter_text_buffer_emit_deleted_text($!ctb, $p, $n);
  }

  method emit_inserted_text (Int() $position, Str() $chars, Int() $n_chars)
    is also<emit-inserted-text>
  {
    my guint $p = $position;
    my gint $n = $n_chars;

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
    my guint $p = $position;
    my gint $n = $n_chars;

    clutter_text_buffer_insert_text($!ctb, $p, $chars, $n);
  }

  method set_text (Str() $chars, Int() $n_chars) is also<set-text> {
    my gint $n = $n_chars;

    clutter_text_buffer_set_text($!ctb, $chars, $n);
  }

}
