use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Timeline;

sub clutter_timeline_add_marker (
  ClutterTimeline $timeline, 
  Str $marker_name, 
  gdouble $progress
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_add_marker_at_time (
  ClutterTimeline $timeline, 
  Str $marker_name, 
  guint $msecs
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_advance (ClutterTimeline $timeline, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_advance_to_marker (
  ClutterTimeline $timeline, 
  Str $marker_name
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_cubic_bezier_progress (
  ClutterTimeline $timeline, 
  ClutterPoint $c_1, 
  ClutterPoint $c_2
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_current_repeat (ClutterTimeline $timeline)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_delta (ClutterTimeline $timeline)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_duration_hint (ClutterTimeline $timeline)
  returns gint64
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_elapsed_time (ClutterTimeline $timeline)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_progress (ClutterTimeline $timeline)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_step_progress (
  ClutterTimeline $timeline, 
  gint $n_steps, 
  guint $step_mode # ClutterStepMode $step_mode
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_timeline_has_marker (ClutterTimeline $timeline, Str $marker_name)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_timeline_is_playing (ClutterTimeline $timeline)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_timeline_list_markers (
  ClutterTimeline $timeline, 
  gint $msecs, 
  gsize $n_markers
)
  returns CArray[Str]
  is native(clutter)
  is export
{ * }

sub clutter_timeline_new (guint $msecs)
  returns ClutterTimeline
  is native(clutter)
  is export
{ * }

sub clutter_timeline_pause (ClutterTimeline $timeline)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_remove_marker (
  ClutterTimeline $timeline, 
  Str $marker_name
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_rewind (ClutterTimeline $timeline)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_cubic_bezier_progress (
  ClutterTimeline $timeline, 
  ClutterPoint $c_1, 
  ClutterPoint $c_2
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_progress_func (
  ClutterTimeline $timeline, 
  ClutterTimelineProgressFunc $func, 
  gpointer $data, 
  GDestroyNotify $notify
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_step_progress (
  ClutterTimeline $timeline, 
  gint $n_steps, 
  guint $step_mode # ClutterStepMode $step_mode
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_skip (ClutterTimeline $timeline, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_start (ClutterTimeline $timeline)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_stop (ClutterTimeline $timeline)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_auto_reverse (ClutterTimeline $timeline)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_delay (ClutterTimeline $timeline)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_direction (ClutterTimeline $timeline)
  returns ClutterTimelineDirection
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_duration (ClutterTimeline $timeline)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_progress_mode (ClutterTimeline $timeline)
  returns ClutterAnimationMode
  is native(clutter)
  is export
{ * }

sub clutter_timeline_get_repeat_count (ClutterTimeline $timeline)
  returns gint
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_auto_reverse (
  ClutterTimeline $timeline, 
  gboolean $reverse
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_delay (ClutterTimeline $timeline, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_direction (
  ClutterTimeline $timeline, 
  guint $direction # ClutterTimelineDirection $direction
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_duration (ClutterTimeline $timeline, guint $msecs)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_progress_mode (
  ClutterTimeline $timeline, 
  guint $mode # ClutterAnimationMode $mode
)
  is native(clutter)
  is export
{ * }

sub clutter_timeline_set_repeat_count (ClutterTimeline $timeline, gint $count)
  is native(clutter)
  is export
{ * }
