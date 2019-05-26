use v6.c;

use Method::Also;

use Cairo;

use GTK::Compat::Types;
use Pango::Raw::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Text;

use Pango::AttrList;
use Pango::FontDescription;
use Pango::Layout;

use Clutter::Actor;
use Clutter::TextBuffer;

use Clutter::Roles::Signals::Text;

# This should become resolve-unichar in GTK::Raw::Utils.
sub resolve-unichar($wc) {
  resolve-uint(do given $wc {
    when Str {
      die 'Cannot convert multi-char string to unichar' unless .chars == 1;
      $wc.ord;
    }
    default {
      die 'Invalud type passed to Clutter::Text.insert_unichar'
        unless .^can('Int').elems;
      .Int
    }
  });
}

class Clutter::Text is Clutter::Actor {
  also does Clutter::Roles::Signals::Text;

  has ClutterText $!ct;

  submethod BUILD (:$textactor) {
    self.setActor( $!ct = $textactor );
  }
  
  method Clutter::Raw::Types::ClutterText 
  { $!ct }
  
  method new {
    self.bless( textactor => clutter_text_new() );
  }

  method new_full (
    Str() $font_name, 
    Str() $text, 
    ClutterColor() $color
  ) 
    is also<new-full> 
  {
    self.bless( 
      textactor => clutter_text_new_full($font_name, $text, $color)
    );
  }

  method new_with_buffer (ClutterTextBuffer() $buffer) 
    is also<new-with-buffer> 
  {
    self.bless( textactor => clutter_text_new_with_buffer($buffer) );
  }

  method new_with_text (Str() $font, Str() $text) is also<new-with-text> {
    self.bless( textactor => clutter_text_new_with_text($font, $text) );
  }

