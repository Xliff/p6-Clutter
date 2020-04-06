use v6.c;

use Method::Also;

use Cairo;

use Pango::Raw::Types;
use Clutter::Raw::Types;
use Clutter::Raw::Text;

use GLib::Value;
use Pango::AttrList;
use Pango::FontDescription;
use Pango::Layout;
use Clutter::Actor;
use Clutter::Color;
use Clutter::TextBuffer;

use Clutter::Roles::Signals::Text;

# This should become resolve-unichar in GTK::Raw::Utils.
sub resolve-unichar($wc) {
  do given $wc {
    when Str {
      die 'Cannot convert multi-char string to unichar' unless .chars == 1;
      $wc.ord;
    }
    default {
      die 'Invalud type passed to Clutter::Text.insert_unichar'
        unless .^can('Int').elems;
      .Int
    }
  };
}

# 'position' is not listed because it is deprecated. This also allows
# The Clutter::Actor version to be use if it is specified in
#  Clutter::Text.setup
my @attributes = <
  activatable
  attributes
  buffer
  cursor_position          cursor-position
  cursor_size              cursor-size
  cursor_visible           cursor-visible
  editable
  ellipsize
  font_description         font-description
  font_name                font-name
  justify
  line_alignment           line-alignment
  line_wrap                line-wrap
  line_wrap_mode           line-wrap-mode
  max_length               max-length
  password_char            password-char
  selectable
  selection_bound          selection-bound
  single_line_mode         single-line-mode
  text
  use_markup               use-markup
  color
  cursor-color             cursor-color
  cursor_color_set         cursor-color-set
  selected_text_color_set  selected-text-color-set
  selection_color          selection-color
  selection_color_set      selection-color-set
>;

my @set_methods = <
  cursor_color         cursor-color
  markup
  selected_text_color selected-text-color
  selection_color     selection-color
>;

our subset ClutterTextAncestry is export of Mu
  where ClutterText | ClutterActorAncestry;

class Clutter::Text is Clutter::Actor {
  also does Clutter::Roles::Signals::Text;

