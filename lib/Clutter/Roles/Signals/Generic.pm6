use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

role Clutter::Roles::Signals::Generic {
  has %!signals-clutter;

  # ClutterActor, ClutterActor, gpointer
  method connect-actor (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-clutter{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-actor($obj, $signal,
        -> $, $car, $ud {
          CATCH {
            default { .message.say; $s.quit($_) }
          }

          say 'connect-actor' if $DEBUG;

          $s.emit( [self, $car, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-clutter{$signal}[0].tap(&handler) with &handler;
    %!signals-clutter{$signal}[0];
  }

}

# Object, ClutterActor, gpointer
sub g-connect-actor(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
