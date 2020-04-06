use v6.c;

use Clutter::Raw::Types;
use Clutter::Raw::BindingPool;

use GLib::Roles::Object;

class Clutter::BindingPool {
  also does GLib::Roles::Object;

  has ClutterBindingPool $!cbp is implementor;

  submethod BUILD (:$binding-pool) {
    $!cbp = $binding-pool;

    self.roleInit-Object;
  }

  method Clutter::Raw::Definitions::ClutterBindingPool
  { $!cbp }

  multi method new (ClutterBindingPool $binding-pool) {
    $binding-pool ?? self.bless($binding-pool) !! Nil;
  }
  multi method new (Str() $name) {
    my $binding-pool = clutter_binding_pool_new($name);

    $binding-pool ?? self.bless($binding-pool) !! Nil;
  }

  method find (Clutter::BindingPool:U: Str() $name, $raw = False) {
    my $binding-pool = clutter_binding_pool_find($name);

    $binding-pool ?? self.bless($binding-pool) !! Nil;
  }

  method activate (
    Int() $key_val,
    Int() $modifiers,
    GObject() $gobject
  ) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_activate($!cbp, $k, $m, $gobject);
  }

  method block_action (Str() $action_name) {
    clutter_binding_pool_block_action($!cbp, $action_name);
  }

  method find_action (Int() $key_val, Int() $modifiers) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_find_action($!cbp, $k, $m);
  }

  method get_type {
    clutter_binding_pool_get_type();
  }

  method install_action (
    Str $action_name,
    Int() $key_val,
    Int() $modifiers,
    &callback,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = GDestroyNotify
  ) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_install_action(
      $!cbp,
      $action_name,
      $k,
      $m,
      &callback,
      $data,
      $notify
    );
  }

  method install_closure (
    Str() $action_name,
    Int() $key_val,
    Int() $modifiers,
    GClosure() $closure
  ) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_install_closure(
      $!cbp,
      $action_name,
      $k,
      $m,
      $closure
    );
  }

  method override_action (
    Int() $key_val,
    Int() $modifiers,
    &callback,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = GDestroyNotify
  ) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_override_action(
      $!cbp,
      $k,
      $m,
      &callback,
      $data,
      $notify
    );
  }

  method override_closure (
    Int() $key_val,
    Int() $modifiers,
    GClosure() $closure
  ) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_override_closure($!cbp, $k, $m, $closure);
  }

  method remove_action (Int() $key_val, Int() $modifiers) {
    my guint $k =  $key_val;
    my ClutterModifierType $m = $modifiers;

    clutter_binding_pool_remove_action($!cbp, $k, $m);
  }

  method unblock_action (Str() $action_name) {
    clutter_binding_pool_unblock_action($!cbp, $action_name);
  }

}
