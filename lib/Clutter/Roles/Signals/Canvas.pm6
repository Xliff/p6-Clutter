use v6.c;

use NativeCall;

use Clutter::Compat::Types;

use GTK::Raw::ReturnedValue;


use Clutter::Raw::Types;

role Clutter::Roles::Signals::Canvas {
  has %!signals-cc;

  # ClutterCanvas, CairoContext, gint, gint, gpointer --> gboolean
  method connect-draw (
    $obj,
    $signal = 'draw',
    &handler?
  ) {
    my $hid;
    %!signals-cc{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-draw($obj, $signal,
        -> $, $cct, $gt1, $gt2, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $cct, $gt1, $gt2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cc{$signal}[0].tap(&handler) with &handler;
    %!signals-cc{$signal}[0];
  }

}

# ClutterCanvas, CairoContext, gint, gint, gpointer --> gboolean
sub g-connect-draw(
  Pointer $app,
  Str $name,
  &handler (Pointer, cairo_t, gint, gint, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
