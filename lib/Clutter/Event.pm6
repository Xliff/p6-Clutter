use v6.c;

use Method::Also;

use Clutter::Raw::Types;
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

  method Clutter::Raw::Definitions::ClutterEvent
    is also<ClutterEvent>
  { $!ce }

  # Singular event
  multi method new (ClutterEvents $event_pointer) {
    my $event = cast(ClutterEvent, $event_pointer);

    $event ?? self.bless(:$event) !! Nil;
  }
  # Union of all event types
  multi method new (ClutterEvent $event) {
    $event ?? self.bless(:$event) !! Nil;
  }
  # Generic constructor, singular.
  multi method new (Int() $type) {
    my guint $t = $type;
    my $event = clutter_event_new($t);

    $event ?? self.bless(:$event) !! Nil;
  }

  method button is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_button($!ce);
      },
      STORE => sub ($, Int() $button is copy) {
        my guint $b = $button;

        clutter_event_set_button($!ce, $b);
      }
    );
  }

  method device (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $d = clutter_event_get_device($!ce);

        $d ??
          ( $raw ?? $d !! Clutter::InputDevice.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterInputDevice() $device is copy) {
        clutter_event_set_device($!ce, $device);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterEventFlagsEnum( clutter_event_get_flags($!ce) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my ClutterEventFlags $f = $flags;

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
        my guint16 $k = $key_code;

        clutter_event_set_key_code($!ce, $k);
      }
    );
  }

  method key_symbol is rw is also<key-symbol> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_key_symbol($!ce);
      },
      STORE => sub ($, Int() $key_sym is copy) {
        my guint $k = $key_sym;

        clutter_event_set_key_symbol($!ce, $k);
      }
    );
  }

  method key_unicode is rw is also<key-unicode> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_key_unicode($!ce);
      },
      STORE => sub ($, Int() $key_unicode is copy) {
        my gunichar $k = $key_unicode;

        clutter_event_set_key_unicode($!ce, $k);
      }
    );
  }

  method related (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = clutter_event_get_related($!ce);

        $a ??
          ( $raw ?? $a !! Clutter::Actor.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterActor() $actor is copy) {
        clutter_event_set_related($!ce, $actor);
      }
    );
  }

  method scroll_direction is rw is also<scroll-direction> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterScrollDirectionEnum( clutter_event_get_scroll_direction($!ce) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = $direction;

        clutter_event_set_scroll_direction($!ce, $d);
      }
    );
  }

  method source (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = clutter_event_get_source($!ce);

        $a ??
          ( $raw ?? $a !! Clutter::Actor.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterActor() $actor is copy) {
        clutter_event_set_source($!ce, $actor);
      }
    );
  }

  method source_device (:$raw = False) is rw is also<source-device> {
    Proxy.new(
      FETCH => sub ($) {
        my $sd = clutter_event_get_source_device($!ce);

        $sd ??
          ( $raw ?? $sd !! Clutter::InputDevice.new($sd) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterInputDevice() $device is copy) {
        clutter_event_set_source_device($!ce, $device);
      }
    );
  }

  method stage (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $s = clutter_event_get_stage($!ce);

        $s ??
          ( $raw ?? $s !! Clutter::Stage.new($s) )
          !!
          Nil;
      },
      STORE => sub ($, ClutterStage() $stage is copy) {
        clutter_event_set_stage($!ce, $stage);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterModifierTypeEnum( clutter_event_get_state($!ce) );
      },
      STORE => sub ($, Int() $state is copy) {
        my guint $s = $state;

        clutter_event_set_state($!ce, $s);
      }
    );
  }

  method time is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_event_get_time($!ce);
      },
      STORE => sub ($, Int() $time is copy) {
        my guint $t = $time;

        clutter_event_set_time($!ce, $t);
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

  method pending (Clutter::Event:U:)
    is also<
      get-pending
      get_pending
    >
  {
    so clutter_events_pending();
  }

  method get_current_event (Clutter::Event:U: :$raw = False)
    is also<
      get-current-event
      get_current
      get-current
      current
    >
  {
    my $e = clutter_get_current_event();

    $e ??
      ( $raw ?? $e !! Clutter::Event.new($e) )
      !!
      Nil;
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

  method copy (:$raw = False) {
    my $ec = clutter_event_copy($!ce);

    $ec ??
      ( $raw ?? $ec !! Clutter::Event.new($ec) )
      !!
      Nil;
  }

  method !free {
    clutter_event_free($!ce);
  }

  method get (Clutter::Event:U: :$raw = False) {
    my $e = clutter_event_get();

    $e ??
      ( $raw ?? $e !! Clutter::Event.new($e) )
      !!
      Nil;
  }

  method get_angle (ClutterEvent() $target) is also<get-angle> {
    clutter_event_get_angle($!ce, $target);
  }

  proto method get_axes (|)
    is also<get-axes>
  { * }

  multi method get_axes is also<axes> {
    samewith($);
  }
  multi method get_axes (Int() $n_axes is rw) {
    my guint $na = 0;
    my $ar = clutter_event_get_axes($!ce, $na);
    $n_axes = $na;

    CArrayToArray($ar, $n_axes);
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
    # Ensure coercion does not occur.
    samewith($, $);
  }
  multi method get_coords ($x is rw, $y is rw) {
    my gfloat ($xx, $yy) = 0e0 xx 2;

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
    ClutterInputDeviceTypeEnum( clutter_event_get_device_type($!ce) );
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

  proto method get_gesture_motion_delta (|)
    is also<get-gesture-motion-delta>
  { * }

  multi method get_gesture_motion_delta {
    samewith($, $);
  }
  multi method get_gesture_motion_delta ($dx is rw, $dy is rw) {
    my gdouble ($ddx, $ddy) = 0e0 xx 2;

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
    ClutterTouchpadGesturePhaseEnum( clutter_event_get_gesture_phase($!ce) );
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

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    my $p = ClutterPoint.new;

    die 'Could not allocate ClutterPoint!' unless $p;

    samewith($p);
    $p;
  }
  multi method get_position (ClutterPoint() $position) {
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
    samewith($, $);
  }
  multi method get_scroll_delta ($dx is rw, $dy is rw) {
    my gdouble ($ddx, $ddy) = 0e0 xx 2;

    clutter_event_get_scroll_delta($!ce, $ddx, $ddy);
    ($dx, $dy) = ($ddx, $ddy);
  }

  proto method get_state_full (|)
    is also<get-state-full>
  { * }

  multi method get_state_full {
    samewith($, $, $, $, $);
  }
  multi method get_state_full (
    Int() $button_state    is rw, # ClutterModifierType
    Int() $base_state      is rw, # ClutterModifierType
    Int() $latched_state   is rw, # ClutterModifierType
    Int() $locked_state    is rw, # ClutterModifierType
    Int() $effective_state is rw  # ClutterModifierType
  ) {
    my guint ($btn, $base, $lat, $lck, $eff) = 0 xx 5;

    clutter_event_get_state_full($!ce, $btn, $base, $lat, $lck, $eff);
    (
      $button_state,
      $base_state,
      $latched_state,
      $locked_state,
      $effective_state
    ) = (
      ClutterModifierType($btn),
      ClutterModifierType($base),
      ClutterModifierType($lat),
      ClutterModifierType($lck),
      ClutterModifierType($eff)
    );
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

  method peek (Clutter::Event:U: :$raw = False) {
    my $e = clutter_event_peek();

    $e ??
      ( $raw ?? $e !! Clutter::Event.new($e) )
      !!
      Nil;
  }

  method put (Clutter::Event:U: ClutterEvent() $event) {
    clutter_event_put($event);
  }

  method remove_filter is also<remove-filter> {
    clutter_event_remove_filter($!ce);
  }

  method sequence_get_type is also<sequence-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_event_sequence_get_type, $n, $t );
  }

  method set_coords (Num() $x, Num() $y) is also<set-coords> {
    my gfloat ($xx, $yy) = ($x, $y);

    clutter_event_set_coords($!ce, $xx, $yy);
  }

  method set_scroll_delta (Num() $dx, Num() $dy) is also<set-scroll-delta> {
    my gdouble ($ddx, $ddy) = ($dx, $dy);

    clutter_event_set_scroll_delta($!ce, $ddx, $ddy);
  }

  # Using .type as an alias for the next method is too close to .get-type, so
  # to prevent confusion, we are only using the wordier options.
  method get_event_type
    is also<
      get-event-type
      event_type
      event-type
    >
  {
    ClutterEventTypeEnum( clutter_event_type($!ce) );
  }

}
