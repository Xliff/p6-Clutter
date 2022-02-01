use v6.c;

use Method::Also;
use NativeCall;

use Cairo;

use Clutter::Raw::Types;
use Clutter::Raw::Image;

use GLib::Roles::Object;
use Clutter::Roles::Content;

our subset ClutterImageAncestry is export of Mu
  where ClutterContent | ClutterImage | GObject;

class Clutter::Image {
  also does GLib::Roles::Object;
  also does Clutter::Roles::Content;

  has ClutterImage $!ci is implementor;

  submethod BUILD (:$image) {
    given $image {
      when    ClutterImageAncestry { self.setImage($_) }
      when    Clutter::Image       { }
      default                      { }
    }
  }

  method setImage (ClutterImageAncestry $_) {
    my $to-parent;
    $!ci = do {
      when ClutterImage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when ClutterContent {
        $!c-con = $_;
        $to-parent = cast(GObject, $_);
        cast(ClutterImage, $_);
      }

      default {
        $to-parent = $_;
        cast(ClutterImage, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-ClutterContent unless $!c-con;
  }

  method Clutter::Raw::Definitions::ClutterImage
    is also<ClutterImage>
  { $!ci }

  multi method new (ClutterImageAncestry $image) {
    $image ?? self.bless(:$image) !! Nil;
  }
  multi method new {
    my $image = clutter_image_new();

    $image ?? self.bless(:$image) !! Nil;
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
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-area>
  {
    clear_error;
    my CoglPixelFormat $pf = $pixel_format;
    my guint $rs = $row_stride;

    my $rv = so clutter_image_set_area($!ci, $data, $pf, $rect, $rs, $error);
    set_error($error);
    $rv;
  }

  method set_bytes (
    GBytes() $data,
    Int() $pixel_format,
    Int() $width,
    Int() $height,
    Int() $row_stride,
    CArray[Pointer[GError]] $error = gerror()
  )
    is also<set-bytes>
  {
    my guint ($w, $h, $r) = ($width, $height, $row_stride);
    my CoglPixelFormat $pf = $pixel_format;

    clear_error;
    my $rv = so clutter_image_set_bytes($!ci, $data, $pf, $w, $h, $r, $error);
    set_error($error);
    $rv;
  }

  # cw: Conflicts with GObject.set_sata! [which is not part of GObject spec]
  multi method set_image_data (
    Pointer                 $data,
    Int()                   $pixel_format,
    Int()                   $width,
    Int()                   $height,
    Int()                   $row_stride,
    CArray[Pointer[GError]] $error         = gerror()
  )
    is also<set-image-data>
  {
    my guint ($w, $h, $r) = $width, $height, $row_stride;
    my CoglPixelFormat $pf = $pixel_format;

    clear_error;
    my $rv = so clutter_image_set_data(
      $!ci,
      $data,
      $pf,
      $w,
      $h,
      $r,
      $error
    );
    set_error($error);
    $rv
  }

}
