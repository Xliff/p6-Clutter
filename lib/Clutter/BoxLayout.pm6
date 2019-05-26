use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::BoxLayout;

use Clutter::LayoutManager;

class Clutter::BoxLayout is Clutter::LayoutManager {
  has ClutterBoxLayout $!cb;
  
  submethod BUILD (:$boxlayout) {
    # Needs ancestry logic.
    self.setLayoutManager( cast(ClutterLayoutManager, $!cb = $boxlayout) )
  }
  
  method new  {
    self.bless( boxlayout => clutter_box_layout_new() );
  }
  
  method easing_duration is rw is DEPRECATED {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_easing_duration($!cb);
      },
      STORE => sub ($, $msecs is copy) {
        clutter_box_layout_set_easing_duration($!cb, $msecs);
      }
    );
  }

  method easing_mode is rw is DEPRECATED {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_easing_mode($!cb);
      },
      STORE => sub ($, $mode is copy) {
        clutter_box_layout_set_easing_mode($!cb, $mode);
      }
    );
  }

  method homogeneous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_box_layout_get_homogeneous($!cb);
      },
      STORE => sub ($, Int() $homogeneous is copy) {
        my gboolean $h = resolve-bool($homogeneous);
        clutter_box_layout_set_homogeneous($!cb, $h);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_orientation($!cb);
      },
      STORE => sub ($, $orientation is copy) {
        clutter_box_layout_set_orientation($!cb, $orientation);
      }
    );
  }

  method pack_start is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_pack_start($!cb);
      },
      STORE => sub ($, $pack_start is copy) {
        clutter_box_layout_set_pack_start($!cb, $pack_start);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_spacing($!cb);
      },
      STORE => sub ($, $spacing is copy) {
        clutter_box_layout_set_spacing($!cb, $spacing);
      }
    );
  }

  method use_animations is rw is DEPRECATED {
    Proxy.new(
      FETCH => sub ($) {
        clutter_box_layout_get_use_animations($!cb);
      },
      STORE => sub ($, $animate is copy) {
        clutter_box_layout_set_use_animations($!cb, $animate);
      }
    );
  }
  
  method get_alignment (
    ClutterActor $actor, 
    ClutterBoxAlignment $x_align, 
    ClutterBoxAlignment $y_align
  ) 
    is DEPRECATED
  {
    clutter_box_layout_get_alignment($!cb, $actor, $x_align, $y_align);
  }

  method get_expand (ClutterActor $actor) is DEPRECATED {
    clutter_box_layout_get_expand($!cb, $actor);
  }

  # DEPRECATED 
  # method get_fill (ClutterActor $actor, gboolean $x_fill, gboolean $y_fill) {
  #   clutter_box_layout_get_fill($!cb, $actor, $x_fill, $y_fill);
  # }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_box_layout_get_type, $n, $t );
  }

  method pack (
    ClutterActor $actor, 
    gboolean $expand, 
    gboolean $x_fill, 
    gboolean $y_fill, 
    ClutterBoxAlignment $x_align, 
    ClutterBoxAlignment $y_align
  ) 
    is DEPRECATED
  {
    clutter_box_layout_pack(
      $!cb, $actor, $expand, $x_fill, $y_fill, $x_align, $y_align
    );
  }

  method set_alignment (
    ClutterActor $actor, 
    ClutterBoxAlignment $x_align, 
    ClutterBoxAlignment $y_align
  ) 
    is DEPRECATED
  {
    clutter_box_layout_set_alignment($!cb, $actor, $x_align, $y_align);
  }

  method set_expand (ClutterActor $actor, gboolean $expand) is DEPRECATED {
    clutter_box_layout_set_expand($!cb, $actor, $expand);
  }

  method set_fill (ClutterActor $actor, gboolean $x_fill, gboolean $y_fill) 
    is DEPRECATED
  {
    clutter_box_layout_set_fill($!cb, $actor, $x_fill, $y_fill);
  }
  
}
