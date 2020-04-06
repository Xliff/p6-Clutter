use v6.c;

use NativeCall;

use Cairo;


use Clutter::Raw::Types;
use Clutter::Compat::Types;

unit package Clutter::Raw::Image;

sub clutter_image_error_quark ()
  returns GQuark
  is native(clutter)
  is export
{ * }

sub clutter_image_get_texture (ClutterImage $image)
  returns CoglTexture
  is native(clutter)
  is export
{ * }

sub clutter_image_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_image_new ()
  returns ClutterImage
  is native(clutter)
  is export
{ * }

sub clutter_image_set_area (
  ClutterImage $image, 
  Pointer $data, 
  guint $pixel_format, # CoglPixelFormat $pixel_format, 
  cairo_rectangle_int_t $rect, 
  guint $row_stride, 
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_image_set_bytes (
  ClutterImage $image, 
  GBytes $data, 
  guint $pixel_format, # CoglPixelFormat $pixel_format, 
  guint $width, 
  guint $height, 
  guint $row_stride, 
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_image_set_data (
  ClutterImage $image, 
  Pointer $data, 
  guint $pixel_format, # CoglPixelFormat $pixel_format, 
  guint $width, 
  guint $height, 
  guint $row_stride, 
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(clutter)
  is export
{ * }
