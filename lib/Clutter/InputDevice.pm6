use v6.c;

use NativeCall;


use Clutter::Raw::Types;
use Clutter::Raw::InputDevice;



use GLib::Value;
use Clutter::Actor;
use Clutter::Stage;

use GTK::Roles::Properties;

class Clutter::InputDevice {
  also does GTK::Roles::Properties;

  has ClutterInputDevice $!cid;

  submethod BUILD (:$device) {
    self!setObject( cast(GObject, $!cid = $device) )
  }

  method Clutter::Raw::Definitions::ClutterInputDevice
  { $!cid }

  method new (ClutterInputDevice $device) {
    self.bless(:$device);
  }

  method enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_input_device_get_enabled($!cid);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my gboolean $e = resolve-bool($enabled);
        clutter_input_device_set_enabled($!cid, $e);
      }
    );
  }

  # Type: ClutterBackend
  method backend is rw  {
    my GLib::Value $gv .= new( Clutter::Backend.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('backend', $gv)
        );
        Clutter::Backend.new($gv.object);
      },
      STORE => -> $, ClutterBackend() $val is copy {
        $gv.object = $val;
        self.prop_set('backend', $gv);
      }
    );
  }

  # Type: ClutterDeviceManager
  method device-manager is rw  {
    my GLib::Value $gv .= new( Clutter::DeviceManager.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('device-manager', $gv)
        );
        ::('Clutter::DeviceManager').new(
          cast(ClutterDeviceManager, $gv.object)
        );
      },
      STORE => -> $, ClutterDeviceManager() $val is copy {
        $gv.object = $val;
        self.prop_set('device-manager', $gv);
      }
    );
  }

  # Type: ClutterInputMode
  method device-mode is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('device-mode', $gv)
        );
        ClutterInputMode( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('device-mode', $gv);
      }
    );
  }

  # Type: ClutterInputDeviceType
  method device-type is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('device-type', $gv)
        );
        ClutterInputDeviceType( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('device-type', $gv);
      }
    );
  }

  # Type: gboolean
  method has-cursor is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('has-cursor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-cursor', $gv);
      }
    );
  }

  # Type: gint
  method id is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('id', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: guint
  method n-axes is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('n-axes', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn "n-axes does not allow writing"
      }
    );
  }

  # Type: gchar
  method name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gchar
  method product-id is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('product-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('product-id', $gv);
      }
    );
  }

  # Type: gchar
  method vendor-id is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('vendor-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('vendor-id', $gv);
      }
    );
  }

  method get_associated_device {
    Clutter::InputDevice.new(
      clutter_input_device_get_associated_device($!cid)
    );
  }

  method get_axis (Int() $index) {
    my guint $i = resolve-uint($index);
    ClutterInputAxis( clutter_input_device_get_axis($!cid, $i) );
  }

  multi method get_axis_value {
    my $v = 0;
    my $rc = samewith($v);
    $rc ?? $v !! Nil
  }
  multi method get_axis_value (
    CArray[gdouble] $axes,
    Int() $axis, # ClutterInputAxis $axis,
    Num() $value is rw
  ) {
    my guint $a = resolve-uint($axis);
    my gdouble $v = $value;
    my $rc = so clutter_input_device_get_axis_value($!cid, $axes, $a, $v);
    $value = $v;
    $rc;
  }

  method get_coords (
    ClutterEventSequence() $sequence,
    ClutterPoint() $point
  ) {
    clutter_input_device_get_coords($!cid, $sequence, $point);
  }

  method get_device_id {
    clutter_input_device_get_device_id($!cid);
  }

  method get_device_mode {
    ClutterInputMode( clutter_input_device_get_device_mode($!cid) );
  }

  method get_device_name {
    clutter_input_device_get_device_name($!cid);
  }

  method get_device_type {
    ClutterInputDeviceType( clutter_input_device_get_device_type($!cid) );
  }

  method get_grabbed_actor {
    Clutter::Actor.new( clutter_input_device_get_grabbed_actor($!cid) );
  }

  method get_has_cursor {
    so clutter_input_device_get_has_cursor($!cid);
  }

  method get_key (
    Int() $index,
    Int() $keyval,
    Int() $modifiers # ClutterModifierType $modifiers
  ) {
    my guint ($i, $k, $m) = resolve-int($index, $keyval, $modifiers);
    clutter_input_device_get_key($!cid, $i, $k, $m);
  }

  method get_modifier_state {
    clutter_input_device_get_modifier_state($!cid);
  }

  method get_n_axes {
    clutter_input_device_get_n_axes($!cid);
  }

  method get_n_keys {
    clutter_input_device_get_n_keys($!cid);
  }

  method get_pointer_actor {
    Clutter::Actor.new( clutter_input_device_get_pointer_actor($!cid) );
  }

  method get_pointer_stage {
    Clutter::Stage.new( clutter_input_device_get_pointer_stage($!cid) );
  }

  method get_product_id {
    clutter_input_device_get_product_id($!cid);
  }

  method get_slave_devices (:$raw = False) {
    my $l = GLib::GList.new(
      clutter_input_device_get_slave_devices($!cid)
    ) but GLib::Roles::ListData[ClutterInputDevice];
    $raw ??
      $l.Array !! $l.Array.map({ Clutter::InputDevice.new($_) });
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_input_device_get_type, $n, $t )
  }

  method get_vendor_id {
    clutter_input_device_get_vendor_id($!cid);
  }

  method grab (ClutterActor() $actor) {
    clutter_input_device_grab($!cid, $actor);
  }

  method keycode_to_evdev (Int() $hardware_keycode, Int() $evdev_keycode) {
    my guint ($hk, $ek) = resolve-uint($hardware_keycode, $evdev_keycode);
    clutter_input_device_keycode_to_evdev($!cid, $hk, $ek);
  }

  method sequence_get_grabbed_actor (ClutterEventSequence() $sequence) {
    clutter_input_device_sequence_get_grabbed_actor($!cid, $sequence);
  }

  method sequence_grab (
    ClutterEventSequence() $sequence,
    ClutterActor() $actor
  ) {
    clutter_input_device_sequence_grab($!cid, $sequence, $actor);
  }

  method sequence_ungrab (ClutterEventSequence() $sequence) {
    clutter_input_device_sequence_ungrab($!cid, $sequence);
  }

  method set_key (
    Int() $index,
    Int() $keyval,
    Int() $modifiers # ClutterModifierType $modifiers
  ) {
    my guint ($i, $k, $m) = resolve-int($index, $keyval, $modifiers);
    clutter_input_device_set_key($!cid, $i, $k, $m);
  }

  method ungrab {
    clutter_input_device_ungrab($!cid);
  }

  method update_from_event (ClutterEvent() $event, Int() $update_stage) {
    my gboolean $us = resolve-bool($update_stage);
    clutter_input_device_update_from_event($!cid, $event, $us);
  }

}
