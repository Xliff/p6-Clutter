use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Clutter::Raw::Definitions;

unit package Clutter::Raw::Structs;

# Needs a LOT of rework. EVERY attribute needs to be re-written as a Proxy
# to make these easier to use with a NON-native approach.

class ClutterColor is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint8 $.red   is rw;
  has guint8 $.green is rw;
  has guint8 $.blue  is rw;
  has guint8 $.alpha is rw;
}

class ClutterAnyEvent is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint        $.type  ;
  has guint32      $.time  ;
  has guint        $.flags ;  # ClutterEventFlags flags;
  has ClutterStage $.stage ;
  has ClutterActor $.source;
}

role ClutterEventMethods {
  method type   { self.header.type   }
  method time   { self.header.time   }
  method flags  { self.header.flags  }
  method stage  { self.header.stage  }
  method source { self.header.source }
}

class ClutterKeyEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has guint               $.modifier_state; # ClutterModifierType
  has guint               $.keyval;
  has guint16             $.hardware_keycode;
  has gunichar            $.unicode_value;
  has ClutterInputDevice  $.device;
}

class ClutterButtonEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has gfloat              $.x;
  has gfloat              $.y;
  has guint               $.modifier_state; # ClutterModifierType
  has guint32             $.button;
  has guint               $.click_count;
  has CArray[gdouble]     $.axes;
  has ClutterInputDevice  $.device;
}

class ClutterCrossingEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has gfloat              $.x;
  has gfloat              $.y;
  has ClutterInputDevice  $.device;
  has ClutterActor        $.related;
}

class ClutterMotionEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has gfloat              $.x;
  has gfloat              $.y;
  has guint               $.modifier_state; # ClutterModifierType
  has CArray[gdouble]     $.axes;
  has ClutterInputDevice  $.device;
}

class ClutterScrollEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has gfloat              $.x;
  has gfloat              $.y;
  has guint               $.direction;      # ClutterScrollDirection direction;
  has guint               $.modifier_state; # ClutterModifierType
  has CArray[gdouble]     $.axes;
  has ClutterInputDevice  $.device;
  has guint               $.scroll_source;  # ClutterScrollSource scroll_source;
  has guint               $.finish_flags;   # ClutterScrollFinishFlags finish_flags;
}

class ClutterStageStateEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has guint $.changed_mask; # ClutterStageState changed_mask;
  has guint $.new_state;    # ClutterStageState new_state;
}

class ClutterTouchEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent      $.header;

  has gfloat               $.x;
  has gfloat               $.y;
  has ClutterEventSequence $.sequence;
  has guint                $.modifier_state; # ClutterModifierType
  has CArray[gdouble]      $.axes;
  has ClutterInputDevice   $.device;
}

class ClutterTouchpadPinchEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has guint               $.phase; # ClutterTouchpadGesturePhase phase;
  has gfloat              $.x;
  has gfloat              $.y;
  has gfloat              $.dx;
  has gfloat              $.dy;
  has gfloat              $.angle_delta;
  has gfloat              $.scale;
}

class ClutterTouchpadSwipeEvent is repr('CStruct') is export does ClutterEventMethods does GLib::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has guint               $.phase; # ClutterTouchpadGesturePhase phase;
  has guint               $.n_fingers;
  has gfloat              $.x;
  has gfloat              $.y;
  has gfloat              $.dx;
  has gfloat              $.dy;
}

class ClutterEvent is repr('CUnion') is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint                     $.type;
  has ClutterAnyEvent           $.any;
  has ClutterButtonEvent        $.button;
  has ClutterKeyEvent           $.key;
  has ClutterMotionEvent        $.motion;
  has ClutterScrollEvent        $.scroll;
  has ClutterStageStateEvent    $.stage_state;
  has ClutterCrossingEvent      $.crossing;
  has ClutterTouchEvent         $.touch;
  has ClutterTouchpadPinchEvent $.touchpad_pinch;
  has ClutterTouchpadSwipeEvent $.touchpad_swipe;
}

our subset ClutterEvents is export where
  ClutterAnyEvent           | ClutterButtonEvent | ClutterKeyEvent           |
  ClutterMotionEvent        | ClutterScrollEvent | ClutterStageStateEvent    |
  ClutterCrossingEvent      | ClutterTouchEvent  | ClutterTouchpadPinchEvent |
  ClutterTouchpadSwipeEvent ;

class ClutterPerspective is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $.fovy;
  has gfloat $.aspect;
  has gfloat $.z_near;
  has gfloat $.z_far;
}

# Opaque. ONLY to be used for initialization.
class ClutterActorIter is repr('CStruct') is export does GLib::Roles::Pointers {
  has gpointer $.dummy1;
  has gpointer $.dummy2;
  has gpointer $.dummy3;
  has gint     $.dummy4;
  has gpointer $.dummy5;
}

class ClutterPoint is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $.x is rw;
  has gfloat $.y is rw;

  submethod BUILD (:$!x, :$!y) { }

  method new ($x, $y) {
    self.bless(:$x, :$y);
  }

}

class ClutterSize is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $.width  is rw;
  has gfloat $.height is rw;
}

class ClutterRect is repr('CStruct') is export does GLib::Roles::Pointers {
  HAS ClutterPoint $.origin;
  HAS ClutterSize $.size;
}

class ClutterVertex is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
}

class ClutterActorBox is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $.x1 is rw;
  has gfloat $.y1 is rw;
  has gfloat $.x2 is rw;
  has gfloat $.y2 is rw;
}

class ClutterKnot is repr('CStruct') is export does GLib::Roles::Pointers {
  has gint $.x is rw;
  has gint $.y is rw;
}

class ClutterPathNode is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint       $.type     is rw;     # ClutterPathNodeType type;
  has ClutterKnot $.point1;
  has ClutterKnot $.point2;
  has ClutterKnot $.point3;
};
