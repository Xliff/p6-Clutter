use v6.c;

use NativeCall;

use Clutter::Raw::Types;

unit package Clutter::Raw::BindingPool;

### /usr/include/clutter-1.0/clutter/clutter-binding-pool.h

sub clutter_binding_pool_activate (
  ClutterBindingPool $pool,
  guint $key_val,
  ClutterModifierType $modifiers,
  GObject $gobject
)
  returns uint32
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_block_action (
  ClutterBindingPool $pool,
  Str $action_name
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_find (Str $name)
  returns ClutterBindingPool
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_find_action (
  ClutterBindingPool $pool,
  guint $key_val,
  ClutterModifierType $modifiers
)
  returns Str
  is native(clutter)
  is export
{ * }

# sub clutter_binding_pool_get_for_class (gpointer $klass)
#   returns ClutterBindingPool
#   is native(clutter)
#   is export
# { * }

sub clutter_binding_pool_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_install_action (
  ClutterBindingPool $pool,
  Str $action_name,
  guint $key_val,
  ClutterModifierType $modifiers,
  &callback (GObject, Str, guint, ClutterModifierType, gpointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_install_closure (
  ClutterBindingPool $pool,
  Str $action_name,
  guint $key_val,
  ClutterModifierType $modifiers,
  GClosure $closure
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_new (Str $name)
  returns ClutterBindingPool
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_override_action (
  ClutterBindingPool $pool,
  guint $key_val,
  ClutterModifierType $modifiers,
  &callback (GObject, Str, guint, ClutterModifierType, gpointer --> gboolean),
  gpointer $data,
  GDestroyNotify $notify
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_override_closure (
  ClutterBindingPool $pool,
  guint $key_val,
  ClutterModifierType $modifiers,
  GClosure $closure
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_remove_action (
  ClutterBindingPool $pool,
  guint $key_val,
  ClutterModifierType $modifiers
)
  is native(clutter)
  is export
{ * }

sub clutter_binding_pool_unblock_action (
  ClutterBindingPool $pool,
  Str $action_name
)
  is native(clutter)
  is export
{ * }
