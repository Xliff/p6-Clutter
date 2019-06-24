use v6.c;

use Cairo;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Pointers;

unit package Clutter::Raw::Types;

# Number of times a forced compile has been made.
constant forced = 2;

constant clutter is export = 'clutter-1.0',v0;

constant cairo_rectangle_int_t is export = Cairo::cairo_rectangle_int_t;

constant ClutterActorCreateChildFunc is export := Pointer;
constant ClutterProgressFunc         is export := Pointer;
constant ClutterTimelineProgressFunc is export := Pointer;

class ClutterAction               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActor                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActorMeta            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAlignConstraint      is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAlpha                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAnimatable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterBinLayout            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterBindConstraint       is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterBackend              is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterBoxLayout            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterCanvas               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterChildMeta            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterConstraint           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterClickAction          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterCloneActor           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterContainer            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterContent              is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterDragAction           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterDropAction           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterDeformEffect         is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterDesaturateEffect     is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterDeviceManager        is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterEffect               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterEventSequence        is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterFlowLayout           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterFog                  is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGeometry             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGestureAction        is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGroup                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGridLayout           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterImage                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterInputDevice          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterInterval             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterLayoutManager        is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterLayoutMeta           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterMargin               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterMatrix               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterOffscreenEffect      is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPageTurnEffect       is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPanAction            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPath                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPaintVolume          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPropertyTransition   is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterSettings             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterScript               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterScrollActor          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterScriptable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterSnapConstraint       is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterStage                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTapAction            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterText                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTextBuffer           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTimeline             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTransition           is repr('CPointer') does GTK::Roles::Pointers is export { }

our enum ClutterActorAlign is export <
  CLUTTER_ACTOR_ALIGN_FILL
  CLUTTER_ACTOR_ALIGN_START
  CLUTTER_ACTOR_ALIGN_CENTER
  CLUTTER_ACTOR_ALIGN_END
>;

our enum ClutterScrollFinishFlags is export (
  CLUTTER_SCROLL_FINISHED_NONE       => 0,
  CLUTTER_SCROLL_FINISHED_HORIZONTAL => 1,
  CLUTTER_SCROLL_FINISHED_VERTICAL   => 1 +< 1,
);

our enum ClutterScalingFilter is export <
  CLUTTER_SCALING_FILTER_LINEAR
  CLUTTER_SCALING_FILTER_NEAREST
  CLUTTER_SCALING_FILTER_TRILINEAR
>;

our enum ClutterRequestMode is export <
  CLUTTER_REQUEST_HEIGHT_FOR_WIDTH
  CLUTTER_REQUEST_WIDTH_FOR_HEIGHT
  CLUTTER_REQUEST_CONTENT_SIZE
>;

our enum ClutterSnapEdge is export <
  CLUTTER_SNAP_EDGE_TOP
  CLUTTER_SNAP_EDGE_RIGHT
  CLUTTER_SNAP_EDGE_BOTTOM
  CLUTTER_SNAP_EDGE_LEFT
>;

our enum ClutterLongPressState is export <
  CLUTTER_LONG_PRESS_QUERY
  CLUTTER_LONG_PRESS_ACTIVATE
  CLUTTER_LONG_PRESS_CANCEL
>;

our enum ClutterBindCoordinate is export <
  CLUTTER_BIND_X
  CLUTTER_BIND_Y
  CLUTTER_BIND_WIDTH
  CLUTTER_BIND_HEIGHT
  CLUTTER_BIND_POSITION
  CLUTTER_BIND_SIZE
  CLUTTER_BIND_ALL
>;

our enum ClutterAllocationFlags is export (
  CLUTTER_ALLOCATION_NONE         => 0,
  CLUTTER_ABSOLUTE_ORIGIN_CHANGED => 1 +< 1,
  CLUTTER_DELEGATE_LAYOUT         => 1 +< 2,
);

