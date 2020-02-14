use v6.c;

use Method::Also;
use NativeCall;

use Cairo;


use Clutter::Raw::Types;
use Clutter::Compat::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Image;

use GLib::Roles::Object;

use Clutter::Roles::Content;

class Clutter::Image {
  also does GLib::Roles::Object;
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
    Pointer $data,
    Int() $pixel_format,
    cairo_rectangle_int_t $rect,
    Int() $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-area>
  {
    clear_error;
    my guint ($pf, $rs) = resolve-uint($pixel_format, $row_stride);
    my $rc = clutter_image_set_area($!ci, $data, $pf, $rect, $rs, $error);
    set_error($error);
    so $rc;
  }

  method set_bytes (
    GBytes $data,
    Int() $pixel_format,
    Int() $width,
    Int() $height,
    Int() $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-bytes>
  {
    my guint ($w, $h, $r) = resolve-uint($width, $height, $row_stride);
    my guint $pf = resolve-uint($pixel_format);
    clear_error;
    my $rc = clutter_image_set_bytes($!ci, $data, $pf, $w, $h, $r, $error);
    set_error($error);
    so $rc;
  }

  method set_data (
    Pointer $data,
    Int() $pixel_format,
    Int() $width,
    Int() $height,
    Int() $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-data>
  {
    my guint ($w, $h, $r) = resolve-uint($width, $height, $row_stride);
    my guint $pf = resolve-uint($pixel_format);
    clear_error;
    my $rc = clutter_image_set_data(
      $!ci, $data, $pf, $w, $h, $r, $error
    );
    set_error($error);
    so $rc;
  }

}
