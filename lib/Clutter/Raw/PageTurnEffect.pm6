use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::PageTurnEffect;

sub clutter_page_turn_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_new (
  gdouble $period,
  gdouble $angle,
  gfloat $radius
)
  returns ClutterPageTurnEffect
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_get_angle (ClutterPageTurnEffect $effect)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_get_period (ClutterPageTurnEffect $effect)
  returns gdouble
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_get_radius (ClutterPageTurnEffect $effect)
  returns gfloat
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_set_angle (
  ClutterPageTurnEffect $effect,
  gdouble $angle
)
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_set_period (
  ClutterPageTurnEffect $effect,
  gdouble $period
)
  is native(clutter)
  is export
{ * }

sub clutter_page_turn_effect_set_radius (
  ClutterPageTurnEffect $effect,
  gfloat $radius
)
  is native(clutter)
  is export
{ * }