our enum ClutterAnimationMode is export (
  CLUTTER_CUSTOM_MODE =>  0,
  'CLUTTER_LINEAR',
  'CLUTTER_EASE_IN_QUAD',
  'CLUTTER_EASE_OUT_QUAD',
  'CLUTTER_EASE_IN_OUT_QUAD',
  'CLUTTER_EASE_IN_CUBIC',
  'CLUTTER_EASE_OUT_CUBIC',
  'CLUTTER_EASE_IN_OUT_CUBIC',
  'CLUTTER_EASE_IN_QUART',
  'CLUTTER_EASE_OUT_QUART',
  'CLUTTER_EASE_IN_OUT_QUART',
  'CLUTTER_EASE_IN_QUINT',
  'CLUTTER_EASE_OUT_QUINT',
  'CLUTTER_EASE_IN_OUT_QUINT',
  'CLUTTER_EASE_IN_SINE',
  'CLUTTER_EASE_OUT_SINE',
  'CLUTTER_EASE_IN_OUT_SINE',
  'CLUTTER_EASE_IN_EXPO',
  'CLUTTER_EASE_OUT_EXPO',
  'CLUTTER_EASE_IN_OUT_EXPO',
  'CLUTTER_EASE_IN_CIRC',
  'CLUTTER_EASE_OUT_CIRC',
  'CLUTTER_EASE_IN_OUT_CIRC',
  'CLUTTER_EASE_IN_ELASTIC',
  'CLUTTER_EASE_OUT_ELASTIC',
  'CLUTTER_EASE_IN_OUT_ELASTIC',
  'CLUTTER_EASE_IN_BACK',
  'CLUTTER_EASE_OUT_BACK',
  'CLUTTER_EASE_IN_OUT_BACK',
  'CLUTTER_EASE_IN_BOUNCE',
  'CLUTTER_EASE_OUT_BOUNCE',
  'CLUTTER_EASE_IN_OUT_BOUNCE',
  'CLUTTER_STEPS',
  'CLUTTER_STEP_START',
  'CLUTTER_STEP_END',
  'CLUTTER_CUBIC_BEZIER',
  'CLUTTER_EASE',
  'CLUTTER_EASE_IN',
  'CLUTTER_EASE_OUT',
  'CLUTTER_EASE_IN_OUT',
  'CLUTTER_ANIMATION_LAST'
);

our enum ClutterPanAxis is export (
  CLUTTER_PAN_AXIS_NONE =>  0,
  'CLUTTER_PAN_X_AXIS',
  'CLUTTER_PAN_Y_AXIS',
  'CLUTTER_PAN_AXIS_AUTO'
);

our enum ClutterTextureError is export <
  CLUTTER_TEXTURE_ERROR_OUT_OF_MEMORY
  CLUTTER_TEXTURE_ERROR_NO_YUV
  CLUTTER_TEXTURE_ERROR_BAD_FORMAT
>;

our enum ClutterGridPosition is export <
  CLUTTER_GRID_POSITION_LEFT
  CLUTTER_GRID_POSITION_RIGHT
  CLUTTER_GRID_POSITION_TOP
  CLUTTER_GRID_POSITION_BOTTOM
>;

our enum ClutterInputDeviceType is export <
  CLUTTER_POINTER_DEVICE
  CLUTTER_KEYBOARD_DEVICE
  CLUTTER_EXTENSION_DEVICE
  CLUTTER_JOYSTICK_DEVICE
  CLUTTER_TABLET_DEVICE
  CLUTTER_TOUCHPAD_DEVICE
  CLUTTER_TOUCHSCREEN_DEVICE
  CLUTTER_PEN_DEVICE
  CLUTTER_ERASER_DEVICE
  CLUTTER_CURSOR_DEVICE
  CLUTTER_N_DEVICE_TYPES
>;

our enum ClutterShaderType is export <
  CLUTTER_VERTEX_SHADER
  CLUTTER_FRAGMENT_SHADER
