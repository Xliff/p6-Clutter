use v6.c;

use NativeCall;


use Clutter::Raw::Types;

use GTK::Raw::ReturnedValue;

use GLib::Roles::Signals::Generic;

role Clutter::Roles::Signals::Stage {
  has %!signals-cs;

  # ClutterStage, ClutterEvent, gpointer --> gboolean
  method connect-delete-event (
    $obj,
    $signal = 'delete-event',
    &handler?
  ) {
    my $hid;
    %!signals-cs{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-delete-event($obj, $signal,
        -> $, $cet, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $cet, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cs{$signal}[0].tap(&handler) with &handler;
    %!signals-cs{$signal}[0];
  }

}

# ClutterStage, ClutterEvent, gpointer --> gboolean
sub g-connect-delete-event(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterEvent, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
