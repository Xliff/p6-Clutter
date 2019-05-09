use v6.c;

use NativeCall;

use GTK::Compat::Type;
use Clutter::Raw::Types;

unit package Clutter::Raw::Scriptable;

sub clutter_scriptable_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }

sub clutter_scriptable_parse_custom_node (
  ClutterScriptable $scriptable,
  ClutterScript $script,
  GValue $value,
  Str $name,
  JsonNode $node
)
  returns uint32
  is native(clutter)
  is export
  { * }

sub clutter_scriptable_set_custom_property (
  ClutterScriptable $scriptable,
  ClutterScript $script,
  Str $name,
  GValue $value
)
  is native(clutter)
  is export
  { * }

sub clutter_scriptable_get_id (ClutterScriptable $scriptable)
  returns Str
  is native(clutter)
  is export
  { * }

sub clutter_scriptable_set_id (ClutterScriptable $scriptable, Str $id)
  is native(clutter)
  is export
  { * }
