use v6.c;

use NativeCall;


use Clutter::Raw::Types;

role Clutter::Roles::Signals::Container {
  has %!signals-c;

  # ClutterContainer, ClutterActor, gpointer
  method connect-actor-added (
    $obj,
    $signal = 'actor-added',
    &handler?
  ) {
    my $hid;
    %!signals-c{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-actor-added($obj, $signal,
        -> $, $car, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $car, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-c{$signal}[0].tap(&handler) with &handler;
    %!signals-c{$signal}[0];
  }

  # ClutterContainer, ClutterActor, GParamSpec, gpointer
  method connect-child-notify (
    $obj,
    $signal = 'child-notify',
    &handler?
  ) {
    my $hid;
    %!signals-c{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-child-notify($obj, $signal,
        -> $, $car, $g, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $car, $g, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-c{$signal}[0].tap(&handler) with &handler;
    %!signals-c{$signal}[0];
  }
}

# ClutterContainer, ClutterActor, gpointer
sub g-connect-actor-added(
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

# ClutterContainer, ClutterActor, GParamSpec, gpointer
sub g-connect-child-notify(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, GParamSpec, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