>;

our enum ClutterRepaintFlags is export (
  CLUTTER_REPAINT_FLAGS_PRE_PAINT           => 1,
  CLUTTER_REPAINT_FLAGS_POST_PAINT          => 1 +< 1,
  CLUTTER_REPAINT_FLAGS_QUEUE_REDRAW_ON_ADD => 1 +< 2,
);

our enum ClutterGestureTriggerEdge is export (
  CLUTTER_GESTURE_TRIGGER_EDGE_NONE =>  0,
  'CLUTTER_GESTURE_TRIGGER_EDGE_AFTER',
  'CLUTTER_GESTURE_TRIGGER_EDGE_BEFORE'
);

our enum ClutterContentGravity is export <
  CLUTTER_CONTENT_GRAVITY_TOP_LEFT
  CLUTTER_CONTENT_GRAVITY_TOP
  CLUTTER_CONTENT_GRAVITY_TOP_RIGHT
  CLUTTER_CONTENT_GRAVITY_LEFT
  CLUTTER_CONTENT_GRAVITY_CENTER
  CLUTTER_CONTENT_GRAVITY_RIGHT
  CLUTTER_CONTENT_GRAVITY_BOTTOM_LEFT
  CLUTTER_CONTENT_GRAVITY_BOTTOM
  CLUTTER_CONTENT_GRAVITY_BOTTOM_RIGHT
  CLUTTER_CONTENT_GRAVITY_RESIZE_FILL
  CLUTTER_CONTENT_GRAVITY_RESIZE_ASPECT
>;

our enum ClutterTimelineDirection is export <
  CLUTTER_TIMELINE_FORWARD
  CLUTTER_TIMELINE_BACKWARD
>;

our enum ClutterSwipeDirection is export (
  CLUTTER_SWIPE_DIRECTION_UP    => 1,
  CLUTTER_SWIPE_DIRECTION_DOWN  => 1 +< 1,
  CLUTTER_SWIPE_DIRECTION_LEFT  => 1 +< 2,
  CLUTTER_SWIPE_DIRECTION_RIGHT => 1 +< 3,
);

our enum ClutterPickMode is export (
  CLUTTER_PICK_NONE => 0,
  'CLUTTER_PICK_REACTIVE',
  'CLUTTER_PICK_ALL'
);

our enum ClutterFlowOrientation is export <
  CLUTTER_FLOW_HORIZONTAL
  CLUTTER_FLOW_VERTICAL
>;

our enum ClutterScriptError is export <
  CLUTTER_SCRIPT_ERROR_INVALID_TYPE_FUNCTION
  CLUTTER_SCRIPT_ERROR_INVALID_PROPERTY
  CLUTTER_SCRIPT_ERROR_INVALID_VALUE
>;

our enum ClutterGravity is export (
  CLUTTER_GRAVITY_NONE =>  0,
  'CLUTTER_GRAVITY_NORTH',
  'CLUTTER_GRAVITY_NORTH_EAST',
  'CLUTTER_GRAVITY_EAST',
  'CLUTTER_GRAVITY_SOUTH_EAST',
  'CLUTTER_GRAVITY_SOUTH',
  'CLUTTER_GRAVITY_SOUTH_WEST',
  'CLUTTER_GRAVITY_WEST',
  'CLUTTER_GRAVITY_NORTH_WEST',
  'CLUTTER_GRAVITY_CENTER'
);

our enum ClutterTableAlignment is export <
  CLUTTER_TABLE_ALIGNMENT_START
  CLUTTER_TABLE_ALIGNMENT_CENTER
  CLUTTER_TABLE_ALIGNMENT_END
>;

our enum ClutterImageError is export <
  CLUTTER_IMAGE_ERROR_INVALID_DATA
>;

our enum ClutterZoomAxis is export <
  CLUTTER_ZOOM_X_AXIS
  CLUTTER_ZOOM_Y_AXIS
  CLUTTER_ZOOM_BOTH
