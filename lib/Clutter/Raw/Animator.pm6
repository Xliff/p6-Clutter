use v6.c;

use GLib::Raw::Definitions;
use Clutter::Raw::Definitions;

unit package Clutter::Raw::Animator;

### /usr/include/clutter-1.0/clutter/deprecated/clutter-animator.h

sub clutter_animator_compute_value (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name,
  gdouble         $progress,
  GValue          $value
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_animator_get_duration (ClutterAnimator $animator)
  returns guint
  is native(clutter)
  is export
{ * }

sub clutter_animator_get_keys (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name,
  gdouble         $progress
)
  returns GList
  is native(clutter)
  is export
{ * }

sub clutter_animator_get_timeline (ClutterAnimator $animator)
  returns ClutterTimeline
  is native(clutter)
  is export
{ * }

sub clutter_animator_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_mode (ClutterAnimatorKey $key)
  returns gulong
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_object (ClutterAnimatorKey $key)
  returns GObject
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_progress (ClutterAnimatorKey $key)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_property_name (ClutterAnimatorKey $key)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_property_type (ClutterAnimatorKey $key)
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_animator_key_get_value (ClutterAnimatorKey $key, GValue $value)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_animator_new ()
  returns ClutterAnimator
  is native(clutter)
  is export
{ * }

sub clutter_animator_property_get_ease_in (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_animator_property_get_interpolation (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name
)
  returns ClutterInterpolation
  is native(clutter)
  is export
{ * }

sub clutter_animator_property_set_ease_in (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name,
  gboolean        $ease_in
)
  is native(clutter)
  is export
{ * }

sub clutter_animator_property_set_interpolation (
  ClutterAnimator      $animator,
  GObject              $object,
  Str                  $property_name,
  ClutterInterpolation $interpolation
)
  is native(clutter)
  is export
{ * }

sub clutter_animator_remove_key (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name,
  gdouble         $progress
)
  is native(clutter)
  is export
{ * }

# cw: Will have to be emulated
# sub clutter_animator_set (
#   ClutterAnimator $animator,
#   gpointer $first_object,
#   Str $first_property_name,
#   guint $first_mode,
#   gdouble $first_progress,
#   ...
# )
#   is native(clutter)
#   is export
# { * }

sub clutter_animator_set_duration (ClutterAnimator $animator, guint $duration)
  is native(clutter)
  is export
{ * }

sub clutter_animator_set_key (
  ClutterAnimator $animator,
  GObject         $object,
  Str             $property_name,
  guint           $mode,
  gdouble         $progress,
  GValue          $value
)
  returns ClutterAnimator
  is native(clutter)
  is export
{ * }

sub clutter_animator_set_timeline (
  ClutterAnimator $animator,
  ClutterTimeline $timeline
)
  is native(clutter)
  is export
{ * }

sub clutter_animator_start (ClutterAnimator $animator)
  returns ClutterTimeline
  is native(clutter)
  is export
{ * }
