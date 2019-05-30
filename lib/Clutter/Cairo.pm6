use v6.c;

use NativeCall;

use Cairo;

use GTK::Compat::Types;
use Clutter::Compat::Types;
use Clutter::Raw::Types;

class Clutter::Cairo {
  method clear (CairoOrContext $cr is copy) {
    $cr .= Context if $cr ~~ Cairo::Context;
    clutter_cairo_clear($cr);
  }

  method set_source_color (CairoOrContext $cr, ClutterColor() $color) {
    $cr .= Context if $cr ~~ Cairo::Context;
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
