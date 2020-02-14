use v6.c;

use Method::Also;


use Clutter::Raw::Types;



use Clutter::Raw::Main;

class Clutter::Threads {

  method new (|) {
    warn qq:to/DIE/.chomp;
Class Clutter::Threads is not instantiable. Please use the type object when{ ''
}calling methods.
DIE

    Clutter::Threads;
  }

  method add_idle (
    &func,
    gpointer $data = gpointer
  )
    is also<add-idle>
  {
    clutter_threads_add_idle(&func, $data);
  }

  proto method add_idle_full (|)
    is also<add-idle-full>
  { * }

  # This multi doesn't really serve much of a purpose, after a bit of thought.
  multi method add_idle_full (
    &func,
    Int() $priority        = G_PRIORITY_DEFAULT,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    samewith($priority, &func, $data, $notify);
  }
  multi method add_idle_full (
    Int $priority,
    &func,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    my gint $p = resolve-int($priority);
    clutter_threads_add_idle_full($priority, &func, $data, $notify);
  }

  method add_repaint_func (
    &func,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<add-repaint-func>
  {
    clutter_threads_add_repaint_func(&func, $data, $notify);
  }

  method add_repaint_func_full (
    Int() $flags, # ClutterRepaintFlags $flags,
    &func,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<add-repaint-func-full>
  {
    my guint $f = resolve-uint($flags);
    clutter_threads_add_repaint_func_full($f, &func, $data, $notify);
  }

  method add_timeout (
    Int() $interval,
    &func,
    gpointer $data = gpointer
  )
    is also<add-timeout>
  {
    my guint $i = resolve-uint($interval);
    clutter_threads_add_timeout($i, &func, $data);
  }

  proto method add_timeout_full (|)
    is also<add-timeout-full>
  { * }

  # cw: May want to rethink the need for this multi.
  multi method add_timeout_full (
    &func,
    Int() $interval,
    Int() $priority        = G_PRIORITY_DEFAULT,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    samewith($priority, $interval, &func, $data, $notify)
  }
  multi method add_timeout_full (
    Int  $priority,
    Int() $interval,
    &func,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    my gint $p = resolve-int($priority);
    my guint $i = resolve-uint($interval);
    clutter_threads_add_timeout_full($p, $i, &func, $data, $notify);
  }

  method remove_repaint_func (Int() $handle_id)
    is also<remove-repaint-func>
  {
    my guint $h = resolve-uint($handle_id);
    clutter_threads_remove_repaint_func($h);
  }

}
