use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Compat::Types;

use Clutter::Raw::Scriptable;

role Clutter::Roles::Scriptable {
  has ClutterScriptable $!cs;

  method Clutter::Raw::Definitions::ClutterScriptable
    is also<
      Scriptable
      ClutterScriptable
    >
  { $!cs }

  method roleInit-ClutterScriptable {
    my \i = findProperImplementor(self.^attributes);

    $!cs = cast( ClutterScriptable, i.get_value(self) );
  }

  method setScriptable ($scriptable is copy) {
    #self.IS-PROTECTED;
    $scriptable = cast(ClutterScriptable, $scriptable)
      unless $scriptable ~~ ClutterScriptable;
      
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

  method clutterscriptable_get_type is also<
    clutterscriptable-get-type
    scriptable_get_type
    scriptable-get-type
  > {
    state ($n, $t);

    unstable_get_type(
      'Clutter::Roles::Scriptable', &clutter_scriptable_get_type, $n, $t
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
