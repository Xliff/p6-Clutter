use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Event;

sub clutter_event_add_filter (
  ClutterStage $stage, 
  &func (ClutterEvent, Pointer --> gboolean), 
  GDestroyNotify $notify, 
  gpointer $user_data
)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_events_pending ()
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_get_current_event ()
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_get_current_event_time ()
  returns guint32
  is native(clutter)
  is export
{ * }

sub clutter_keysym_to_unicode (guint $keyval)
  returns guint32
  is native(clutter)
  is export
{ * }

sub clutter_unicode_to_keysym (guint32 $wc)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_event_copy (ClutterEvent $event)
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_event_free (ClutterEvent $event)
  is native(clutter)
  is export
{ * }

sub clutter_event_get ()
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_event_get_angle (ClutterEvent $source, ClutterEvent $target)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_event_get_axes (ClutterEvent $event, guint $n_axes is rw)
  returns CArray[gdouble]
  is native(clutter)
  is export
{ * }

sub clutter_event_get_click_count (ClutterEvent $event)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_event_get_coords (ClutterEvent $event, gfloat $x, gfloat $y)
  is native(clutter)
  is export
{ * }

sub clutter_event_get_device_id (ClutterEvent $event)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_event_get_device_type (ClutterEvent $event)
  returns guint # ClutterInputDeviceType
  is native(clutter)
  is export
{ * }

sub clutter_event_get_distance (ClutterEvent $source, ClutterEvent $target)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_event_get_event_sequence (ClutterEvent $event)
  returns ClutterEventSequence
  is native(clutter)
  is export
{ * }

sub clutter_event_get_gesture_motion_delta (
  ClutterEvent $event, 
  gdouble $dx is rw, 
  gdouble $dy is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_event_get_gesture_phase (ClutterEvent $event)
  returns guint # ClutterTouchpadGesturePhase
  is native(clutter)
  is export
{ * }

sub clutter_event_get_gesture_pinch_angle_delta (ClutterEvent $event)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_event_get_gesture_pinch_scale (ClutterEvent $event)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_event_get_gesture_swipe_finger_count (ClutterEvent $event)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_event_get_position (ClutterEvent $event, ClutterPoint $position)
  is native(clutter)
  is export
{ * }

sub clutter_event_get_scroll_delta (
  ClutterEvent $event, 
  gdouble $dx is rw, 
  gdouble $dy is rw
)
  is native(clutter)
  is export
{ * }

sub clutter_event_get_state_full (
  ClutterEvent $event, 
  guint $button_state    is rw, # ClutterModifierType
  guint $base_state      is rw, # ClutterModifierType
  guint $latched_state   is rw, # ClutterModifierType
  guint $locked_state    is rw, # ClutterModifierType
  guint $effective_state is rw, # ClutterModifierType
)
  is native(clutter)
  is export
{ * }

sub clutter_event_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_event_has_control_modifier (ClutterEvent $event)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_event_has_shift_modifier (ClutterEvent $event)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_event_is_pointer_emulated (ClutterEvent $event)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_event_new (
  guint $type # ClutterEventType $type
)
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_event_peek ()
  returns ClutterEvent
  is native(clutter)
  is export
{ * }

sub clutter_event_put (ClutterEvent $event)
  is native(clutter)
  is export
{ * }

sub clutter_event_remove_filter (guint $id)
  is native(clutter)
  is export
{ * }

sub clutter_event_sequence_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_event_set_coords (ClutterEvent $event, gfloat $x, gfloat $y)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_scroll_delta (
  ClutterEvent $event, 
  gdouble $dx, 
  gdouble $dy
)
  is native(clutter)
  is export
{ * }

sub clutter_event_type (ClutterEvent $event)
  returns guint # ClutterEventType
  is native(clutter)
  is export
{ * }

sub clutter_event_get_button (ClutterEvent $event)
  returns guint32
  is native(clutter)
  is export
{ * }

sub clutter_event_get_device (ClutterEvent $event)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_event_get_flags (ClutterEvent $event)
  returns guint # ClutterEventFlags
  is native(clutter)
  is export
{ * }

sub clutter_event_get_key_code (ClutterEvent $event)
  returns guint16
  is native(clutter)
  is export
{ * }

sub clutter_event_get_key_symbol (ClutterEvent $event)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_event_get_key_unicode (ClutterEvent $event)
  returns gunichar
  is native(clutter)
  is export
{ * }

sub clutter_event_get_related (ClutterEvent $event)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_event_get_scroll_direction (ClutterEvent $event)
  returns guint # ClutterScrollDirection
  is native(clutter)
  is export
{ * }

sub clutter_event_get_source (ClutterEvent $event)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_event_get_source_device (ClutterEvent $event)
  returns ClutterInputDevice
  is native(clutter)
  is export
{ * }

sub clutter_event_get_stage (ClutterEvent $event)
  returns ClutterStage
  is native(clutter)
  is export
{ * }

sub clutter_event_get_state (ClutterEvent $event)
  returns guint # ClutterModifierType
  is native(clutter)
  is export
{ * }

sub clutter_event_get_time (ClutterEvent $event)
  returns guint32
  is native(clutter)
  is export
{ * }

sub clutter_event_set_button (
  ClutterEvent $event, 
  guint32 $button
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_device (
  ClutterEvent $event, 
  ClutterInputDevice $device
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_flags (
  ClutterEvent $event, 
  guint $flags # ClutterEventFlags $flags
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_key_code (ClutterEvent $event, guint16 $key_code)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_key_symbol (ClutterEvent $event, guint $key_sym)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_key_unicode (ClutterEvent $event, gunichar $key_unicode)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_related (
  ClutterEvent $event, 
  ClutterActor $actor
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_scroll_direction (
  ClutterEvent $event, 
  guint $direction # ClutterScrollDirection $direction
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_source (ClutterEvent $event, ClutterActor $actor)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_source_device (
  ClutterEvent $event, 
  ClutterInputDevice $device
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_stage (ClutterEvent $event, ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_state (
  ClutterEvent $event, 
  guint $state # ClutterModifierType $state
)
  is native(clutter)
  is export
{ * }

sub clutter_event_set_time (ClutterEvent $event, guint32 $time_)
  is native(clutter)
  is export
{ * }
