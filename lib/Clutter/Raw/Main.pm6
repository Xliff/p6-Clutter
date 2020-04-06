use v6.c;

use NativeCall;

use Pango::Raw::Types;


use Clutter::Raw::Types;

unit package Clutter::Raw::Main;

sub clutter_base_init ()
  is native(clutter)
  is export
{ * }

sub clutter_check_version (guint $major, guint $minor, guint $micro)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_check_windowing_backend (Str $backend_type)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_disable_accessibility ()
  is native(clutter)
  is export
{ * }

sub clutter_do_event (ClutterEvent $event)
  is native(clutter)
  is export
{ * }

sub clutter_get_accessibility_enabled ()
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_get_default_frame_rate ()
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_get_default_text_direction ()
  returns guint # ClutterTextDirection
  is native(clutter)
  is export
{ * }

sub clutter_get_font_map ()
  returns PangoFontMap
  is native(clutter)
  is export
{ * }

sub clutter_get_keyboard_grab ()
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_get_option_group ()
  returns GOptionGroup
  is native(clutter)
  is export
{ * }

sub clutter_get_option_group_without_init ()
  returns GOptionGroup
  is native(clutter)
  is export
{ * }

sub clutter_get_pointer_grab ()
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_grab_keyboard (ClutterActor $actor)
  is native(clutter)
  is export
{ * }

sub clutter_grab_pointer (ClutterActor $actor)
  is native(clutter)
  is export
{ * }

sub clutter_init (CArray[gint] $argc, CArray[Str] $argv)
  returns guint # ClutterInitError
  is native(clutter)
  is export
{ * }

sub clutter_init_error_quark ()
  returns GQuark
  is native(clutter)
  is export
{ * }

sub clutter_init_with_args (
  gint $argc, 
  Str $argv, 
  Str $parameter_string, 
  GOptionEntry $entries, 
  Str $translation_domain, 
  CArray[Pointer[GError]] $error
)
  returns guint # ClutterInitError
  is native(clutter)
  is export
{ * }

sub clutter_main ()
  is native(clutter)
  is export
{ * }

sub clutter_main_level ()
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_main_quit ()
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_idle (
  &func (Pointer --> gboolean), 
  gpointer $data
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_idle_full (
  gint $priority, 
  &func (Pointer --> gboolean), 
  gpointer $data, 
  GDestroyNotify $notify
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_repaint_func (
  &func (Pointer --> gboolean), 
  gpointer $data, 
  GDestroyNotify $notify
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_repaint_func_full (
  guint $flags, # ClutterRepaintFlags $flags, 
  &func (Pointer --> gboolean), 
  gpointer $data, 
  GDestroyNotify $notify
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_timeout (
  guint $interval, 
  &func (Pointer --> gboolean), 
  gpointer $data
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_add_timeout_full (
  gint $priority, 
  guint $interval, 
  &func (Pointer --> gboolean), 
  gpointer $data, 
  GDestroyNotify $notify
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_threads_remove_repaint_func (guint $handle_id)
  is native(clutter)
  is export
{ * }

# Deprecated
# sub clutter_threads_set_lock_functions (
#   GCallback $enter_fn, 
#   GCallback $leave_fn
# )
#   is native(clutter)
#   is export
# { * }

sub clutter_ungrab_keyboard ()
  is native(clutter)
  is export
{ * }

sub clutter_ungrab_pointer ()
  is native(clutter)
  is export
{ * }
