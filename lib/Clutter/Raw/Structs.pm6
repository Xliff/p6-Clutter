use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use Clutter::Raw::Definitions;
use Clutter::Raw::Enums;

unit package Clutter::Raw::Structs;

# Needs a LOT of rework. EVERY attribute needs to be re-written as a Proxy
# to make these easier to use with a NON-native approach.

class ClutterColor is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint8 $!red  ;
  has guint8 $!green;
  has guint8 $!blue ;
  has guint8 $!alpha;

  submethod BUILD (:$!red, :$!green, :$!blue, :$!alpha) { }

  multi method new ($red, $green, $blue, $alpha) {
    self.bless(:$red, :$green, :$blue, :$alpha);
  }

  method red is rw {
    Proxy.new:
      FETCH => sub ($) { $!red },
      STORE => -> $, Int() $r {
        warn 'Red value clipped to 255' if $r > 255;
        warn 'Red value clipped to 0'   if $r < 0;
        $!red = $r > 255 ?? 255
                         !! ($r < 0 ?? 0 !! $r)
      };
  }

  method green is rw {
    Proxy.new:
      FETCH => sub ($) { $!green },
      STORE => -> $, Int() $g {
        warn 'Green value clipped to 255' if $g > 255;
        warn 'Green value clipped to 0'   if $g < 0;
        $!green = $g > 255 ?? 255
                           !! ($g < 0 ?? 0 !! $g)
      };
  }

  method blue is rw {
    Proxy.new:
      FETCH => sub ($) { $!blue },
      STORE => -> $, Int() $b {
        warn 'Blue value clipped to 255' if $b > 255;
        warn 'Blue value clipped to 0'   if $b < 0;
        $!blue = $b > 255 ?? 255
                         !! ($b < 0 ?? 0 !! $b)
      };
  }

  method alpha is rw {
    Proxy.new:
      FETCH => sub ($) { $!alpha },
      STORE => -> $, Int() $a {
        warn 'Alpha value clipped to 255' if $a > 255;
        warn 'Alpha value clipped to 0'   if $a < 0;
        $!alpha = $a > 255 ?? 255
                           !! ($a < 0 ?? 0 !! $a)
      };
  }

}

class ClutterAnyEvent is repr('CStruct') is export does GLib::Roles::Pointers {
  has guint             $.type  ;
  has guint32           $.time  ;
  has ClutterEventFlags $.flags ;
  has ClutterStage      $.stage ;
  has ClutterActor      $.source;
}

role ClutterEventMethods {
  method type   { self.header.type   }
  method time   { self.header.time   }
  method flags  { self.header.flags  }
  method stage  { self.header.stage  }
  method source { self.header.source }
}

# Why can't CStructs use delegation?

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
  has gfloat $!fovy;
  has gfloat $!aspect;
  has gfloat $!z_near;
  has gfloat $!z_far;

  method fovy is rw {
    Proxy.new:
      FETCH => sub ($)           { $!fovy },
      STORE => -> $, Num() \f { $!fovy = f };
  }

  method aspect is rw {
    Proxy.new:
      FETCH => sub ($)           { $!aspect },
      STORE => -> $, Num() \a { $!aspect = a };
  }

  method z_near is also<z-near> is rw {
    Proxy.new:
        FETCH => sub ($)           { $!z_near },
        STORE => -> $, Num() \z { $!z_near = z };
  }

  method z_far is also<z-far> is rw {
    Proxy.new:
        FETCH => sub ($)           { $!z_far },
        STORE => -> $, Num() \z { $!z_far = z };
  }

}

# Opaque. ONLY to be used for initialization.
class ClutterActorIter is repr('CStruct') is export does GLib::Roles::Pointers {
  has gpointer $!dummy1;
  has gpointer $!dummy2;
  has gpointer $!dummy3;
  has gint     $!dummy4;
  has gpointer $!dummy5;
}

class ClutterPoint is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $!x;
  has gfloat $!y;

  submethod BUILD (Num() :$!x, Num() :$!y) { }

  multi method new ($x, $y) {
    self.bless(:$x, :$y);
  }

  method x is rw {
    Proxy.new:
        FETCH => sub ($)        { $!x },
        STORE => -> $, Num() \x { $!x = x };
  }

  method y is rw {
    Proxy.new:
        FETCH => sub ($)        { $!y },
        STORE => -> $, Num() \y { $!y = y };
  }

}

