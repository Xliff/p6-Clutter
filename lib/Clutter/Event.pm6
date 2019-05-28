use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Event;

# Boxed

use Clutter::Actor;
use Clutter::InputDevice;
use Clutter::Stage;

class Clutter::Event {
  has ClutterEvent $!ce;
  
  submethod BUILD (:$event) {
    $!ce = $event;
  }
  
  method Clutter::Raw::Types::ClutterEvent
  { $!ce }
  
  multi method new (ClutterEvents $event_pointer) {
    self.bless( event => cast(ClutterEvent, $event_pointer) );
  }
  multi method new (ClutterEvent $event) {
    self.bless(:$event);
  }
  multi method new (Int() $type) {
    my guint $t = resolve-uint($type);
    self.bless( event => clutter_event_new($t) );
  }
  
  method button is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_button($!ce);
      },
      STORE => sub ($, $button is copy) {
        clutter_event_set_button($!ce, $button);
      }
    );
  }

  method device is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::InputDevice.new( clutter_event_get_device($!ce) );
      },
      STORE => sub ($, ClutterInputDevice() $device is copy) {
        clutter_event_set_device($!ce, $device);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterEventFlags( clutter_event_get_flags($!ce) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my guint $f = resolve-uint($flags);
        clutter_event_set_flags($!ce, $f);
      }
    );
  }

  method key_code is rw is also<key-code> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_key_code($!ce);
      },
      STORE => sub ($, $key_code is copy) {
        clutter_event_set_key_code($!ce, $key_code);
      }
    );
  }

  method key_symbol is rw is also<key-symbol> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_key_symbol($!ce);
      },
      STORE => sub ($, $key_sym is copy) {
        clutter_event_set_key_symbol($!ce, $key_sym);
      }
    );
  }

  method key_unicode is rw is also<key-unicode> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_key_unicode($!ce);
      },
      STORE => sub ($, $key_unicode is copy) {
        clutter_event_set_key_unicode($!ce, $key_unicode);
      }
    );
  }

  method related is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Actor.new( clutter_event_get_related($!ce) );
      },
      STORE => sub ($, ClutterActor() $actor is copy) {
        clutter_event_set_related($!ce, $actor);
      }
    );
  }

  method scroll_direction is rw is also<scroll-direction> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterScrollDirection( clutter_event_get_scroll_direction($!ce) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = resolve-uint($direction);
        clutter_event_set_scroll_direction($!ce, $d);
      }
    );
  }

  method source is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Actor.new( clutter_event_get_source($!ce) );
      },
      STORE => sub ($, ClutterActor() $actor is copy) {
        clutter_event_set_source($!ce, $actor);
      }
    );
  }

  method source_device is rw is also<source-device> {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::InputDevice.new( clutter_event_get_source_device($!ce) );
      },
      STORE => sub ($, ClutterInputDevice() $device is copy) {
        clutter_event_set_source_device($!ce, $device);
      }
    );
  }

  method stage is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Stage.new( clutter_event_get_stage($!ce) );
      },
      STORE => sub ($, ClutterStage() $stage is copy) {
        clutter_event_set_stage($!ce, $stage);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterModifierType( clutter_event_get_state($!ce) );
      },
      STORE => sub ($, Int() $state is copy) {
        my guint $s = resolve-uint($state);
        clutter_event_set_state($!ce, $s);
      }
    );
  }

  method time is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_time($!ce);
      },
      STORE => sub ($, $time_ is copy) {
        clutter_event_set_time($!ce, $time_);
      }
    );
  }
  
  method add_filter (
    Clutter::Event:U:
    ClutterStage() $stage,
    &func, 
    GDestroyNotify $notify = gpointer, 
    gpointer $user_data    = gpointer
  ) 
    is also<add-filter> 
  {
    clutter_event_add_filter($stage, &func, $notify, $user_data);
  }

  method get_pending (Clutter::Event:U:) 
    is also<
      get-pending
      pending
    > 
  {
    clutter_events_pending();
  }

  method get_current_event (Clutter::Event:U:) 
    is also<
      get-current-event
      get_current
      get-current
      current
    > 
  {
    clutter_get_current_event();
  }

  method get_current_event_time (Clutter::Event:U:) 
    is also<
      get-current-event-time
      current_event_time
      current-event-time
    > 
  {
    clutter_get_current_event_time();
  }

  method copy {
    Clutter::Event.new( clutter_event_copy($!ce) );
  }

  method !free {
    clutter_event_free($!ce);
  }

  method get {
    clutter_event_get();
  }

  method get_angle (ClutterEvent() $target) is also<get-angle> {
    clutter_event_get_angle($!ce, $target);
  }

  proto method get_axes (|)
    is also<get-axes>
  { * }
  
  multi method get_axes is also<axes> {
    my $na = 0;
    samewith($na);
  }
  multi method get_axes (Int() $n_axes is rw) {
    my guint $na = 0;
    my $ar = clutter_event_get_axes($!ce, $na);
    $n_axes = $na;
    
    my @a;
    @a[$_] = $ar[$_] for ^$na;
    @a.unshift: $na;
    @a;
  }

  method get_click_count 
    is also<
      get-click-count
      click_count
      click-count
    > 
  {
    clutter_event_get_click_count($!ce);
  }

  proto method get_coords (|)
    is also<get-coords>
  { * }
  
  multi method get_coords is also<coords> {
    my ($x, $y) = (0, 0);
    samewith($x, $y);
  }
  multi method get_coords (Num() $x is rw, Num() $y is rw) {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_event_get_coords($!ce, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_device_id 
    is also<
      get-device-id
      device_id
      device-id
    > 
  {
    clutter_event_get_device_id($!ce);
  }

  method get_device_type 
    is also<
      get-device-type
      device_type
      device-type
    > 
  {
    ClutterInputDeviceType( clutter_event_get_device_type($!ce) );
  }

  method get_distance (ClutterEvent() $target) is also<get-distance> {
    clutter_event_get_distance($!ce, $target);
  }

  method get_event_sequence 
    is also<
      get-event-sequence
      event_sequence
      event-sequence
    >
  {
    clutter_event_get_event_sequence($!ce);
  }

  method get_gesture_motion_delta (Num() $dx is rw, Num() $dy is rw) 
    is also<get-gesture-motion-delta> 
  {
    my gdouble ($ddx, $ddy) = ($dx, $dy);
    clutter_event_get_gesture_motion_delta($!ce, $ddx, $ddy);
    ($dx, $dy) = ($ddx, $ddy);
  }

  method get_gesture_phase 
    is also<
      get-gesture-phase
      gesture_phase
      gesture-phase
    > 
  {
    clutter_event_get_gesture_phase($!ce);
  }

  method get_gesture_pinch_angle_delta 
    is also<get-gesture-pinch-angle-delta> 
  {
    clutter_event_get_gesture_pinch_angle_delta($!ce);
  }

  method get_gesture_pinch_scale is also<get-gesture-pinch-scale> {
    clutter_event_get_gesture_pinch_scale($!ce);
  }

  method get_gesture_swipe_finger_count 
    is also<get-gesture-swipe-finger-count> 
  {
    clutter_event_get_gesture_swipe_finger_count($!ce);
  }

  method get_position (ClutterPoint() $position) is also<get-position> {
    clutter_event_get_position($!ce, $position);
  }

  proto method get_scroll_delta (|) 
    is also<get-scroll-delta> 
  { * }
  
  multi method get_scroll_delta 
    is also<
      scroll_delta
      scroll-delta
    > 
  {
    my ($dx, $dy) = (0, 0);
    samewith($dx, $dy);
  }
  multi method get_scroll_delta (Num() $dx is rw, Num() $dy is rw) {
    my gdouble ($ddx, $ddy) = ($dx, $dy);
    clutter_event_get_scroll_delta($!ce, $ddx, $ddy);
    ($dx, $dy) = ($ddx, $ddy);
  }

  proto method get_state_full (|)
    is also<get-state-full>
  { * }

  multi method get_state_full {
    my ($btn, $base, $lat, $lck, $eff) = 0 xx 5;
    samewith($btn, $base, $lat, $lck, $eff);
    (
      ClutterModifierType($btn),
      ClutterModifierType($base),
      ClutterModifierType($lat),
      ClutterModifierType($lck),
      ClutterModifierType($eff)
    );
  }
  multi method get_state_full (
    Int() $button_state    is rw, # ClutterModifierType
    Int() $base_state      is rw, # ClutterModifierType
    Int() $latched_state   is rw, # ClutterModifierType
    Int() $locked_state    is rw, # ClutterModifierType
    Int() $effective_state is rw  # ClutterModifierType
  ) {
    my guint ($btn, $base, $lat, $lck, $eff) = resolve-uint(
      $button_state,   
      $base_state, 
      $latched_state, 
      $locked_state, 
      $effective_state
    );
    clutter_event_get_state_full($!ce, $btn, $base, $lat, $lck, $eff);
    (
      $button_state,   
      $base_state, 
      $latched_state, 
      $locked_state, 
      $effective_state
    ) = ($btn, $base, $lat, $lck, $eff);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_event_get_type, $n, $t );
  }

  method has_control_modifier is also<has-control-modifier> {
    so clutter_event_has_control_modifier($!ce);
  }

  method has_shift_modifier is also<has-shift-modifier> {
    so clutter_event_has_shift_modifier($!ce);
  }

  method is_pointer_emulated is also<is-pointer-emulated> {
    so clutter_event_is_pointer_emulated($!ce);
  }

  method peek {
    clutter_event_peek();
  }

  method put {
    clutter_event_put($!ce);
  }

  method remove_filter is also<remove-filter> {
    clutter_event_remove_filter($!ce);
  }

  method sequence_get_type is also<sequence-get-type> {
    clutter_event_sequence_get_type();
  }

  method set_coords (Num() $x, Num() $y) is also<set-coords> {
    my gfloat ($xx, $yy) = ($x, $y);
    clutter_event_set_coords($!ce, $xx, $yy);
  }

  method set_scroll_delta (Num() $dx, Num() $dy) is also<set-scroll-delta> {
    my gdouble ($ddx, $ddy) = ($dx, $dy);
    clutter_event_set_scroll_delta($!ce, $ddx, $ddy);
  }

  method type {
    ClutterEventType( clutter_event_type($!ce) );
  }

}
