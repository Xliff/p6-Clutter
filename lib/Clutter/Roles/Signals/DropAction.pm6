use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::ReturnedValue;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Signals::DropAction {
  also does Clutter::Roles::Signals::Generic;

  has %!signals-cda;

  # ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer --> gboolean
  method connect-can-drop (
    $obj,
    $signal = 'can-drop',
    &handler?
  ) {
    my $hid;
    %!signals-cda{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-can-drop($obj, $signal,
        -> $, $ca, $g1, $g2, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ca, $g1, $g2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cda{$signal}[0].tap(&handler) with &handler;
    %!signals-cda{$signal}[0];
  }

  # ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer
  method connect-drop (
    $obj,
    $signal = 'drop',
    &handler?
  ) {
    my $hid;
    %!signals-cda{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drop($obj, $signal,
        -> $, $ca, $g1, $g2, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ca, $g1, $g2, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cda{$signal}[0].tap(&handler) with &handler;
    %!signals-cda{$signal}[0];
  }
}

# ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer --> gboolean
sub g-connect-can-drop(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, gfloat, gfloat, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

# ClutterDropAction, ClutterActor, gfloat, gfloat, gpointer
sub g-connect-drop(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, gfloat, gfloat, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
