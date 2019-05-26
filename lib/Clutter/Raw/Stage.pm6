use v6.c;

use NativeCall;

use Cairo;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Stage;

sub clutter_stage_ensure_current (ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_stage_ensure_redraw (ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_stage_ensure_viewport (ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_stage_event (ClutterStage $stage, ClutterEvent $event)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_accept_focus (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_actor_at_pos (
  ClutterStage $stage,
  guint $pick_mode, # ClutterPickMode $pick_mode,
  gint $x,
  gint $y
)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_fullscreen (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_key_focus (ClutterStage $stage)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_minimum_size (
  ClutterStage $stage,
  guint $width,
  guint $height
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_motion_events_enabled (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_no_clear_hint (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_perspective (
  ClutterStage $stage,
  ClutterPerspective $perspective
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_redraw_clip_bounds (
  ClutterStage $stage,
  cairo_rectangle_int_t $clip
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_throttle_motion_events (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_title (ClutterStage $stage)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_use_alpha (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_get_user_resizable (ClutterStage $stage)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_stage_hide_cursor (ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_stage_new ()
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_stage_read_pixels (
  ClutterStage $stage,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_accept_focus (ClutterStage $stage, gboolean $accept_focus)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_fullscreen (ClutterStage $stage, gboolean $fullscreen)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_key_focus (ClutterStage $stage, ClutterActor $actor)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_minimum_size (
  ClutterStage $stage,
  guint $width,
  guint $height
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_motion_events_enabled (
  ClutterStage $stage,
  gboolean $enabled
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_no_clear_hint (ClutterStage $stage, gboolean $no_clear)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_perspective (
  ClutterStage $stage,
  ClutterPerspective $perspective
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_sync_delay (ClutterStage $stage, gint $sync_delay)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_throttle_motion_events (
  ClutterStage $stage,
  gboolean $throttle
)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_title (ClutterStage $stage, Str $title)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_use_alpha (ClutterStage $stage, gboolean $use_alpha)
  is native(clutter)
  is export
{ * }

sub clutter_stage_set_user_resizable (ClutterStage $stage, gboolean $resizable)
  is native(clutter)
  is export
{ * }

sub clutter_stage_show_cursor (ClutterStage $stage)
  is native(clutter)
  is export
{ * }

sub clutter_stage_skip_sync_delay (ClutterStage $stage)
  is native(clutter)
  is export
{ * }
