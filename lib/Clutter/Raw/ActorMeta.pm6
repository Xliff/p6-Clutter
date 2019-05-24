use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

unit package Clutter::Raw::ActorMeta;

sub clutter_actor_meta_get_actor (ClutterActorMeta $meta)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_actor_meta_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_actor_meta_get_enabled (ClutterActorMeta $meta)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_actor_meta_get_name (ClutterActorMeta $meta)
  returns Str
  is native(clutter)
  is export
{ * }

sub clutter_actor_meta_set_enabled (
  ClutterActorMeta $meta, 
  gboolean $is_enabled
)
  is native(clutter)
  is export
{ * }

sub clutter_actor_meta_set_name (ClutterActorMeta $meta, Str $name)
  is native(clutter)
  is export
{ * }
