use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

role Clutter::Roles::Signals::DeviceManager {
  has %!signals-cdm;
  
  # ClutterDeviceManager, ClutterInputDevice, gpointer
  method connect-device (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-cdm{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-device($obj, $signal,
        -> $, $cide, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $cide, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cdm{$signal}[0].tap(&handler) with &handler;
    %!signals-cdm{$signal}[0];
  }
  
}

# ClutterDeviceManager, ClutterInputDevice, gpointer
sub g-connect-device (
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterInputDevice, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
