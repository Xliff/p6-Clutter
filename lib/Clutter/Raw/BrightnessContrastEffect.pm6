use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::BrightnessContrastEffect;

sub clutter_brightness_contrast_effect_get_brightness (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue
)
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_get_contrast (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue
)
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_new ()
  returns ClutterEffect
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_set_brightness (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $brightness
)
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_set_brightness_full (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue
)
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_set_contrast (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $contrast
)
  is native(clutter)
  is export
{ * }

sub clutter_brightness_contrast_effect_set_contrast_full (
  ClutterBrightnessContrastEffect $effect, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue
)
  is native(clutter)
  is export
{ * }
