use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use Clutter::Roles::Signals::Generic;

role Clutter::Roles::Content {
  also does Clutter::Roles::Signals::Generic;

  has ClutterContent $!c-con;

  submethod BUILD (:$content) {
    $!c-con = $content;
  }

  method Clutter::Raw::Definitions::ClutterContent
    is also<ClutterContent>
  { $!c-con }

  method roleInit-ClutterContent {
    return if $!c-con;

    my \i = findProperImplementor(self.^attributes);
    $!c-con = cast( ClutterContent, i.get_value(self) );
  }

  method new_cluttercontent_obj (ClutterContent $content)
    is also<new-content-object>
  {
    $content ?? self.bless(:$content) !! Nil;
  }

  method attached {
    self.connect-actor($!c-con, 'attached');
  }

  method detached {
    self.connect-actor($!c-con, 'detached');
  }

  proto method get_preferred_size (|)
  { * }

  multi method get_preferred_size {
    samewith($, $);
  }
  multi method get_preferred_size ($width is rw, $height is rw)
    is also<get-preferred-size>
  {
    my gfloat ($w, $h) = 0e0 xx 2;

    clutter_content_get_preferred_size($!c-con, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method content_get_type is also<content-get-type> {
    state ($n, $t);

    unstable_get_type(
      'Clutter::Roles::Content',
      &clutter_content_get_type,
      $n,
      $t
    );
  }

  method invalidate {
    say "C-CON: $!c-con" if $DEBUG;

    clutter_content_invalidate($!c-con);
  }

}

sub clutter_content_get_preferred_size (
  ClutterContent $content,
  gfloat         $width   is rw,
  gfloat         $height  is rw
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
