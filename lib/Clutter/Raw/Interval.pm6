use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::Interval;

sub clutter_interval_clone (ClutterInterval $interval)
  returns ClutterInterval
  is native(clutter)
  is export
{ * }

sub clutter_interval_compute (ClutterInterval $interval, gdouble $factor)
  returns GValue
  is native(clutter)
  is export
{ * }

sub clutter_interval_compute_value (
  ClutterInterval $interval,
  gdouble $factor,
  GValue $value
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_interval_get_final_value (ClutterInterval $interval, GValue $value)
  is native(clutter)
  is export
{ * }

sub clutter_interval_get_initial_value (
  ClutterInterval $interval,
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_interval_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_interval_get_value_type (ClutterInterval $interval)
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_interval_is_valid (ClutterInterval $interval)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_interval_new_with_values (
  GType $gtype,
  GValue $initial,
  GValue $final
)
  returns ClutterInterval
  is native(clutter)
  is export
{ * }

sub clutter_interval_peek_final_value (ClutterInterval $interval)
  returns GValue
  is native(clutter)
  is export
{ * }

sub clutter_interval_peek_initial_value (ClutterInterval $interval)
  returns GValue
  is native(clutter)
  is export
{ * }

sub clutter_interval_set_final_value (ClutterInterval $interval, GValue $value)
  is native(clutter)
  is export
{ * }

sub clutter_interval_set_initial_value (
  ClutterInterval $interval,
  GValue $value
)
  is native(clutter)
  is export
{ * }

sub clutter_interval_validate (ClutterInterval $interval, GParamSpec $pspec)
  returns uint32
  is native(clutter)
  is export
{ * }