  method activatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_activatable($!ct);
      },
      STORE => sub ($, Int() $activatable is copy) {
        my gboolean $a = resolve-bool($activatable);
        clutter_text_set_activatable($!ct, $a);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::AttrList.new( clutter_text_get_attributes($!ct) );
      },
      STORE => sub ($, PangoAttrList() $attrs is copy) {
        clutter_text_set_attributes($!ct, $attrs);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::TextBuffer.new( clutter_text_get_buffer($!ct) );
      },
      STORE => sub ($, ClutterTextBuffer() $buffer is copy) {
        clutter_text_set_buffer($!ct, $buffer);
      }
    );
  }

  method cursor_position is rw is also<cursor-position> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_position($!ct);
      },
      STORE => sub ($, $position is copy) {
        clutter_text_set_cursor_position($!ct, $position);
      }
    );
  }

  method cursor_size is rw is also<cursor-size> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_size($!ct);
      },
      STORE => sub ($, $size is copy) {
        clutter_text_set_cursor_size($!ct, $size);
      }
    );
  }

  method cursor_visible is rw is also<cursor-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_cursor_visible($!ct);
      },
      STORE => sub ($, Int() $cursor_visible is copy) {
        my gboolean $c = resolve-bool($cursor_visible);
        clutter_text_set_cursor_visible($!ct, $c);
      }
    );
  }

  method editable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_editable($!ct);
      },
      STORE => sub ($, Int() $editable is copy) {
        my gboolean $e = resolve-bool($editable);
        clutter_text_set_editable($!ct, $editable);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeMode( clutter_text_get_ellipsize($!ct) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = resolve-uint($mode);
        clutter_text_set_ellipsize($!ct, $m);
      }
    );
  }

  method font_description is rw is also<font-description> {
    Proxy.new(
      FETCH => sub ($) {
        Pango::FontDescription.new( clutter_text_get_font_description($!ct) );
      },
      STORE => sub ($, PangoFontDescription() $font_desc is copy) {
        clutter_text_set_font_description($!ct, $font_desc);
      }
    );
  }

  method font_name is rw is also<font-name> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_font_name($!ct);
      },
      STORE => sub ($, Str() $font_name is copy) {
        clutter_text_set_font_name($!ct, $font_name);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_justify($!ct);
      },
      STORE => sub ($, Int() $justify is copy) {
        my gboolean $j = resolve-bool($justify);
        clutter_text_set_justify($!ct, $j);
      }
    );
  }

  method line_alignment is rw is also<line-alignment> {
    Proxy.new(
      FETCH => sub ($) {
        PangoAlignment( clutter_text_get_line_alignment($!ct) );
      },
      STORE => sub ($, Int() $alignment is copy) {
        my guint $a = resolve-uint($alignment);
        clutter_text_set_line_alignment($!ct, $a);
      }
    );
  }

  method line_wrap is rw is also<line-wrap> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_line_wrap($!ct);
      },
      STORE => sub ($, Int() $line_wrap is copy) {
        my guint $l = resolve-int($line_wrap);
        clutter_text_set_line_wrap($!ct, $l);
      }
    );
  }

  method line_wrap_mode is rw is also<line-wrap-mode> {
    Proxy.new(
      FETCH => sub ($) {
        PangoWrapMode( clutter_text_get_line_wrap_mode($!ct) );
      },
      STORE => sub ($, Int() $wrap_mode is copy) {
        my guint $w = resolve-uint($wrap_mode);
        clutter_text_set_line_wrap_mode($!ct, $w);
      }
    );
  }

  method max_length is rw is also<max-length> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_max_length($!ct);
      },
      STORE => sub ($, Int() $max is copy) {
        my gint $m = resolve-int($max);
        clutter_text_set_max_length($!ct, $m);
      }
    );
  }

  method password_char is rw is also<password-char> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_password_char($!ct);
      },
      STORE => sub ($, $wc is copy) {
        my guint $w = resolve-unichar($wc);
        clutter_text_set_password_char($!ct, $w);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_selectable($!ct);
      },
      STORE => sub ($, Int() $selectable is copy) {
        my gboolean $s = resolve-bool($selectable);
        clutter_text_set_selectable($!ct, $s);
      }
    );
  }

  method selection_bound is rw is also<selection-bound> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_selection_bound($!ct);
      },
      STORE => sub ($, Int() $selection_bound is copy) {
        my gint $s = resolve-int($selection_bound);
        clutter_text_set_selection_bound($!ct, $s);
      }
    );
  }

  method single_line_mode is rw is also<single-line-mode> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_single_line_mode($!ct);
      },
      STORE => sub ($, $single_line is copy) {
        my gboolean $s = resolve-bool($single_line);
        clutter_text_set_single_line_mode($!ct, $s);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_text($!ct);
      },
      STORE => sub ($, Str() $text is copy) {
        clutter_text_set_text($!ct, $text);
      }
    );
  }

  method use_markup is rw is also<use-markup> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_use_markup($!ct);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = resolve-bool($setting);
        clutter_text_set_use_markup($!ct, $s);
      }
    );
  }

  # Type: ClutterColor
  method color is rw  {
    my GTK::Compat::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('color', $gv)
        );
        Clutter::Color.new( cast(ClutterColor, $gv.boxed) );
      },
      STORE => -> $, ClutterColor $val is copy {
        $gv.boxed = $val;
        self.prop_set('color', $gv);
      }
    );
  }

  # Type: ClutterColor
  method cursor-color is rw  is also<cursor_color> {
    my GTK::Compat::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-color', $gv)
        );
        Clutter::Color.new( cast(ClutterColor, $gv.boxed) );
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('cursor-color', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-color-set is rw  is also<cursor_color_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'cursor-color-set does not allow writing'
      }
    );
  }

  # Type: gint
  method position is rw  is DEPRECATED<Clutter::Text.cursor-position> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('position', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  # Type: gboolean
  method selected-text-color-set is rw  is also<selected_text_color_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selected-text-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "selected-text-color-set does not allow writing"
      }
    );
  }

  # Type: ClutterColor
  method selection-color is rw  is also<selection_color> {
    my GTK::Compat::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selection-color', $gv)
        );
        Clutter::Color.new( $gv.boxed );
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('selection-color', $gv);
      }
    );
  }

  # Type: gboolean
  method selection-color-set is rw  is also<selection_color_set> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selection-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "selection-color-set does not allow writing"
      }
    );
  }

  # Is originally:
  # ClutterText, gpointer --> void
  method activate {
    self.connect($!ct, 'activate');
  }

  # Is originally:
  # ClutterText, gpointer --> void
  method cursor-changed is also<cursor_changed> {
    self.connect($!ct, 'cursor-changed');
  }

  # Is originally:
  # ClutterText, ClutterGeometry, gpointer --> void
  method cursor-event is also<cursor_event> {
    self.connect-cursor-event($!ct);
  }

  # Is originally:
  # ClutterText, gint, gint, gpointer --> void
  # Renamed due to conflict with method.
  method delete-text-signal is also<delete_text_signal> {
    self.connect-intint($!ct, 'delete-text');
  }

  # Is originally:
  # ClutterText, gchar, gint, gpointer, gpointer --> void
  # Renamed due to conflict with method.
  method insert-text-signal is also<insert_text_signal> {
    self.connect-insert-text($!ct);
  }

  # Is originally:
  # ClutterText, gpointer --> void
  method text-changed is also<text_changed> {
    self.connect($!ct, 'text-changed');
  }

  method emit-activate {
    so clutter_text_activate($!ct);
  }

  method coords_to_position (Num() $x, Num() $y) is also<coords-to-position> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_text_coords_to_position($!ct, $xx, $yy);
  }

  method delete_chars (Int() $n_chars) is also<delete-chars> {
    my guint $nc = resolve-uint($n_chars);
    clutter_text_delete_chars($!ct, $nc);
  }

  method delete_selection is also<delete-selection> {
    clutter_text_delete_selection($!ct);
  }

  # Cannot offer alias due to conflict with signal.
  method delete_text (Int() $start_pos, Int() $end_pos) is also<delete-text> {
    my gssize ($sp, $ep) = resolve-long($start_pos, $end_pos);
    clutter_text_delete_text($!ct, $start_pos, $end_pos);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) is also<get-chars> {
    my gssize ($sp, $ep) = resolve-long($start_pos, $end_pos);
    clutter_text_get_chars($!ct, $start_pos, $end_pos);
  }

  method get_color (ClutterColor() $color) is also<get-color> {
    clutter_text_get_color($!ct, $color);
  }

  method get_cursor_color (ClutterColor() $color) is also<get-cursor-color> {
    clutter_text_get_cursor_color($!ct, $color);
  }

  method get_cursor_rect (ClutterRect() $rect) is also<get-cursor-rect> {
    clutter_text_get_cursor_rect($!ct, $rect);
  }

  method get_layout 
    is also<
      get-layout
      layout
    > 
  {
    Pango::Layout.new( clutter_text_get_layout($!ct) );
  }

  method get_layout_offsets (Int() $x, Int() $y) is also<get-layout-offsets> {
    my gint ($xx, $yy) = resolve-int($x, $y);
    clutter_text_get_layout_offsets($!ct, $x, $y);
  }

  method get_selected_text_color (ClutterColor $color) is also<get-selected-text-color> {
    clutter_text_get_selected_text_color($!ct, $color);
  }

  method get_selection is also<get-selection> {
    clutter_text_get_selection($!ct);
  }

  method get_selection_color (ClutterColor() $color) is also<get-selection-color> {
    clutter_text_get_selection_color($!ct, $color);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_text_get_type, $n, $t );
  }

  method insert_text (Str() $text, Int() $position) is also<insert-text> {
    my gssize $p = resolve-long($position);
    clutter_text_insert_text($!ct, $text, $p);
  }

  method insert_unichar ($wc) is also<insert-unichar> {
    my $wwc = resolve-unichar($wc);
    clutter_text_insert_unichar($!ct, $wwc);
  }

  method position_to_coords (
    Int() $position,
    Num() $x,
    Num() $y,
    Num() $line_height
  ) is also<position-to-coords> {
    my gint $p = resolve-int($position);
    my gfloat ($xx, $yy, $l) = ($x, $y, $line_height);
    clutter_text_position_to_coords($!ct, $p, $xx, $yy, $l);
  }

  method set_color (ClutterColor() $color) is also<set-color> {
    clutter_text_set_color($!ct, $color);
  }

  method set_cursor_color (ClutterColor() $color) is also<set-cursor-color> {
    clutter_text_set_cursor_color($!ct, $color);
  }

  method set_markup (Str() $markup) is also<set-markup> {
    clutter_text_set_markup($!ct, $markup);
  }

  method set_preedit_string (
    Str() $preedit_str,
    PangoAttrList() $preedit_attrs,
    Int() $cursor_pos
  ) is also<set-preedit-string> {
    my guint $c = resolve-uint($cursor_pos);
    clutter_text_set_preedit_string($!ct, $preedit_str, $preedit_attrs, $c);
  }

  method set_selected_text_color (ClutterColor() $color) is also<set-selected-text-color> {
    clutter_text_set_selected_text_color($!ct, $color);
  }

  method set_selection (Int() $start_pos, Int() $end_pos) is also<set-selection> {
    my gssize ($sp, $ep) = resolve-long($start_pos, $end_pos);
    clutter_text_set_selection($!ct, $start_pos, $end_pos);
  }

  method set_selection_color (ClutterColor() $color) is also<set-selection-color> {
    clutter_text_set_selection_color($!ct, $color);
  }

}
