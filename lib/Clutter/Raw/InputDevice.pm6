use v6.c

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::InputDevice;

sub clutter_input_device_get_associated_device (ClutterInputDevice $device)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_axis (ClutterInputDevice $device, guint $index)
  returns ClutterInputAxis
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_axis_value (
  ClutterInputDevice $device, 
  CArray[gdouble] $axes, 
  ClutterInputAxis $axis, 
  gdouble $value
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_coords (
  ClutterInputDevice $device, 
  ClutterEventSequence $sequence, 
  ClutterPoint $point
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_device_id (ClutterInputDevice $device)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_device_mode (ClutterInputDevice $device)
  returns ClutterInputMode
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_device_name (ClutterInputDevice $device)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_device_type (ClutterInputDevice $device)
  returns ClutterInputDeviceType
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_grabbed_actor (ClutterInputDevice $device)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_has_cursor (ClutterInputDevice $device)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_key (
  ClutterInputDevice $device, 
  guint $index, 
  guint $keyval, 
  guint $modifiers # ClutterModifierType $modifiers
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_modifier_state (ClutterInputDevice $device)
  returns ClutterModifierType
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_n_axes (ClutterInputDevice $device)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_n_keys (ClutterInputDevice $device)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_pointer_actor (ClutterInputDevice $device)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_pointer_stage (ClutterInputDevice $device)
  returns ClutterStage
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_product_id (ClutterInputDevice $device)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_slave_devices (ClutterInputDevice $device)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_vendor_id (ClutterInputDevice $device)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_input_device_grab (
  ClutterInputDevice $device, 
  ClutterActor $actor
)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_keycode_to_evdev (
  ClutterInputDevice $device, 
  guint $hardware_keycode, 
  guint $evdev_keycode
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_sequence_get_grabbed_actor (
  ClutterInputDevice $device, 
  ClutterEventSequence $sequence
)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_input_device_sequence_grab (
  ClutterInputDevice $device, 
  ClutterEventSequence $sequence, 
  ClutterActor $actor
)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_sequence_ungrab (
  ClutterInputDevice $device, 
  guint $sequence # ClutterEventSequence $sequence
)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_set_key (
  ClutterInputDevice $device, 
  guint $index, 
  guint $keyval, 
  guint $modifiers # ClutterModifierType $modifiers
)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_ungrab (ClutterInputDevice $device)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_update_from_event (
  ClutterInputDevice $device, 
  ClutterEvent $event, 
  gboolean $update_stage
)
  is native(clutter)
  is export
{ * }

sub clutter_input_device_get_enabled (ClutterInputDevice $device)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_input_device_set_enabled (
  ClutterInputDevice $device, 
  gboolean $enabled
)
  is native(clutter)
  is export
{ * }
