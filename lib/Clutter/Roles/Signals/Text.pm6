use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Roles::Signals::Generic;

role Clutter::Roles::Signals::Text {
  also does GTK::Roles::Signals::Generic;

  has %!signals-ct;

  # ClutterText, ClutterGeometry, gpointer
  method connect-cursor-event (
    $obj,
    $signal = 'cursor-event',
    &handler?
  ) {
    my $hid;
    %!signals-ct{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-cursor-event($obj, $signal,
        -> $, $cgy, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $cgy, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ct{$signal}[0].tap(&handler) with &handler;
    %!signals-ct{$signal}[0];
  }

  # ClutterText, gchar, gint, gpointer, gpointer
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-ct{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $gc, $gt, $gp, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gc, $gt, $gp, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-ct{$signal}[0].tap(&handler) with &handler;
    %!signals-ct{$signal}[0];
  }

}


# ClutterText, ClutterGeometry, gpointer
sub g-connect-cursor-event(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterGeometry, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# ClutterText, gchar, gint, gpointer, gpointer
sub g-connect-insert-text(
  Pointer $app,
  Str $name,
  &handler (Pointer, gchar, gint, gpointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
