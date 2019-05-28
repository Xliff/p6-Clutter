use v6.c;

use NativeCall;

use Cairo;

use GTK::Compat::Types;
use Clutter::Raw::Types;
use Clutter::Compat::Types;

unit package Clutter::Raw::Backend;

sub clutter_get_default_backend ()
  returns ClutterBackend
  is native(clutter)
  is export
{ * }

sub clutter_set_windowing_backend (Str $backend_type)
  is native(clutter)
  is export
{ * }

sub clutter_backend_get_cogl_context (ClutterBackend $backend)
  returns CoglContext
  is native(clutter)
  is export
{ * }

sub clutter_backend_get_resolution (ClutterBackend $backend)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_backend_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_backend_get_font_options (ClutterBackend $backend)
  returns cairo_font_options_t
  is native(clutter)
  is export
{ * }

sub clutter_backend_set_font_options (
  ClutterBackend $backend, 
  cairo_font_options_t $options
)
  is native(clutter)
  is export
{ * }
