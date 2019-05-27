use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Main;

class Clutter::Main {
  
  method base_init is also<base-init> {
    clutter_base_init();
  }

  method check_version (Int() $major, Int() $minor, Int() $micro) 
    is also<check-version> 
  {
    my guint ($mj, $mn, $mc) = resolve-uint($major, $minor, $micro);
    clutter_check_version($major, $minor, $micro);
  }

  method check_windowing_backend (Str() $backend_type) 
    is also<check-windowing-backend> 
  {
    clutter_check_windowing_backend($backend_type);
  }

  method disable_accessibility is also<disable-accessibility> {
    clutter_disable_accessibility();
  }

  method do_event (ClutterEvent() $event) is also<do-event> {
    clutter_do_event($event);
  }

  method get_accessibility_enabled is also<get-accessibility-enabled> {
    clutter_get_accessibility_enabled();
  }

  method get_default_frame_rate is also<get-default-frame-rate> {
    clutter_get_default_frame_rate();
  }

  method get_default_text_direction is also<get-default-text-direction> {
    clutter_get_default_text_direction();
  }

  method get_font_map is also<get-font-map> {
    clutter_get_font_map();
  }

  method get_keyboard_grab is also<get-keyboard-grab> {
    clutter_get_keyboard_grab();
  }

  method get_option_group is also<get-option-group> {
    clutter_get_option_group();
  }

  method get_option_group_without_init is also<get-option-group-without-init> {
    clutter_get_option_group_without_init();
  }

  method get_pointer_grab is also<get-pointer-grab> {
    clutter_get_pointer_grab();
  }

  method grab_keyboard (ClutterActor() $actor) is also<grab-keyboard> {
    clutter_grab_keyboard($actor);
  }

  method grab_pointer (ClutterActor() $actor) is also<grab-pointer> {
    clutter_grab_pointer($actor);
  }

  method init {
    my $argc = CArray[gint];
    my $argv = CArray[Str];
    clutter_init($argc, $argv);
  }

  method init_error_quark is also<init-error-quark> {
    clutter_init_error_quark();
  }

  method init_with_args (
    CArray[gint] $argc, 
    CArray[Str] $argv, 
    Str $parameter_string, 
    GOptionEntry() $entries, 
    Str() $translation_domain, 
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<init-with-args> 
  {
    clear_error;
    my $rc = clutter_init_with_args(
      $argc, 
      $argv, 
      $parameter_string, 
      $entries, 
      $translation_domain, 
      $error
    );
    set_error($error);
    $rc;
  }

  method run {
    clutter_main();
  }

  method level {
    clutter_main_level();
  }

  method quit {
    clutter_main_quit();
  }

  method ungrab_keyboard is also<ungrab-keyboard> {
    clutter_ungrab_keyboard();
  }

  method ungrab_pointer is also<ungrab-pointer> {
    clutter_ungrab_pointer();
  }

}