>;

our enum ClutterStepMode is export <
  CLUTTER_STEP_MODE_START
  CLUTTER_STEP_MODE_END
>;

our enum ClutterBinAlignment is export <
  CLUTTER_BIN_ALIGNMENT_FIXED
  CLUTTER_BIN_ALIGNMENT_FILL
  CLUTTER_BIN_ALIGNMENT_START
  CLUTTER_BIN_ALIGNMENT_END
  CLUTTER_BIN_ALIGNMENT_CENTER
>;

our enum ClutterScrollDirection is export <
  CLUTTER_SCROLL_UP
  CLUTTER_SCROLL_DOWN
  CLUTTER_SCROLL_LEFT
  CLUTTER_SCROLL_RIGHT
  CLUTTER_SCROLL_SMOOTH
>;

our enum ClutterEventFlags is export (
  CLUTTER_EVENT_NONE           => 0,
  CLUTTER_EVENT_FLAG_SYNTHETIC => 1,
);

our enum ClutterOrientation is export <
  CLUTTER_ORIENTATION_HORIZONTAL
  CLUTTER_ORIENTATION_VERTICAL
>;

our enum ClutterShaderError is export <
  CLUTTER_SHADER_ERROR_NO_ASM
  CLUTTER_SHADER_ERROR_NO_GLSL
  CLUTTER_SHADER_ERROR_COMPILE
>;

our enum ClutterInputMode is export <
  CLUTTER_INPUT_MODE_MASTER
  CLUTTER_INPUT_MODE_SLAVE
  CLUTTER_INPUT_MODE_FLOATING
>;

our enum ClutterInputAxis is export <
  CLUTTER_INPUT_AXIS_IGNORE
  CLUTTER_INPUT_AXIS_X
  CLUTTER_INPUT_AXIS_Y
  CLUTTER_INPUT_AXIS_PRESSURE
  CLUTTER_INPUT_AXIS_XTILT
  CLUTTER_INPUT_AXIS_YTILT
  CLUTTER_INPUT_AXIS_WHEEL
  CLUTTER_INPUT_AXIS_DISTANCE
  CLUTTER_INPUT_AXIS_LAST
>;

our enum ClutterBoxAlignment is export <
  CLUTTER_BOX_ALIGNMENT_START
  CLUTTER_BOX_ALIGNMENT_END
  CLUTTER_BOX_ALIGNMENT_CENTER
>;

our enum ClutterRotateAxis is export <
  CLUTTER_X_AXIS
  CLUTTER_Y_AXIS
  CLUTTER_Z_AXIS
>;

our enum ClutterScrollSource is export <
  CLUTTER_SCROLL_SOURCE_UNKNOWN
  CLUTTER_SCROLL_SOURCE_WHEEL
  CLUTTER_SCROLL_SOURCE_FINGER
  CLUTTER_SCROLL_SOURCE_CONTINUOUS
>;

our enum ClutterTouchpadGesturePhase is export <
  CLUTTER_TOUCHPAD_GESTURE_PHASE_BEGIN
  CLUTTER_TOUCHPAD_GESTURE_PHASE_UPDATE
  CLUTTER_TOUCHPAD_GESTURE_PHASE_END
  CLUTTER_TOUCHPAD_GESTURE_PHASE_CANCEL
>;

our enum ClutterAlignAxis is export <
  CLUTTER_ALIGN_X_AXIS
  CLUTTER_ALIGN_Y_AXIS
  CLUTTER_ALIGN_BOTH
>;

our enum ClutterDragAxis is export (
  CLUTTER_DRAG_AXIS_NONE =>  0,
  'CLUTTER_DRAG_X_AXIS',
  'CLUTTER_DRAG_Y_AXIS'
);

our enum ClutterTextDirection is export <
  CLUTTER_TEXT_DIRECTION_DEFAULT
  CLUTTER_TEXT_DIRECTION_LTR
  CLUTTER_TEXT_DIRECTION_RTL
