use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;
use Clutter::Compat::Types;

use Clutter::Raw::Scriptable;

role Clutter::Roles::Scriptable {
  has ClutterScriptable $!cs;
  
  method Clutter::Raw::Types::ClutterScriptable 
    is also<Scriptable>
  { $!cs }

  method setScriptable ($scriptable) {
    self.IS-PROTECTED;
    $!cs = $scriptable;
  }

  method id is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_scriptable_get_id($!cs);
      },
      STORE => sub ($, Str() $id is copy) {
        clutter_scriptable_set_id($!cs, $id);
      }
    );
  }

  method scriptable_get_type is also<scriptable-get-type> {
    state ($n, $t);
    unstable_get_type( 
      'Clutter::Roles, Scriptable', &clutter_scriptable_get_type, $n, $t
    );
  }

  method parse_custom_node (
    ClutterScript() $script,
    GValue() $value,
    Str() $name,
    JsonNode $node
  )
    is also<parse-custom-node>
  {
    clutter_scriptable_parse_custom_node(
      $!cs,
      $script,
      $value,
      $name,
      $node
    );
  }

  method set_custom_property (
    ClutterScript() $script,
    Str() $name,
    GValue() $value
  )
    is also<set-custom-property>
  {
    clutter_scriptable_set_custom_property(
      $!cs,
      $script,
      $name,
      $value
    );
  }

}
