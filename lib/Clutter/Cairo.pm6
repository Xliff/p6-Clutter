use v6.c;

use NativeCall;

use Cairo;


use Clutter::Compat::Types;
use Clutter::Raw::Types;

class Clutter::Cairo {
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
