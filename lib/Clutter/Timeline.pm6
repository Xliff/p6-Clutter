use v6.c;

use Method::Also;


use Clutter::Raw::Types;



use Clutter::Raw::Timeline;

use GLib::Roles::Object;
use GTK::Roles::Protection;
use GTK::Roles::Signals::Generic;

my @attributes = <
  auto_reverse    auto-reverse
  delay
  direction
  duration
  progress_mode   progress-mode
  repeat_count    repeat-count
>;

my @set-methods = <
  cubic_bezier_progress   cubic-bezier-progress
  progress_func           progress-func
  step_progress           step-progress
>;

class Clutter::Timeline {
  also does GLib::Roles::Object;
  also does GTK::Roles::Protection;
  also does GTK::Roles::Signals::Generic;

  has ClutterTimeline $!ctime;

  # needs refinement

  submethod BUILD (:$timeline) {
    self.ADD-PREFIX('Clutter::');
    self.setTimeline($timeline) if $timeline.defined;
  }

  method setTimeline (ClutterTimeline $timeline) {
    self.IS-PROTECTED;
    self!setObject( cast(GObject, $!ctime = $timeline) );
  }

  method Clutter::Raw::Definitions::ClutterTimeline
    is also<ClutterTimeline>
  { $!ctime }

  method new (Int() $msecs) {
    my guint $ms = resolve-uint($msecs);
    self.bless( timeline => clutter_timeline_new($ms) );
  }

  method setup(*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "TlA: {$_}" if $DEBUG;
        self."$_"() = %data{$_}
      }

      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "TlSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} )
      }

      default { die "Unknown attribute '{ $_ }'" }
    }
    self;
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
    self.connect-int($!ctime, 'new-frame');
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

  method add_marker (Str() $marker_name, Num() $progress)
    is also<add-marker>
  {
    my gdouble $p = $progress;
    clutter_timeline_add_marker($!ctime, $marker_name, $p);
  }

  method add_marker_at_time (Str() $marker_name, Int() $msecs)
    is also<add-marker-at-time>
  {
    my guint $ms = resolve-uint($msecs);
    clutter_timeline_add_marker_at_time($!ctime, $marker_name, $msecs);
  }

  method advance (Int() $msecs) {
    my guint $ms = resolve-uint($msecs);
    clutter_timeline_advance($!ctime, $msecs);
  }

  method advance_to_marker (Str() $marker_name) is also<advance-to-marker> {
    clutter_timeline_advance_to_marker($!ctime, $marker_name);
  }

  proto method get_cubic_bezier_progress
    is also<get-cubic-bezier-progress>
  { * }

  multi method get_cubic_bezier_progress (:$raw = False) {
    my ($c1, $c2) = ClutterPoint.new xx 2;
    samewith($c1, $c2, :$raw);
  }
  multi method get_cubic_bezier_progress (
    ClutterPoint() $c_1,
    ClutterPoint() $c_2,
    :$raw = False
  ) {
    clutter_timeline_get_cubic_bezier_progress($!ctime, $c_1, $c_2);
    $raw ??
      (
        $c_1.defined ?? Clutter::Point.new($c_1) !! Nil,
        $c_2.defined ?? Clutter::Point.new($c_2) !! Nil
      )
      !!
      ( $c_1 // Nil, $c_2 // Nil );
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

  proto method get_step_progress (|)
    is also<get-step-progress>
  { * }

  multi method get_step_progress {
    my ($ns, $sm) = (0, 0);
    samewith($ns, $sm);
  }
  multi method get_step_progress ($n_steps is rw, $step_mode is rw) {
    die '$n_steps must be an Int-compabtible value'
      unless $n_steps.^can('Int').elems;
    die '$step_mode must be an Int-compatible value'
      unless $step_mode.^can('Int').elems;
    $_ .= Int for $n_steps, $step_mode;
    my gint $ns = resolve-int($n_steps);
    my guint $sm = resolve-uint($step_mode);
    clutter_timeline_get_step_progress($!ctime, $ns, $sm);
    ($n_steps, $step_mode) = ($ns, $sm);
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

  method list_markers (Int() $msecs, Int() $n_markers) is also<list-markers> {
    my guint $ms = resolve-uint($msecs);
    my gsize $nm = resolve-int64($n_markers);
    clutter_timeline_list_markers($!ctime, $ms, $nm);
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
    &func,
    gpointer       $data   = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<set-progress-func>
  {
    clutter_timeline_set_progress_func($!ctime, &func, $data, $notify);
  }

  method set_step_progress (Int() $n_steps, Int() $step_mode)
    is also<set-step-progress>
  {
    my gint $ns = resolve-int($n_steps);
    my guint $sm = resolve-uint($step_mode);
    clutter_timeline_set_step_progress($!ctime, $ns, $sm);
  }

  method skip (Int() $msecs) {
    my guint $ms = resolve-uint($msecs);
    clutter_timeline_skip($!ctime, $msecs);
  }

  method start {
    clutter_timeline_start($!ctime);
  }

  method stop {
    clutter_timeline_stop($!ctime);
  }

}
