use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Timeline;

use GTK::Compat::Roles::Object;
use GTK::Roles::Signals::Generic;

class Clutter::Timeline {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;
  
  has ClutterTimeline $!ctime;
  
  submethod BUILD (:$timeline) {
    self!setObject( cast(GObject, $!ctime = $timeline) );
  }
  
  method Clutter::Raw::Types::ClutterTimeline
    is also<ClutterTimeline>
  { $!ctime }
  
  method new (Int() $msecs) {
    my guint $ms = resolve-uint($msecs);
    self.bless( timeline => clutter_timeline_new($ms) );
  }
  
  method auto_reverse is rw is also<auto-reverse> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_timeline_get_auto_reverse($!ctime);
      },
      STORE => sub ($, Int() $reverse is copy) {
        my gboolean $r = resolve-bool($reverse);
        clutter_timeline_set_auto_reverse($!ctime, $r);
      }
    );
  }

  method delay is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_timeline_get_delay($!ctime);
      },
      STORE => sub ($, Int() $msecs is copy) {
        my guint $ms = resolve-uint($msecs);
        clutter_timeline_set_delay($!ctime, $ms);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        ClutterTimelineDirection( clutter_timeline_get_direction($!ctime) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = resolve-uint($direction);
        clutter_timeline_set_direction($!ctime, $d);
      }
    );
  }

  method duration is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_timeline_get_duration($!ctime);
      },
      STORE => sub ($, Int() $msecs is copy) {
        my guint $ms = resolve-uint($msecs);
        clutter_timeline_set_duration($!ctime, $ms);
      }
    );
  }

  method progress_mode is rw is also<progress-mode> {
    Proxy.new(
      FETCH => sub ($) {
        ClutterAnimationMode( clutter_timeline_get_progress_mode($!ctime) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = resolve-uint($mode);
        clutter_timeline_set_progress_mode($!ctime, $m);
      }
    );
  }

  method repeat_count is rw is also<repeat-count> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_timeline_get_repeat_count($!ctime);
      },
      STORE => sub ($, Int() $count is copy) {
        my gint $c = resolve-int($count);
        clutter_timeline_set_repeat_count($!ctime, $c);
      }
    );
  }
  
    # Is originally:
  # ClutterTimeline, gpointer --> void
  method completed {
    self.connect($!ctime, 'completed');
  }

  # Is originally:
  # ClutterTimeline, Str, gint, gpointer -> void
  method marker-reached is also<marker_reached> {
    self.connect-strint($!ctime, 'marker-reached');
  }

  # Is originally:
  # ClutterTimeline, gint, gpointer --> void
  method new-frame is also<new_frame> {
    self.connect-int($!ctime);
  }

  # Is originally:
  # ClutterTimeline, gpointer --> void
  method paused {
    self.connect($!ctime, 'paused');
  }

  # Is originally:
  # ClutterTimeline, gpointer --> void
  method started {
    self.connect($!ctime, 'started');
  }

  # Is originally:
  # ClutterTimeline, gboolean, gpointer --> void
  method stopped {
    self.connect-bool($!ctime, 'stopped');
  }
  
  method add_marker (Str() $marker_name, gdouble $progress) 
    is also<add-marker> 
  {
    clutter_timeline_add_marker($!ctime, $marker_name, $progress);
  }

  method add_marker_at_time (Str() $marker_name, guint $msecs) 
    is also<add-marker-at-time> 
  {
    clutter_timeline_add_marker_at_time($!ctime, $marker_name, $msecs);
  }

  method advance (guint $msecs) {
    clutter_timeline_advance($!ctime, $msecs);
  }

  method advance_to_marker (Str() $marker_name) is also<advance-to-marker> {
    clutter_timeline_advance_to_marker($!ctime, $marker_name);
  }

  proto method get_cubic_bezier_progress 
    is also<get-cubic-bezier-progress>
  { * }
  
  multi method get_cubic_bezier_progress {
    my ($c1, $c2) = ClutterPoint.new xx 2;
    samewith($c1, $c2);
  }
  multi method get_cubic_bezier_progress (
    ClutterPoint() $c_1, 
    ClutterPoint() $c_2
  ) {
    clutter_timeline_get_cubic_bezier_progress($!ctime, $c_1, $c_2);
    ( Clutter::Point.new($c_1), Clutter::Point.new($c_2) );
  }

  method get_current_repeat is also<get-current-repeat> {
    clutter_timeline_get_current_repeat($!ctime);
  }

  method get_delta is also<get-delta> {
    clutter_timeline_get_delta($!ctime);
  }

  method get_duration_hint is also<get-duration-hint> {
    clutter_timeline_get_duration_hint($!ctime);
  }

  method get_elapsed_time is also<get-elapsed-time> {
    clutter_timeline_get_elapsed_time($!ctime);
  }

  method get_progress is also<get-progress> {
    clutter_timeline_get_progress($!ctime);
  }

  method get_step_progress (gint $n_steps, ClutterStepMode $step_mode) 
    is also<get-step-progress> 
  {
    clutter_timeline_get_step_progress($!ctime, $n_steps, $step_mode);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_timeline_get_type, $n, $t );
  }

  method has_marker (Str $marker_name) is also<has-marker> {
    clutter_timeline_has_marker($!ctime, $marker_name);
  }

  method is_playing is also<is-playing> {
    clutter_timeline_is_playing($!ctime);
  }

  method list_markers (gint $msecs, gsize $n_markers) is also<list-markers> {
    clutter_timeline_list_markers($!ctime, $msecs, $n_markers);
  }

  method pause {
    clutter_timeline_pause($!ctime);
  }

  method remove_marker (Str() $marker_name) is also<remove-marker> {
    clutter_timeline_remove_marker($!ctime, $marker_name);
  }

  method rewind {
    clutter_timeline_rewind($!ctime);
  }

  method set_cubic_bezier_progress (
    ClutterPoint() $c_1, 
    ClutterPoint() $c_2
  ) 
    is also<set-cubic-bezier-progress> 
  {
    clutter_timeline_set_cubic_bezier_progress($!ctime, $c_1, $c_2);
  }

  method set_progress_func (
    ClutterTimelineProgressFunc $func, 
    gpointer $data, 
    GDestroyNotify $notify
  ) 
    is also<set-progress-func> 
  {
    clutter_timeline_set_progress_func($!ctime, $func, $data, $notify);
  }

  method set_step_progress (gint $n_steps, ClutterStepMode $step_mode) 
    is also<set-step-progress> 
  {
    clutter_timeline_set_step_progress($!ctime, $n_steps, $step_mode);
  }

  method skip (guint $msecs) {
    clutter_timeline_skip($!ctime, $msecs);
  }

  method start {
    clutter_timeline_start($!ctime);
  }

  method stop {
    clutter_timeline_stop($!ctime);
  }
  
}
  
