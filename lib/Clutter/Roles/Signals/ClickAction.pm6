use v6.c;

use NativeCall;


use Clutter::Raw::Types;

use GLib::Raw::ReturnedValue;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Signals::ClickAction {
  also does Clutter::Roles::Signals::Generic;

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

          say 'long-press' if $DEBUG;
          
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
