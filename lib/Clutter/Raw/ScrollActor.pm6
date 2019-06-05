use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::ScrollActor;

sub clutter_scroll_actor_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_scroll_actor_new ()
  returns ClutterScrollActor
  is native(clutter)
  is export
{ * }

sub clutter_scroll_actor_scroll_to_point (
  ClutterScrollActor $actor,
  ClutterPoint $point
)
  is native(clutter)
  is export
{ * }

sub clutter_scroll_actor_scroll_to_rect (
  ClutterScrollActor $actor,
  ClutterRect $rect
)
  is native(clutter)
  is export
{ * }

sub clutter_scroll_actor_get_scroll_mode (ClutterScrollActor $actor)
  returns guint # ClutterScrollMode
  is native(clutter)
  is export
{ * }

sub clutter_scroll_actor_set_scroll_mode (
  ClutterScrollActor $actor,
  guint $mode # ClutterScrollMode $mode
)
  is native(clutter)
  is export
{ * }