class ClutterSize is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $!width;
  has gfloat $!height;

  submethod BUILD (Num() :$!width, Num() :$!height) { }

  multi method new ($width, $height) {
    self.bless(:$width, :$height);
  }

  method width is rw {
    Proxy.new:
        FETCH => sub ($)           { $!width },
        STORE => -> $, Num() \w { $!width = w };
  }

  method height is rw {
    Proxy.new:
        FETCH => sub ($)           { $!height },
        STORE => -> $, Num() \h { $!height = h };
  }
}

class ClutterRect is repr('CStruct') is export does GLib::Roles::Pointers {
  HAS ClutterPoint $.origin;
  HAS ClutterSize $.size;
}

class ClutterVertex is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $!x;
  has gfloat $!y;
  has gfloat $!z;

  submethod BUILD (Num() :$!x, Num() :$!y, Num() :$!z) { }

  multi method new ($x, $y, $z) {
    self.bless(:$x, :$y, :$z);
  }

  method x is rw {
    Proxy.new:
        FETCH => sub ($)           { $!x },
        STORE => -> $, Num() \x { $!x = x };
  }

  method y is rw {
    Proxy.new:
        FETCH => sub ($)           { $!y },
        STORE => -> $, Num() \y { $!y = y };
  }
}

class ClutterActorBox is repr('CStruct') is export does GLib::Roles::Pointers {
  has gfloat $!x1;
  has gfloat $!y1;
  has gfloat $!x2;
  has gfloat $!y2;

  submethod BUILD (Num() :$!x1, Num() :$!y1, Num() :$!x2, Num() :$!y2) { }

  multi method new ($x1, $y1, $x2, $y2) {
    self.bless(:$x1, :$y1, :$x2, :$y2);
  }

  method x1 is rw {
    Proxy.new:
        FETCH => sub ($)           { $!x1 },
        STORE => -> $, Num() \x { $!x1 = x };
  }

  method y1 is rw {
    Proxy.new:
        FETCH => sub ($)           { $!y1 },
        STORE => -> $, Num() \y { $!y1 = y };
  }

  method x2 is rw {
    Proxy.new:
        FETCH => sub ($)           { $!x2 },
        STORE => -> $, Num() \x { $!x2 = x };
  }

  method y2 is rw {
    Proxy.new:
        FETCH => sub ($)           { $!y2 },
        STORE => -> $, Num() \y { $!y2 = y };
  }
}

class ClutterKnot is repr('CStruct') is export does GLib::Roles::Pointers {
  has gint $!x;
  has gint $!y;

  submethod BUILD (Int() :$!x, Int() :$!y) { }

  multi method new ($x, $y) {
    self.bless(:$x, :$y);
  }

  method x is rw {
    Proxy.new:
        FETCH => sub ($)           { $!x },
        STORE => -> $, Int() \x { $!x = x };
  }

  method y is rw {
    Proxy.new:
        FETCH => sub ($)           { $!y },
        STORE => -> $, Int() \y { $!y = y };
  }
}

class ClutterPathNode is repr('CStruct') is export does GLib::Roles::Pointers {
  has ClutterPathNodeType $!type;
  has ClutterKnot         $!point1;
  has ClutterKnot         $!point2;
  has ClutterKnot         $!point3;

  my constant CK := ClutterKnot;

  method type is rw {
    Proxy.new:
        FETCH => sub ($)           { $!type },
        STORE => -> $, Int() \t { $!type = t };
  }

  method point1 is rw {
    Proxy.new:
        FETCH => sub ($)          { $!point1 },
        STORE => -> $, CK() \k { self.^attributes[1].set_value(self, k) };
  }

  method point2 is rw {
    Proxy.new:
        FETCH => sub ($)          { $!point2 },
        STORE => -> $, CK() \k { self.^attributes[2].set_value(self, k) };
  }

  method point3 is rw {
    Proxy.new:
        FETCH => sub ($)          { $!point3 },
        STORE => -> $, CK() \k { self.^attributes[3].set_value(self, k) };
  }

};