>;

our enum ClutterActorFlags is export (
  CLUTTER_ACTOR_MAPPED    => 1 +< 1,
  CLUTTER_ACTOR_REALIZED  => 1 +< 2,
  CLUTTER_ACTOR_REACTIVE  => 1 +< 3,
  CLUTTER_ACTOR_VISIBLE   => 1 +< 4,
  CLUTTER_ACTOR_NO_LAYOUT => 1 +< 5,
);

our enum ClutterTextureQuality is export <
  CLUTTER_TEXTURE_QUALITY_LOW
  CLUTTER_TEXTURE_QUALITY_MEDIUM
  CLUTTER_TEXTURE_QUALITY_HIGH
>;

our enum ClutterUnitType is export <
  CLUTTER_UNIT_PIXEL
  CLUTTER_UNIT_EM
  CLUTTER_UNIT_MM
  CLUTTER_UNIT_POINT
  CLUTTER_UNIT_CM
>;

our enum ClutterEventType is export (
  CLUTTER_NOTHING =>  0,
  'CLUTTER_KEY_PRESS',
  'CLUTTER_KEY_RELEASE',
  'CLUTTER_MOTION',
  'CLUTTER_ENTER',
  'CLUTTER_LEAVE',
  'CLUTTER_BUTTON_PRESS',
  'CLUTTER_BUTTON_RELEASE',
  'CLUTTER_SCROLL',
  'CLUTTER_STAGE_STATE',
  'CLUTTER_DESTROY_NOTIFY',
  'CLUTTER_CLIENT_MESSAGE',
  'CLUTTER_DELETE',
  'CLUTTER_TOUCH_BEGIN',
  'CLUTTER_TOUCH_UPDATE',
  'CLUTTER_TOUCH_END',
  'CLUTTER_TOUCH_CANCEL',
  'CLUTTER_TOUCHPAD_PINCH',
  'CLUTTER_TOUCHPAD_SWIPE',
  'CLUTTER_EVENT_LAST'
);

our enum ClutterInterpolation is export <
  CLUTTER_INTERPOLATION_LINEAR
  CLUTTER_INTERPOLATION_CUBIC
>;

our enum ClutterRotateDirection is export <
  CLUTTER_ROTATE_CW
  CLUTTER_ROTATE_CCW
>;

our enum ClutterOffscreenRedirect is export (
  CLUTTER_OFFSCREEN_REDIRECT_AUTOMATIC_FOR_OPACITY => 1,
  CLUTTER_OFFSCREEN_REDIRECT_ALWAYS                => 1 +< 1,
);

our enum ClutterContentRepeat is export (
  CLUTTER_REPEAT_NONE   => 0,
  CLUTTER_REPEAT_X_AXIS => 1,
  CLUTTER_REPEAT_Y_AXIS => 1 +< 1,
  CLUTTER_REPEAT_BOTH   => 3
);

