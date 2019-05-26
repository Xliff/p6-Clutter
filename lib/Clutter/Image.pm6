use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Image;

use GTK::Compat::Roles::Object;

class Clutter::Image {
  also does GTK::Compat::Roles::Object;
  
  has ClutterImage $!ci;
  
  submethod BUILD (:$image) {
    self!setObject( cast(GObject, $!ci = $image) );
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
    CArray[Pointer[GError]] = gerror() $error
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
    CArray[Pointer[GError]] = gerror() $error
  ) 
    is also<set-bytes> 
  {
    clear_error;
    my $rc = clutter_image_set_bytes($!ci, $data, $pixel_format, $width, $height, $row_stride, $error);
    set_error($error);
    so $rc;
  }

  method set_data (
    guint8 $data, 
    CoglPixelFormat $pixel_format, 
    guint $width, 
    guint $height, 
    guint $row_stride, 
    CArray[Pointer[GError]] = gerror() $error
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
  
