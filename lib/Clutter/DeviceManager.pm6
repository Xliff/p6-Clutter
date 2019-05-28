use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::DeviceManager;

use GTK::Compat::GSList;
use GTK::Compat::Roles::ListData;

use GTK::Compat::Roles::Object;

use Clutter::Roles::Signals::DeviceManager;

use Clutter::InputDevice;

class Clutter::DeviceManager {
  also does GTK::Compat::Roles::Object;
  also does Clutter::Roles::Signals::DeviceManager;
  
  has ClutterDeviceManager $!cdm;
  
  submethod BUILD (:$manager) {
    self!setObject( cast(GObject, $!cdm = $manager) );
  }

  method new (ClutterDeviceManager $manager) {
    self.bless(:$manager);
  }
  
  method get_default {
    self.bless( manager => clutter_device_manager_get_default() );
  }
  
  method Clutter::Raw::Types::ClutterDeviceManager 
  { $!cdm }
  
  # Is originally:
  # ClutterDeviceManager, ClutterInputDevice, gpointer --> void
  method device-added {
    self.connect-device($!cdm, 'device-added');
  }

  # Is originally:
  # ClutterDeviceManager, ClutterInputDevice, gpointer --> void
  method device-removed {
    self.connect-device($!cdm, 'device-removed');
  }
  
  method get_core_device (
    Int() $device_type # ClutterInputDeviceType $device_type
  ) {
    my guint $dt = resolve-uint($device_type);
    Clutter::InputDevice.new( 
      clutter_device_manager_get_core_device($!cdm, $dt) 
    );
  }

  method get_device (Int() $device_id) {
    my gint $did = resolve-int($device_id);
    clutter_device_manager_get_device($!cdm, $did);
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_device_manager_get_type, $n, $t );
  }

  method list_devices (:$raw = False) {
    my $l = GTK::Compat::GSList.new( 
      clutter_device_manager_list_devices($!cdm)
    ) but GTK::Compat::Roles::ListData[ClutterInputDevice];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::InputDevice.new($_) });
  }

  method peek_devices (:$raw = False) {
    my $l = GTK::Compat::GSList.new( 
      clutter_device_manager_peek_devices($!cdm)
    ) but GTK::Compat::Roles::ListData[ClutterInputDevice];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::InputDevice.new($_) });
  }
  
}
