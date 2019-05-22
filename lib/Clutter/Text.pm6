use v6.c;

use GTK::Compat::Types;
use Pango::Raw::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Text;

use Clutter::Actor;

use Clutter::Roles::Signals::Text;

class Clutter::Text is Clutter::Actor {
  also does Clutter::Roles::Signals::Text;

  has ClutterText $!ct;

  submethod BUILD (:$textactor) {
    self.setActor( $!ct = $textactor );
  }

  method activatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_activatable($!ct);
      },
      STORE => sub ($, $activatable is copy) {
        clutter_text_set_activatable($!ct, $activatable);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_attributes($!ct);
      },
      STORE => sub ($, $attrs is copy) {
        clutter_text_set_attributes($!ct, $attrs);
      }
    );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_buffer($!ct);
      },
      STORE => sub ($, $buffer is copy) {
        clutter_text_set_buffer($!ct, $buffer);
      }
    );
  }

  method cursor_position is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_position($!ct);
      },
      STORE => sub ($, $position is copy) {
        clutter_text_set_cursor_position($!ct, $position);
      }
    );
  }

  method cursor_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_size($!ct);
      },
      STORE => sub ($, $size is copy) {
        clutter_text_set_cursor_size($!ct, $size);
      }
    );
  }

  method cursor_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_visible($!ct);
      },
      STORE => sub ($, $cursor_visible is copy) {
        clutter_text_set_cursor_visible($!ct, $cursor_visible);
      }
    );
  }

  method editable is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_editable($!ct);
      },
      STORE => sub ($, $editable is copy) {
        clutter_text_set_editable($!ct, $editable);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_ellipsize($!ct);
      },
      STORE => sub ($, $mode is copy) {
        clutter_text_set_ellipsize($!ct, $mode);
      }
    );
  }

  method font_description is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_font_description($!ct);
      },
      STORE => sub ($, $font_desc is copy) {
        clutter_text_set_font_description($!ct, $font_desc);
      }
    );
  }

  method font_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_font_name($!ct);
      },
      STORE => sub ($, $font_name is copy) {
        clutter_text_set_font_name($!ct, $font_name);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_justify($!ct);
      },
      STORE => sub ($, $justify is copy) {
        clutter_text_set_justify($!ct, $justify);
      }
    );
  }

  method line_alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_line_alignment($!ct);
      },
      STORE => sub ($, $alignment is copy) {
        clutter_text_set_line_alignment($!ct, $alignment);
      }
    );
  }

  method line_wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_line_wrap($!ct);
      },
      STORE => sub ($, $line_wrap is copy) {
        clutter_text_set_line_wrap($!ct, $line_wrap);
      }
    );
  }

  method line_wrap_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_line_wrap_mode($!ct);
      },
      STORE => sub ($, $wrap_mode is copy) {
        clutter_text_set_line_wrap_mode($!ct, $wrap_mode);
      }
    );
  }

  method max_length is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_max_length($!ct);
      },
      STORE => sub ($, $max is copy) {
        clutter_text_set_max_length($!ct, $max);
      }
    );
  }

  method password_char is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_password_char($!ct);
      },
      STORE => sub ($, $wc is copy) {
        clutter_text_set_password_char($!ct, $wc);
      }
    );
  }

  method selectable is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_selectable($!ct);
      },
      STORE => sub ($, $selectable is copy) {
        clutter_text_set_selectable($!ct, $selectable);
      }
    );
  }

  method selection_bound is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_selection_bound($!ct);
      },
      STORE => sub ($, $selection_bound is copy) {
        clutter_text_set_selection_bound($!ct, $selection_bound);
      }
    );
  }

  method single_line_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_single_line_mode($!ct);
      },
      STORE => sub ($, $single_line is copy) {
        clutter_text_set_single_line_mode($!ct, $single_line);
      }
    );
  }

  method text is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_text($!ct);
      },
      STORE => sub ($, $text is copy) {
        clutter_text_set_text($!ct, $text);
      }
    );
  }

  method use_markup is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_use_markup($!ct);
      },
      STORE => sub ($, $setting is copy) {
        clutter_text_set_use_markup($!ct, $setting);
      }
    );
  }

  # Type: gboolean
  method activatable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('activatable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('activatable', $gv);
      }
    );
  }

  # Type: PangoAttrList
  method attributes is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('attributes', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('attributes', $gv);
      }
    );
  }

  # Type: ClutterTextBuffer
  method buffer is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('buffer', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: ClutterColor
  method color is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('color', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('color', $gv);
      }
    );
  }

  # Type: ClutterColor
  method cursor-color is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-color', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('cursor-color', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-color-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-color-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "cursor-color-set does not allow writing"
      }
    );
  }

  # Type: gint
  method cursor-position is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-position', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('cursor-position', $gv);
      }
    );
  }

  # Type: gint
  method cursor-size is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('cursor-size', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-visible is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('cursor-visible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('cursor-visible', $gv);
      }
    );
  }

  # Type: gboolean
  method editable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('editable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method ellipsize is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('ellipsize', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  # Type: PangoFontDescription
  method font-description is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('font-description', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('font-description', $gv);
      }
    );
  }

  # Type: gchar
  method font-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('font-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-name', $gv);
      }
    );
  }

  # Type: gboolean
  method justify is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('justify', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('justify', $gv);
      }
    );
  }

  # Type: PangoAlignment
  method line-alignment is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('line-alignment', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('line-alignment', $gv);
      }
    );
  }

  # Type: gboolean
  method line-wrap is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('line-wrap', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('line-wrap', $gv);
      }
    );
  }

  # Type: PangoWrapMode
  method line-wrap-mode is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('line-wrap-mode', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('line-wrap-mode', $gv);
      }
    );
  }

  # Type: gint
  method max-length is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('max-length', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-length', $gv);
      }
    );
  }

  # Type: guint
  method password-char is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('password-char', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('password-char', $gv);
      }
    );
  }

  # Type: gint
  method position is rw  is DEPRECATED( ClutterText:cursor-position ) {
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
  method selectable is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selectable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('selectable', $gv);
      }
    );
  }

  # Type: ClutterColor
  method selected-text-color is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selected-text-color', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('selected-text-color', $gv);
      }
    );
  }

  # Type: gboolean
  method selected-text-color-set is rw  {
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

  # Type: gint
  method selection-bound is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selection-bound', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('selection-bound', $gv);
      }
    );
  }

  # Type: ClutterColor
  method selection-color is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('selection-color', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('selection-color', $gv);
      }
    );
  }

  # Type: gboolean
  method selection-color-set is rw  {
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

  # Type: gboolean
  method single-line-mode is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('single-line-mode', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('single-line-mode', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: gboolean
  method use-markup is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('use-markup', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
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
  method cursor-changed {
    self.connect($!ct, 'cursor-changed');
  }

  # Is originally:
  # ClutterText, ClutterGeometry, gpointer --> void
  method cursor-event {
    self.connect-cursor-event($!ct);
  }

  # Is originally:
  # ClutterText, gint, gint, gpointer --> void
  method delete-text {
    self.connect-intint($!ct, 'delete-text');
  }

  # Is originally:
  # ClutterText, gchar, gint, gpointer, gpointer --> void
  method insert-text {
    self.connect-insert-text($!ct);
  }

  # Is originally:
  # ClutterText, gpointer --> void
  method text-changed {
    self.connect($!ct, 'text-changed');
  }

  method activate {
    clutter_text_activate($!ct);
  }

  method coords_to_position (gfloat $x, gfloat $y) {
    clutter_text_coords_to_position($!ct, $x, $y);
  }

  method delete_chars (guint $n_chars) {
    clutter_text_delete_chars($!ct, $n_chars);
  }

  method delete_selection {
    clutter_text_delete_selection($!ct);
  }

  method delete_text (gssize $start_pos, gssize $end_pos) {
    clutter_text_delete_text($!ct, $start_pos, $end_pos);
  }

  method get_chars (gssize $start_pos, gssize $end_pos) {
    clutter_text_get_chars($!ct, $start_pos, $end_pos);
  }

  method get_color (ClutterColor $color) {
    clutter_text_get_color($!ct, $color);
  }

  method get_cursor_color (ClutterColor $color) {
    clutter_text_get_cursor_color($!ct, $color);
  }

  method get_cursor_rect (ClutterRect $rect) {
    clutter_text_get_cursor_rect($!ct, $rect);
  }

  method get_layout {
    clutter_text_get_layout($!ct);
  }

  method get_layout_offsets (gint $x, gint $y) {
    clutter_text_get_layout_offsets($!ct, $x, $y);
  }

  method get_selected_text_color (ClutterColor $color) {
    clutter_text_get_selected_text_color($!ct, $color);
  }

  method get_selection {
    clutter_text_get_selection($!ct);
  }

  method get_selection_color (ClutterColor $color) {
    clutter_text_get_selection_color($!ct, $color);
  }

  method get_type {
    clutter_text_get_type();
  }

  method insert_text (Str() $text, gssize $position) {
    clutter_text_insert_text($!ct, $text, $position);
  }

  method insert_unichar (gunichar $wc) {
    clutter_text_insert_unichar($!ct, $wc);
  }

  method new {
    clutter_text_new();
  }

  method new_full (Str() $text, ClutterColor $color) {
    clutter_text_new_full($!ct, $text, $color);
  }

  method new_with_buffer {
    clutter_text_new_with_buffer($!ct);
  }

  method new_with_text (Str() $text) {
    clutter_text_new_with_text($!ct, $text);
  }

  method position_to_coords (
    gint $position,
    gfloat $x,
    gfloat $y,
    gfloat $line_height
  ) {
    clutter_text_position_to_coords($!ct, $position, $x, $y, $line_height);
  }

  method set_color (ClutterColor $color) {
    clutter_text_set_color($!ct, $color);
  }

  method set_cursor_color (ClutterColor $color) {
    clutter_text_set_cursor_color($!ct, $color);
  }

  method set_markup (Str() $markup) {
    clutter_text_set_markup($!ct, $markup);
  }

  method set_preedit_string (
    Str() $preedit_str,
    PangoAttrList $preedit_attrs,
    guint $cursor_pos
  ) {
    clutter_text_set_preedit_string($!ct, $preedit_str, $preedit_attrs, $cursor_pos);
  }

  method set_selected_text_color (ClutterColor $color) {
    clutter_text_set_selected_text_color($!ct, $color);
  }

  method set_selection (gssize $start_pos, gssize $end_pos) {
    clutter_text_set_selection($!ct, $start_pos, $end_pos);
  }

  method set_selection_color (ClutterColor $color) {
    clutter_text_set_selection_color($!ct, $color);
  }

}
