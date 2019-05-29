use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::ReturnedValue;

role Clutter::Roles::Signals::ClickAction {
  has %!signals-cca;

  # ClutterClickAction, ClutterActor, ClutterLongPressState (guint), gpointer --> gboolean
  method connect-long-press (
    $obj,
    $signal = 'long-press',
    &handler?
  ) {
    my $hid;
    %!signals-cca{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-long-press($obj, $signal,
        -> $, $car, $clpse, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $car, $clpse, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cca{$signal}[0].tap(&handler) with &handler;
    %!signals-cca{$signal}[0];
  }

}

# ClutterClickAction, ClutterActor, ClutterLongPressState, gpointer --> gboolean
sub g-connect-long-press(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, guint, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