our enum ClutterStaticColor is export (
  CLUTTER_COLOR_WHITE           => 0,
  'CLUTTER_COLOR_BLACK',
  'CLUTTER_COLOR_RED',
  'CLUTTER_COLOR_DARK_RED',
  'CLUTTER_COLOR_GREEN',
  'CLUTTER_COLOR_DARK_GREEN',
  'CLUTTER_COLOR_BLUE',
  'CLUTTER_COLOR_DARK_BLUE',
  'CLUTTER_COLOR_CYAN',
  'CLUTTER_COLOR_DARK_CYAN',
  'CLUTTER_COLOR_MAGENTA',
  'CLUTTER_COLOR_DARK_MAGENTA',
  'CLUTTER_COLOR_YELLOW',
  'CLUTTER_COLOR_DARK_YELLOW',
  'CLUTTER_COLOR_GRAY',
  'CLUTTER_COLOR_DARK_GRAY',
  'CLUTTER_COLOR_LIGHT_GRAY',
  'CLUTTER_COLOR_BUTTER',
  'CLUTTER_COLOR_BUTTER_LIGHT',
  'CLUTTER_COLOR_BUTTER_DARK',
  'CLUTTER_COLOR_ORANGE',
  'CLUTTER_COLOR_ORANGE_LIGHT',
  'CLUTTER_COLOR_ORANGE_DARK',
  'CLUTTER_COLOR_CHOCOLATE',
  'CLUTTER_COLOR_CHOCOLATE_LIGHT',
  'CLUTTER_COLOR_CHOCOLATE_DARK',
  'CLUTTER_COLOR_CHAMELEON',
  'CLUTTER_COLOR_CHAMELEON_LIGHT',
  'CLUTTER_COLOR_CHAMELEON_DARK',
  'CLUTTER_COLOR_SKY_BLUE',
  'CLUTTER_COLOR_SKY_BLUE_LIGHT',
  'CLUTTER_COLOR_SKY_BLUE_DARK',
  'CLUTTER_COLOR_PLUM',
  'CLUTTER_COLOR_PLUM_LIGHT',
  'CLUTTER_COLOR_PLUM_DARK',
  'CLUTTER_COLOR_SCARLET_RED',
  'CLUTTER_COLOR_SCARLET_RED_LIGHT',
  'CLUTTER_COLOR_SCARLET_RED_DARK',
  'CLUTTER_COLOR_ALUMINIUM_1',
  'CLUTTER_COLOR_ALUMINIUM_2',
  'CLUTTER_COLOR_ALUMINIUM_3',
  'CLUTTER_COLOR_ALUMINIUM_4',
  'CLUTTER_COLOR_ALUMINIUM_5',
  'CLUTTER_COLOR_ALUMINIUM_6',
  'CLUTTER_COLOR_TRANSPARENT'
);

our enum ClutterEventAction is export (
  CLUTTER_EVENT_PROPAGATE => 0,
  CLUTTER_EVENT_STOP      => 1,
);

class ClutterColor is repr('CStruct') is export does GTK::Roles::Pointers {
  has guint8 $.red   is rw;
  has guint8 $.green is rw;
  has guint8 $.blue  is rw;
  has guint8 $.alpha is rw;
}

class ClutterAnyEvent is repr('CStruct') is export does GTK::Roles::Pointers {
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

class ClutterKeyEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent     $.header;

  has guint               $.modifier_state; # ClutterModifierType
  has guint               $.keyval;
  has guint16             $.hardware_keycode;
  has gunichar            $.unicode_value;
  has ClutterInputDevice  $.device;
}

class ClutterButtonEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent $.header;

  has gfloat              $.x;
  has gfloat              $.y;
  has guint               $.modifier_state; # ClutterModifierType
  has guint32             $.button;
  has guint               $.click_count;
  has CArray[gdouble]     $.axes;
  has ClutterInputDevice  $.device;
}

class ClutterCrossingEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent    $.header;

  has gfloat             $.x;
  has gfloat             $.y;
  has ClutterInputDevice $.device;
  has ClutterActor       $.related;
}

class ClutterMotionEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent    $.header;

  has gfloat             $.x;
  has gfloat             $.y;
  has guint              $.modifier_state; # ClutterModifierType
  has CArray[gdouble]    $.axes;
  has ClutterInputDevice $.device;
}

class ClutterScrollEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent    $.header;

  has gfloat             $.x;
  has gfloat             $.y;
  has guint              $.direction;      # ClutterScrollDirection direction;
  has guint              $.modifier_state; # ClutterModifierType
  has CArray[gdouble]    $.axes;
  has ClutterInputDevice $.device;
  has guint              $.scroll_source;  # ClutterScrollSource scroll_source;
  has guint              $.finish_flags;   # ClutterScrollFinishFlags finish_flags;
}

class ClutterStageStateEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent $.header;

  has guint $.changed_mask; # ClutterStageState changed_mask;
  has guint $.new_state;    # ClutterStageState new_state;
}

class ClutterTouchEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent      $.header;

  has gfloat               $.x;
  has gfloat               $.y;
  has ClutterEventSequence $.sequence;
  has guint                $.modifier_state; # ClutterModifierType
  has CArray[gdouble]      $.axes;
  has ClutterInputDevice   $.device;
}

class ClutterTouchpadPinchEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent $.header;

  has guint           $.phase; # ClutterTouchpadGesturePhase phase;
  has gfloat          $.x;
  has gfloat          $.y;
  has gfloat          $.dx;
  has gfloat          $.dy;
  has gfloat          $.angle_delta;
  has gfloat          $.scale;
}

class ClutterTouchpadSwipeEvent is repr('CStruct') is export does ClutterEventMethods does GTK::Roles::Pointers {
  HAS ClutterAnyEvent $.header;

  has guint  $.phase; # ClutterTouchpadGesturePhase phase;
  has guint  $.n_fingers;
  has gfloat $.x;
  has gfloat $.y;
  has gfloat $.dx;
  has gfloat $.dy;
}

class ClutterEvent is repr('CUnion') is repr('CStruct') is export does GTK::Roles::Pointers {
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

class ClutterPerspective is repr('CStruct') is export does GTK::Roles::Pointers {
  has gfloat $.fovy;
  has gfloat $.aspect;
  has gfloat $.z_near;
  has gfloat $.z_far;
}


our enum ClutterModifierType is export (
  CLUTTER_SHIFT_MASK    => 1,
  CLUTTER_LOCK_MASK     => 1 +< 1,
  CLUTTER_CONTROL_MASK  => 1 +< 2,
  CLUTTER_MOD1_MASK     => 1 +< 3,
  CLUTTER_MOD2_MASK     => 1 +< 4,
  CLUTTER_MOD3_MASK     => 1 +< 5,
  CLUTTER_MOD4_MASK     => 1 +< 6,
  CLUTTER_MOD5_MASK     => 1 +< 7,
  CLUTTER_BUTTON1_MASK  => 1 +< 8,
  CLUTTER_BUTTON2_MASK  => 1 +< 9,
  CLUTTER_BUTTON3_MASK  => 1 +< 10,
  CLUTTER_BUTTON4_MASK  => 1 +< 11,
  CLUTTER_BUTTON5_MASK  => 1 +< 12,

  CLUTTER_MODIFIER_RESERVED_13_MASK  => 1 +< 13,
  CLUTTER_MODIFIER_RESERVED_14_MASK  => 1 +< 14,
  CLUTTER_MODIFIER_RESERVED_15_MASK  => 1 +< 15,
  CLUTTER_MODIFIER_RESERVED_16_MASK  => 1 +< 16,
  CLUTTER_MODIFIER_RESERVED_17_MASK  => 1 +< 17,
  CLUTTER_MODIFIER_RESERVED_18_MASK  => 1 +< 18,
  CLUTTER_MODIFIER_RESERVED_19_MASK  => 1 +< 19,
  CLUTTER_MODIFIER_RESERVED_20_MASK  => 1 +< 20,
  CLUTTER_MODIFIER_RESERVED_21_MASK  => 1 +< 21,
  CLUTTER_MODIFIER_RESERVED_22_MASK  => 1 +< 22,
  CLUTTER_MODIFIER_RESERVED_23_MASK  => 1 +< 23,
  CLUTTER_MODIFIER_RESERVED_24_MASK  => 1 +< 24,
  CLUTTER_MODIFIER_RESERVED_25_MASK  => 1 +< 25,

  CLUTTER_SUPER_MASK    => 1 +< 26,
  CLUTTER_HYPER_MASK    => 1 +< 27,
  CLUTTER_META_MASK     => 1 +< 28,

  CLUTTER_MODIFIER_RESERVED_29_MASK  => 1 +< 29,

  CLUTTER_RELEASE_MASK  => 1 +< 30,

  #Combination of CLUTTER_SHIFT_MASK..CLUTTER_BUTTON5_MASK + CLUTTER_SUPER_MASK
  #   + CLUTTER_HYPER_MASK + CLUTTER_META_MASK + CLUTTER_RELEASE_MASK
  CLUTTER_MODIFIER_MASK => 0x5c001fff
);

our enum ClutterButtonPress is export (
  CLUTTER_BUTTON_PRIMARY => 1,
  'CLUTTER_BUTTON_MIDDLE',
  'CLUTTER_BUTTON_SECONDARY'
);

# Opaque. ONLY to be used for initialization.
class ClutterActorIter is repr('CStruct') is export does GTK::Roles::Pointers {
  has gpointer $.dummy1;
  has gpointer $.dummy2;
  has gpointer $.dummy3;
  has gint     $.dummy4;
  has gpointer $.dummy5;
}

class ClutterPoint is repr('CStruct') is export does GTK::Roles::Pointers {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
}

class ClutterSize is repr('CStruct') is export does GTK::Roles::Pointers {
  has gfloat $.width  is rw;
  has gfloat $.height is rw;
}

class ClutterRect is repr('CStruct') is export does GTK::Roles::Pointers {
  HAS ClutterPoint $.origin;
  HAS ClutterSize $.size;
}

class ClutterVertex is repr('CStruct') is export does GTK::Roles::Pointers {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
}

class ClutterActorBox is repr('CStruct') is export does GTK::Roles::Pointers {
  has gfloat $.x1 is rw;
  has gfloat $.y1 is rw;
  has gfloat $.x2 is rw;
  has gfloat $.y2 is rw;
}

class ClutterKnot is repr('CStruct') is export does GTK::Roles::Pointers {
  has gint $.x is rw;
  has gint $.y is rw;
}

our enum ClutterPathNodeType is export (
  CLUTTER_PATH_MOVE_TO      => 0,
  CLUTTER_PATH_LINE_TO      => 1,
  CLUTTER_PATH_CURVE_TO     => 2,
  CLUTTER_PATH_CLOSE        => 3,
  CLUTTER_PATH_RELATIVE     => 32,

  CLUTTER_PATH_REL_MOVE_TO  => 32, # CLUTTER_PATH_MOVE_TO | CLUTTER_PATH_RELATIVE,
  CLUTTER_PATH_REL_LINE_TO  => 33, # CLUTTER_PATH_LINE_TO | CLUTTER_PATH_RELATIVE,
  CLUTTER_PATH_REL_CURVE_TO => 34, # CLUTTER_PATH_CURVE_TO | CLUTTER_PATH_RELATIVE
);

class ClutterPathNode is repr('CStruct') is export does GTK::Roles::Pointers {
  has guint       $.type     is rw;     # ClutterPathNodeType type;
  has ClutterKnot $.point1;
  has ClutterKnot $.point2;
  has ClutterKnot $.point3;
};

our enum ClutterInitError is export (
  CLUTTER_INIT_SUCCESS        =>  1,
  CLUTTER_INIT_ERROR_UNKNOWN  =>  0,
  CLUTTER_INIT_ERROR_THREADS  => -1,
  CLUTTER_INIT_ERROR_BACKEND  => -2,
  CLUTTER_INIT_ERROR_INTERNAL => -3
);

our enum ClutterScrollMode is export (
  CLUTTER_SCROLL_NONE         => 0,
  CLUTTER_SCROLL_HORIZONTALLY => 1,
  CLUTTER_SCROLL_VERTICALLY   => 2,
  CLUTTER_SCROLL_BOTH         => 3  # CLUTTER_SCROLL_HORIZONTALLY | CLUTTER_SCROLL_VERTICALLY
);
