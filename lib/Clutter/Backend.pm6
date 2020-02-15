use v6.c;

use Method::Also;

use Cairo;


use Clutter::Raw::Types;

use Clutter::Raw::Backend;


use Clutter::Roles::Settings;

class Clutter::ClutterBackend {
  
  also does Clutter::Roles::Settings;
  
  has ClutterBackend $!cb;
  
  submethod BUILD (:$backend) {
    self.ADD-PREFIX('Clutter::');
    self.setSettings( cast(ClutterSettings, $!cb = $backend) );
  }
  
  method Clutter::Raw::Definitions::ClutterBackend 
  { $!cb }
  
  method get_default is also<get-default> {
    self.bless( backend => clutter_get_default_backend() );
  }
  
  # Is originally:
  # ClutterBackend, gpointer --> void
  method font-changed is also<font_changed> {
    self.connect($!cb, 'font-changed');
  }

  # Is originally:
  # ClutterBackend, gpointer --> void
  method resolution-changed is also<resolution_changed> {
    self.connect($!cb, 'resolution-changed');
  }

  # Is originally:
  # ClutterBackend, gpointer --> void
  method settings-changed is also<settings_changed> {
    self.connect($!cb, 'settings-changed');
  }
  
  method font_options is rw is also<font-options> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_backend_get_font_options($!cb);
      },
      STORE => sub ($, cairo_font_options_t $options is copy) {
        clutter_backend_set_font_options($!cb, $options);
      }
    );
  }

  # STATIC
  method set_windowing_backend (Str() $backend) 
    is also<set-windowing-backend> 
  {
    clutter_set_windowing_backend($backend);
  }

  method get_cogl_context 
    is also<
      get-cogl-context
      cogl_context
      cogl-context
    > 
  {
    clutter_backend_get_cogl_context($!cb);
  }

  method get_resolution 
    is also<
      get-resolution
      resolution
    > 
  {
    clutter_backend_get_resolution($!cb);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_backend_get_type, $n, $t );
  }
  
}
