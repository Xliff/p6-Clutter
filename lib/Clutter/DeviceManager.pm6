use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::DeviceManager;

use GLib::GSList;
use Clutter::InputDevice;

use GLib::Roles::Object;
use GLib::Roles::ListData;
use Clutter::Roles::Signals::DeviceManager;

class Clutter::DeviceManager {
  also does GLib::Roles::Object;
  also does Clutter::Roles::Signals::DeviceManager;

  has ClutterDeviceManager $!cdm is implementor;

  submethod BUILD (:$manager) {
    $!cdm = $manager;

    self.roleInit-Object;
  }

  method new (ClutterDeviceManager $manager) {
    $manager ?? self.bless( :$manager ) !! Nil
  }

  method get_default is also<get-default> {
    my $manager = clutter_device_manager_get_default();

    $manager ?? self.bless( :$manager ) !! Nil
  }

  method Clutter::Raw::Definitions::ClutterDeviceManager
    is also<ClutterDeviceManager>
  { $!cdm }

  # Is originally:
  # ClutterDeviceManager, ClutterInputDevice, gpointer --> void
  method device-added is also<device_added> {
    self.connect-device($!cdm, 'device-added');
  }

  # Is originally:
  # ClutterDeviceManager, ClutterInputDevice, gpointer --> void
  method device-removed is also<device_removed> {
    self.connect-device($!cdm, 'device-removed');
  }

  method get_core_device (
    Int() $device_type # ClutterInputDeviceType $device_type,
    :$raw = False
  )
    is also<get-core-device>
  {
    my guint $dt = $device_type;
    my $d = clutter_device_manager_get_core_device($!cdm, $dt);

    $d ??
      ( $raw ?? $d !! Clutter::InputDevice.new($d) )
      !!
      Nil;
  }

  method get_device (Int() $device_id, :$raw = False) is also<get-device> {
    my gint $did = $device_id;
    my $d = clutter_device_manager_get_device($!cdm, $did);

    $d ??
      ( $raw ?? $d !! Clutter::InputDevice.new($d) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_device_manager_get_type, $n, $t );
  }

  method list_devices (:$glist = False, :$raw = False) is also<list-devices> {
    my $dl = clutter_device_manager_list_devices($!cdm);

    return Nil unless $dl;
    return $dl if     $glist;

    $dl = GLib::GList.new($dl)
      but GLib::Roles::ListData[ClutterInputDevice];

    $raw ?? $dl.Array !! $dl.Array.map({ Clutter::InputDevice.new($_) });
  }

  method peek_devices (:$glist = False, :$raw = False) is also<peek-devices> {
    my $dl = clutter_device_manager_peek_devices($!cdm);

    return Nil unless $dl;
    return $dl if     $glist;

    $dl = GLib::GList.new($dl)
      but GLib::Roles::ListData[ClutterInputDevice];

    $raw ?? $dl.Array !! $dl.Array.map({ Clutter::InputDevice.new($_) });
  }

}