  has ClutterText $!ct;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$text) {
    given $text {
      when ClutterTextAncestry {
        my $to-parent;
        $!ct = do {
          when ClutterText {
            $to-parent = cast(ClutterActor, $text);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterText, $_);
          }
        }
        self.setActor($to-parent);
      }

      when Clutter::Text {
      }

      default {
      }
    }
  }

  method Clutter::Raw::Definitions::ClutterText
    is also<ClutterText>
  { $!ct }

  multi method new (ClutterTextAncestry $text) {
    $text ?? self.bless(:$text) !! Nil;
  }
  multi method new {
    my $text = clutter_text_new();

    $text ?? self.bless(:$text) !! Nil;
  }

  method new_with_color (ClutterColor() $color)
    is also<new-with-color>
  {
    Clutter::Text.new-full(Str, Str, $color);
  }

  method new_full (
    Str() $font_name,
    Str() $t,
    ClutterColor() $color
  )
    is also<new-full>
  {
    my $text = clutter_text_new_full($font_name, $t, $color);

    $text ?? self.bless(:$text) !! Nil;
  }

  method new_with_buffer (ClutterTextBuffer() $buffer)
    is also<new-with-buffer>
  {
    my $text = clutter_text_new_with_buffer($buffer);

    $text ?? self.bless(:$text) !! Nil;
  }

  method new_with_text (Str() $font, Str() $t) is also<new-with-text> {
    my $text = clutter_text_new_with_text($font, $t);

    $text ?? self.bless(:$text) !! Nil;
  }

  method setup(*%data) {
    for %data.keys {
      when @attributes.any {
        say "TA: { $_ }" if $DEBUG;
        self."$_"() = %data{$_};
        %data{$_}:delete
      }
      when @set_methods.any {
        say "TSM: { $_ }" if $DEBUG;
        self."set_{$_}"( %data{$_} );
        %data{$_}:delete
      }
      when 'selection' {
        say 'T selection' if $DEBUG;
        self.set-selection( |%data<selection> );
        %data{$_}:delete;
      }
    }
    self.Clutter::Actor::setup(|%data) if %data.keys.elems;
    self;
  }

  method activatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_text_get_activatable($!ct);
      },
      STORE => sub ($, Int() $activatable is copy) {
        my gboolean $a = $activatable.so.Int;

        clutter_text_set_activatable($!ct, $a);
      }
    );
  }

  method attributes (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $pal = clutter_text_get_attributes($!ct);

        $pal ??
          ( $raw ?? $pal !! Pango::AttrList.new($pal) )
          !!
          Nil;
      },
      STORE => sub ($, PangoAttrList() $attrs is copy) {
        clutter_text_set_attributes($!ct, $attrs);
      }
    );
  }

  method buffer (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $tb = clutter_text_get_buffer($!ct);

        $tb ??
          ( $raw ?? $tb !! Clutter::TextBuffer.new($tb) )
          !!
          Nil;
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
      STORE => sub ($, Int() $position is copy) {
        my gint $p = $position;

        clutter_text_set_cursor_position($!ct, $position);
      }
    );
  }

  method cursor_size is rw is also<cursor-size> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_cursor_size($!ct);
      },
      STORE => sub ($, Int() $size is copy) {
        my gint $s = $size;

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
        my gboolean $c = $cursor_visible.so.Int;

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
        my gboolean $e = $editable.so.Int;

        clutter_text_set_editable($!ct, $editable);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeModeEnum( clutter_text_get_ellipsize($!ct) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my PangoEllipsizeMode $m = $mode;

        clutter_text_set_ellipsize($!ct, $m);
      }
    );
  }

  method font_description (:$raw = False) is rw is also<font-description> {
    Proxy.new(
      FETCH => sub ($) {
        my $fd = clutter_text_get_font_description($!ct);

        $fd ??
          ( $raw ?? $fd !! Pango::FontDescription.new($fd) )
          !!
          Nil
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
        my gboolean $j = $justify.so.Int;

        clutter_text_set_justify($!ct, $j);
      }
    );
  }

  method line_alignment is rw is also<line-alignment> {
    Proxy.new(
      FETCH => sub ($) {
        PangoAlignmentEnum( clutter_text_get_line_alignment($!ct) );
      },
      STORE => sub ($, Int() $alignment is copy) {
        my PangoAlignment $a = $alignment;

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
        my gboolean $l = $line_wrap.so.Int;

        clutter_text_set_line_wrap($!ct, $l);
      }
    );
  }

  method line_wrap_mode is rw is also<line-wrap-mode> {
    Proxy.new(
      FETCH => sub ($) {
        PangoWrapModeEnum( clutter_text_get_line_wrap_mode($!ct) );
      },
      STORE => sub ($, Int() $wrap_mode is copy) {
        my PangoWrapMode $w = $wrap_mode;

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
        my gint $m = $max;

        clutter_text_set_max_length($!ct, $m);
      }
    );
  }

  method password_char is rw is also<password-char> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_text_get_password_char($!ct);
      },
      STORE => sub ($, Int() $wc is copy) {
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
        my gboolean $s = $selectable.so.Int;

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
        my gint $s = $selection_bound;

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
        my gboolean $s = $single_line.so.Int;

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
        my gboolean $s = $setting.so.Int;

        clutter_text_set_use_markup($!ct, $s);
      }
    );
  }

  # Type: ClutterColor
  method color (:$raw = False) is rw  {
    my GLib::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('color', $gv)
        );

        return Nil unless $gv.boxed;

        my $c = cast(ClutterColor, $gv.boxed);

        $raw ?? $c !! Clutter::Color.new($c);
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('color', $gv);
      }
    );
  }

  # Type: ClutterColor
  method cursor-color (:$raw = False) is rw  is also<cursor_color> {
    my GLib::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cursor-color', $gv)
        );

        return Nil unless $gv.boxed;

        my $c = cast(ClutterColor, $gv.boxed);

        $raw ?? $c !! Clutter::Color.new($c);
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('cursor-color', $gv);
      }
    );
  }

  # Type: gboolean
  method cursor-color-set is rw  is also<cursor_color_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
  method selection-color (:$raw = False) is rw  is also<selection_color> {
    my GLib::Value $gv .= new( Clutter::Color.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('selection-color', $gv)
        );

        return Nil unless $gv.boxed;

        my $c = cast(ClutterColor, $gv.boxed);

        $raw ?? $c !! Clutter::Color.new($c)
      },
      STORE => -> $, ClutterColor() $val is copy {
        $gv.boxed = $val;
        self.prop_set('selection-color', $gv);
      }
    );
  }

  # Type: gboolean
  method selection-color-set is rw  is also<selection_color_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my guint $nc = $n_chars;

    clutter_text_delete_chars($!ct, $nc);
  }

  method delete_selection is also<delete-selection> {
    clutter_text_delete_selection($!ct);
  }

  # Cannot offer alias due to conflict with signal.
  method delete_text (Int() $start_pos, Int() $end_pos) is also<delete-text> {
    my gssize ($sp, $ep) = ($start_pos, $end_pos);

    clutter_text_delete_text($!ct, $start_pos, $end_pos);
  }

  method get_chars (Int() $start_pos, Int() $end_pos) is also<get-chars> {
    my gssize ($sp, $ep) = ($start_pos, $end_pos);

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

  method get_layout (:$raw = False)
    is also<
      get-layout
      layout
    >
  {
    my $pl = clutter_text_get_layout($!ct);

    $pl ??
      ( $raw ?? $pl !! Pango::Layout.new($pl) )
      !!
      Nil;
  }

  proto method get_layout_offsets (|)
    is also<get-layout-offsets>
  { * }

  multi method get_layout_offsets {
    samewith($, $);
  }
  multi method get_layout_offsets ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;

    clutter_text_get_layout_offsets($!ct, $x, $y);
    ($x, $y) = ($xx, $yy);
  }

  method get_selected_text_color (ClutterColor() $color)
    is also<get-selected-text-color>
  {
    clutter_text_get_selected_text_color($!ct, $color);
  }

  method get_selection is also<get-selection> {
    clutter_text_get_selection($!ct);
  }

  method get_selection_color (ClutterColor() $color)
    is also<get-selection-color>
  {
    clutter_text_get_selection_color($!ct, $color);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_text_get_type, $n, $t );
  }

  method insert_text (Str() $text, Int() $position) is also<insert-text> {
    my gssize $p = $position;

    clutter_text_insert_text($!ct, $text, $p);
  }

  method insert_unichar ($wc) is also<insert-unichar> {
    my $wwc = resolve-unichar($wc);

    clutter_text_insert_unichar($!ct, $wwc);
  }

  proto method position_to_coords (|)
    is also<position-to-coords>
  { * }

  multi method position_to_coords (Int() $position) {
    my @r = samewith($position, $, $, $);

    @r[0] ?? @r[1..*] !! False
  }
  multi method position_to_coords (
    Int() $position,
    $x           is rw,
    $y           is rw,
    $line_height is rw
  ) {
    my gint $p = $position;
    my gfloat ($xx, $yy, $l) = 0e0 xx 3;

    my $rv = clutter_text_position_to_coords($!ct, $p, $xx, $yy, $l);
    ($x, $y, $line_height) = ($xx, $yy, $l);
    ($rv, $x, $y, $line_height);
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
  )
    is also<set-preedit-string>
  {
    my guint $c = $cursor_pos;

    clutter_text_set_preedit_string($!ct, $preedit_str, $preedit_attrs, $c);
  }

  method set_selected_text_color (ClutterColor() $color)
    is also<set-selected-text-color>
  {
    clutter_text_set_selected_text_color($!ct, $color);
  }

  method set_selection (Int() $start_pos, Int() $end_pos)
    is also<set-selection>
  {
    my gssize ($sp, $ep) = ($start_pos, $end_pos);

    clutter_text_set_selection($!ct, $start_pos, $end_pos);
  }

  method set_selection_color (ClutterColor() $color)
    is also<set-selection-color>
  {
    clutter_text_set_selection_color($!ct, $color);
  }

}
