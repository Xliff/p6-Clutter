use v6.c;

use Method::Also;
use NativeCall;

use Cairo;

use GTK::Compat::Types;
use Clutter::Raw::Types;
use Clutter::Compat::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Image;

use GTK::Compat::Roles::Object;

use Clutter::Roles::Content;

class Clutter::Image {
  also does GTK::Compat::Roles::Object;
  also does Clutter::Roles::Content;

  has ClutterImage $!ci;

  submethod BUILD (:$image) {
    self!setObject( cast(GObject, $!ci = $image) );
    $!c-con = cast(ClutterContent, $!ci);  # Clutter::Roles::Content
  }

  method Clutter::Raw::Types::ClutterImage
    is also<ClutterImage>
  { $!ci }

  method new {
    self.bless( image => clutter_image_new() );
  }

  method error_quark is also<error-quark> {
    clutter_image_error_quark();
  }

  # Returns CoglTexture
  method get_texture is also<get-texture> {
    clutter_image_get_texture($!ci);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_image_get_type, $n, $t );
  }

  method set_area (
    guint8 $data,
    CoglPixelFormat $pixel_format,
    cairo_rectangle_int_t $rect,
    guint $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-area>
  {
    clear_error;
    my $rc = clutter_image_set_area($!ci, $data, $pixel_format, $rect, $row_stride, $error);
    set_error($error);
    so $rc;
  }

  method set_bytes (
    GBytes $data,
    CoglPixelFormat $pixel_format,
    guint $width,
    guint $height,
    guint $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-bytes>
  {
    clear_error;
    my $rc = clutter_image_set_bytes($!ci, $data, $pixel_format, $width, $height, $row_stride, $error);
    set_error($error);
    so $rc;
  }

  method set_data (
    Pointer $data,
    CoglPixelFormat $pixel_format,
    guint $width,
    guint $height,
    guint $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-data>
  {
    clear_error;
    my $rc = clutter_image_set_data(
      $!ci, $data, $pixel_format, $width, $height, $row_stride, $error
    );
    set_error($error);
    so $rc;
  }

}
