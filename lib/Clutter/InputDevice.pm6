use v6.c;

use Method::Also;

use NativeCall;

use Clutter::Raw::Types;
use Clutter::Raw::InputDevice;

use GLib::Value;
use Clutter::Actor;
use Clutter::Stage;

use GLib::Roles::Object;

class Clutter::InputDevice {
  also does GLib::Roles::Object;

  has ClutterInputDevice $!cid;

  submethod BUILD (:$device) {
    self!setObject( cast(GObject, $!cid = $device) )
  }

  method Clutter::Raw::Definitions::ClutterInputDevice
    is also<ClutterInputDevice>
  { $!cid }

  method new (ClutterInputDevice $device) {
    $device ?? self.bless(:$device) !! Nil;
  }

  method enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_input_device_get_enabled($!cid);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my gboolean $e = $enabled.so.Int;

        clutter_input_device_set_enabled($!cid, $e);
      }
    );
  }

  # Type: ClutterBackend
  method backend is rw  {
    my GLib::Value $gv .= new( Clutter::Backend.get_type );
    Proxy.new(
      FETCH => sub ($) {
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
  method device-manager (:$raw = False) is rw  is also<device_manager> {
    my GLib::Value $gv .= new( Clutter::DeviceManager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('device-manager', $gv)
        );

        return Nil unless $gv.object;

        my $d = cast(ClutterDeviceManager, $gv.object);

        $raw ?? $d !! ::('Clutter::DeviceManager').new($d);
      },
      STORE => -> $, ClutterDeviceManager() $val is copy {
        $gv.object = $val;
        self.prop_set('device-manager', $gv);
      }
    );
  }

  # Type: ClutterInputMode
  method device-mode is rw  is also<device_mode> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('device-mode', $gv)
        );
        ClutterInputModeEnum( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('device-mode', $gv);
      }
    );
  }

  # Type: ClutterInputDeviceType
  method device-type is rw  is also<device_type> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('device-type', $gv)
        );
        ClutterInputDeviceTypeEnum( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('device-type', $gv);
      }
    );
  }

  # Type: gboolean
  method has-cursor is rw  is also<has_cursor> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
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
      FETCH => sub ($) {
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
  method n-axes is rw  is also<n_axes> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('n-axes', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-axes does not allow writing';
      }
    );
  }

  # Type: gchar
  method name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method product-id is rw  is also<product_id> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method vendor-id is rw  is also<vendor_id> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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

  method get_associated_device (:$raw = False)
    is also<get-associated-device>
  {
    my $d = clutter_input_device_get_associated_device($!cid);

    $d ??
      ( $raw ?? $d !! Clutter::InputDevice.new($d) )
      !!
      Nil;
  }

  method get_axis (Int() $index) is also<get-axis> {
    my guint $i = $index;

    ClutterInputAxisEnum( clutter_input_device_get_axis($!cid, $i) );
  }

  proto method get_axis_value (|)
    is also<get-axis-value>
  { * }

  multi method get_axis_value (@axes, $axis) {
    samewith( ArrayToCArray(gdouble, @axes), $axis );
  }
  multi method get_axis_value (CArray[gdouble] $axes, Int() $axis) {
    my $v;
    my $rc = samewith($axes, $axis, $v);

    $rc ?? $v !! False
  }
  multi method get_axis_value (
    CArray[gdouble] $axes,
    Int() $axis,
    $value is rw
  ) {
    my ClutterInputAxis $a = $axis;
    my gdouble $v = 0e0;

    my $rc = so clutter_input_device_get_axis_value($!cid, $axes, $a, $v);
    $value = $v;
    $rc;
  }

  method get_coords (
    ClutterEventSequence() $sequence,
    ClutterPoint() $point
  )
    is also<get-coords>
  {
    clutter_input_device_get_coords($!cid, $sequence, $point);
  }

  method get_device_id is also<get-device-id> {
    clutter_input_device_get_device_id($!cid);
  }

  method get_device_mode is also<get-device-mode> {
    ClutterInputMode( clutter_input_device_get_device_mode($!cid) );
  }

  method get_device_name is also<get-device-name> {
    clutter_input_device_get_device_name($!cid);
  }

  method get_device_type is also<get-device-type> {
    ClutterInputDeviceTypeEnum( clutter_input_device_get_device_type($!cid) );
  }

  method get_grabbed_actor (:$raw = False) is also<get-grabbed-actor> {
    my $a = clutter_input_device_get_grabbed_actor($!cid);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil;
  }

  method get_has_cursor is also<get-has-cursor> {
    so clutter_input_device_get_has_cursor($!cid);
  }

  proto method get_key (|)
      is also<get-key>
  { * }

  multi method get_key (Int() $index) {
    samewith($index, $, $);
  }
  multi method get_key (
    Int() $index,
    $keyval    is rw,
    $modifiers is rw # ClutterModifierType $modifiers
  ) {
    my guint ($i, $k, $m) = ($index, 0, 0);

    clutter_input_device_get_key($!cid, $i, $k, $m);
    ($keyval, $modifiers) = ( $k, ClutterModifierTypeEnum($m) )
  }

  method get_modifier_state is also<get-modifier-state> {
    ClutterModifierTypeEnum( clutter_input_device_get_modifier_state($!cid) );
  }

  method get_n_axes is also<get-n-axes> {
    clutter_input_device_get_n_axes($!cid);
  }

  method get_n_keys is also<get-n-keys> {
    clutter_input_device_get_n_keys($!cid);
  }

  method get_pointer_actor (:$raw = False) is also<get-pointer-actor> {
    my $a = clutter_input_device_get_pointer_actor($!cid);

    $a ??
      ( $raw ?? $a !! Clutter::Actor.new($a) )
      !!
      Nil
  }

  method get_pointer_stage (:$raw = False) is also<get-pointer-stage> {
    my $s = clutter_input_device_get_pointer_stage($!cid);

    $s ??
      ( $raw ?? $s !! Clutter::Stage.new($s) )
      !!
      Nil;
  }

  method get_product_id is also<get-product-id> {
    clutter_input_device_get_product_id($!cid);
  }

  method get_slave_devices (:$glist = False, :$raw = False)
    is also<get-slave-devices>
  {
    my $l = clutter_input_device_get_slave_devices($!cid);

    return Nil unless $l;
    return $l  if $glist;

    $l = GLib::GList.new($l) but GLib::Roles::ListData[ClutterInputDevice];
    $raw ?? $l.Array !! $l.Array.map({ Clutter::InputDevice.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_input_device_get_type, $n, $t )
  }

  method get_vendor_id is also<get-vendor-id> {
    clutter_input_device_get_vendor_id($!cid);
  }

  method grab (ClutterActor() $actor) {
    clutter_input_device_grab($!cid, $actor);
  }

  proto method keycode_to_evdev (|)
    is also<keycode-to-evdev>
  { * }

  multi method keycode_to_evdev (Int() $hardware_keycode) {
    my $ekc;
    my $rv = samewith($hardware_keycode, $ekc);

    $rv ?? $ekc !! False;
  }
  multi method keycode_to_evdev (Int() $hardware_keycode, $evdev_keycode is rw) {
    my guint ($hk, $ek) = ($hardware_keycode, 0);

    my $rv = clutter_input_device_keycode_to_evdev($!cid, $hk, $ek);
    $evdev_keycode = $ek;
    $rv
  }

  method sequence_get_grabbed_actor (ClutterEventSequence() $sequence) is also<sequence-get-grabbed-actor> {
    clutter_input_device_sequence_get_grabbed_actor($!cid, $sequence);
  }

  method sequence_grab (
    ClutterEventSequence() $sequence,
    ClutterActor() $actor
  )
    is also<sequence-grab>
  {
    clutter_input_device_sequence_grab($!cid, $sequence, $actor);
  }

  method sequence_ungrab (ClutterEventSequence() $sequence) is also<sequence-ungrab> {
    clutter_input_device_sequence_ungrab($!cid, $sequence);
  }

  method set_key (
    Int() $index,
    Int() $keyval,
    Int() $modifiers # ClutterModifierType $modifiers
  )
    is also<set-key>
  {
    my guint ($i, $k, $m) = ($index, $keyval, $modifiers);

    clutter_input_device_set_key($!cid, $i, $k, $m);
  }

  method ungrab {
    clutter_input_device_ungrab($!cid);
  }

  method update_from_event (ClutterEvent() $event, Int() $update_stage)
    is also<update-from-event>
  {
    my gboolean $us = $update_stage.so.Int;

    clutter_input_device_update_from_event($!cid, $event, $us);
  }

}
