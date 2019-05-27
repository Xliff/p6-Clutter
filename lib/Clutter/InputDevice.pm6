use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Compat::Types;

use GTK::Roles::Properties;

use Clutter::Actor;
use Clutter::Stage;

class Clutter::InputDevice {
  also does GTK::Roles::Properties;
  
  has ClutterInputDevice $!cid;
  
  submethod BUILD (:$device) {
    self!setObject( cast(GObject, $!cid = $device) )
  }
  
  method Clutter::Raw::Types::ClutterInputDevice
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
  
  method get_associated_device {
    ClutterInputDevice.new(
      clutter_input_device_get_associated_device($!cid)
    );
  }

  method get_axis (Int() $index) {
    my guint $i = resolve-uint($index);
    ClutterInputAxis( clutter_input_device_get_axis($!cid, $i) );
  }

  multi method get_axis_value {
    my $v = 0;
    samewith($v);
  }
  multi method get_axis_value (
    CArray[gdouble] $axes, 
    Int() $axis, # ClutterInputAxis $axis, 
    Num() $value is rw
  ) {
    my guint $a = resolve-uint($axis);
    my gdouble $v = $value;
    so clutter_input_device_get_axis_value($!cid, $axes, $a, $v);
    $value = $v;
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
    my $l = GTK::Compat::GList.new( 
      clutter_input_device_get_slave_devices($!cid)
    ) but GTK::Compat::Roles::ListData[ClutterInputDevice];
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
    clutter_input_device_update_from_event($!cid, $event, $u);
  }
  
}
