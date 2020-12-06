use v6.c;

use NativeCall;

use Cairo;

use Clutter::Raw::Types;

use GLib::Roles::StaticClass;

my subset CairoOrContext where Cairo::Context | cairo_t;

class Clutter::Cairo {
  also does GLib::Roles::StaticClass;

  method clear (CairoOrContext $cr is copy) {
    $cr .= context if $cr ~~ Cairo::Context;

    clutter_cairo_clear($cr);
  }

  method set_source_color (CairoOrContext $cr is copy, ClutterColor() $color) {
    $cr .= context if $cr ~~ Cairo::Context;

    clutter_cairo_set_source_color($cr, $color);
  }
}

sub clutter_cairo_clear (cairo_t $cr)
  is native(clutter)
  is export
{ * }

sub clutter_cairo_set_source_color (cairo_t $cr, ClutterColor $color)
  is native(clutter)
  is export
{ * }
