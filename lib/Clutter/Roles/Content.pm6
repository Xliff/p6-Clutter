use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Content {
  also does Clutter::Roles::Signals::Generic;
  
  has ClutterContent $!cc;
  
  method Clutter::Raw::Types::ClutterContent
  { $!cc }
  
  method attached {
    self.connect-actor($!cc, 'attached');
  }
  
  method detached {
    self.connect-actor($!cc, 'detached');
  }
  
  method get_preferred_size (Num() $width, Num() $height) {
    my gfloat ($w, $h) = ($width, $height);
    clutter_content_get_preferred_size($!cc, $width, $height);
  }

  method content_get_type {
    state ($n, $t);
    unstable_get_type('Clutter::Content', &clutter_content_get_type, $n, $t );
  }

  method invalidate {
    clutter_content_invalidate($!cc);
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
