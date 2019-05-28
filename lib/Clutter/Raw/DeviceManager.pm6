use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::DeviceManager;

sub clutter_device_manager_get_core_device (
  ClutterDeviceManager $device_manager, 
  guint $device_type # ClutterInputDeviceType $device_type
)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_device_manager_get_default ()
  returns ClutterDeviceManager
  is native(clutter)
  is export
{ * }

sub clutter_device_manager_get_device (
  ClutterDeviceManager $device_manager, 
  gint $device_id
)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_device_manager_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_device_manager_list_devices (ClutterDeviceManager $device_manager)
  returns GSList
  is native(clutter)
  is export
{ * }

sub clutter_device_manager_peek_devices (ClutterDeviceManager $device_manager)
  returns GSList
  is native(clutter)
  is export
{ * }
