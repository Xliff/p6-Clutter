use v6.c;

use NativeCall;


use Clutter::Raw::Types;

class Clutter::Boxed {
  method fog_get_type {
    state ($n, $t);
    unstable_get_type( 'ClutterFog', &clutter_fog_get_type, $n, $t );
  }

  method perspective_get_type {
    state ($n, $t);
    unstable_get_type( 'ClutterFog', &clutter_perspective_get_type, $n, $t );
  }
}


sub clutter_fog_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_perspective_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }
