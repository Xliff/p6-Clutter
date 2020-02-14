use v6.c;

use NativeCall;


use Clutter::Raw::Types;

use GTK::Raw::ReturnedValue;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Signals::PanAction {
  also does Clutter::Roles::Signals::Generic;
  
  has %!signals-cpa;
  
  # ClutterPanAction, ClutterActor, gboolean, gpointer --> gboolean
  method connect-pan (
    $obj,
    $signal = 'pan',
    &handler?
  ) {
    my $hid;
    %!signals-cpa{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-pan($obj, $signal,
        -> $, $ca, $g, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $ca, $g, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cpa{$signal}[0].tap(&handler) with &handler;
    %!signals-cpa{$signal}[0];
  }
  
}

# ClutterPanAction, ClutterActor, gboolean, gpointer --> gboolean
sub g-connect-pan(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, gboolean, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
