use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Content {
  also does Clutter::Roles::Signals::Generic;

  has ClutterContent $!c-con;

  method Clutter::Raw::Types::ClutterContent
  { $!c-con }

  method attached {
    self.connect-actor($!c-con, 'attached');
  }
  
  method detached {
    self.connect-actor($!c-con, 'detached');
  }

  method get_preferred_size (Num() $width, Num() $height) {
    my gfloat ($w, $h) = ($width, $height);
    clutter_content_get_preferred_size($!c-con, $width, $height);
  }

  method content_get_type {
    state ($n, $t);
    unstable_get_type('Clutter::Content', &clutter_content_get_type, $n, $t );
  }

  method invalidate {
    clutter_content_invalidate($!c-con);
  }

}

sub clutter_content_get_preferred_size (
  ClutterContent $content,
  gfloat $width,
  gfloat $height
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_content_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_content_invalidate (ClutterContent $content)
  is native(clutter)
  is export
{ * }
