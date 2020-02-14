use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;


use Clutter::Raw::Types;

role Clutter::Roles::Signals::DragAction {
  has %!signals-cda;

  # ClutterDragAction, ClutterActor, gfloat, gfloat, ClutterModifierType (guint), gpointer
  method connect-drag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-cda{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag($obj, $signal,
        -> $, $ca, $g1, $g2, $cmt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ca, $g1, $g2, $cmt, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cda{$signal}[0].tap(&handler) with &handler;
    %!signals-cda{$signal}[0];
  }

  # ClutterDragAction, ClutterActor, gfloat, gfloat, gpointer
  method connect-drag-motion (
    $obj,
    $signal = 'drag-motion',
    &handler?
  ) {
    my $hid;
    %!signals-cda{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-motion($obj, $signal,
        -> $, $ca, $g1, $g2, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $ca, $g1, $g2, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-cda{$signal}[0].tap(&handler) with &handler;
    %!signals-cda{$signal}[0];
  }

  # ClutterDragAction, ClutterActor, gfloat, gfloat, gpointer --> gboolean
  method connect-drag-progress (
    $obj,
    $signal = 'drag-progress',
    &handler?
  ) {
    my $hid;
    %!signals-cda{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-drag-progress($obj, $signal,
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
}

# ClutterDragAction, ClutterActor, gfloat, gfloat, ClutterModifierType(guint), gpointer
sub g-connect-drag(
  Pointer $app,
  Str $name,
  &handler (Pointer, ClutterActor, gfloat, gfloat, guint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# ClutterDragAction, ClutterActor, gfloat, gfloat, gpointer
sub g-connect-drag-motion(
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

# ClutterDragAction, ClutterActor, gfloat, gfloat, gpointer --> gboolean
sub g-connect-drag-progress(
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
