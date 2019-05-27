use v6.c;

use Cairo;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Pointers;

unit package Clutter::Raw::Types;

constant clutter is export = 'clutter-1.0',v0;

constant cairo_rectangle_int_t is export = Cairo::cairo_rectangle_int_t;

constant ClutterActorCreateChildFunc is export := Pointer;
constant ClutterProgressFunc         is export := Pointer;
constant ClutterTimelineProgressFunc is export := Pointer;

class ClutterAction               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActor                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActorBox             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActorIter            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterActorMeta            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAlignConstraint      is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAlpha                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterAnimatable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterBoxLayout            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterChildMeta            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterColor                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterConstraint           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterContainer            is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterContent              is repr('CPointer') does GTK::Roles::Pointers is export { }
#class ClutterContentRepeatType is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterEffect               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterEvent                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterFog                  is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGeometry             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterGroup                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterImage                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterInterval             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterKnot                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterLayoutManager        is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterLayoutMeta           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterMargin               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterMatrix               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPaintVolume          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPathNode             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPerspective          is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterPoint                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterRect                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterScript               is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterScriptable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterSize                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterStage                is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterText                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTextBuffer           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTimeline             is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterTransition           is repr('CPointer') does GTK::Roles::Pointers is export { }
class ClutterVertex               is repr('CPointer') does GTK::Roles::Pointers is export { }

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

our enum ClutterStaticColorExtra is export (
  CLUTTER_COLOR_White             => CLUTTER_COLOR_WHITE,
  CLUTTER_COLOR_Black             => CLUTTER_COLOR_BLACK,
  CLUTTER_COLOR_Red               => CLUTTER_COLOR_RED,
  CLUTTER_COLOR_DarkRed           => CLUTTER_COLOR_DARK_RED,
  CLUTTER_COLOR_Green             => CLUTTER_COLOR_GREEN,
  CLUTTER_COLOR_DarkGreen         => CLUTTER_COLOR_DARK_GREEN,
  CLUTTER_COLOR_Blue              => CLUTTER_COLOR_BLUE,
  CLUTTER_COLOR_DarkBlue          => CLUTTER_COLOR_DARK_BLUE,
  CLUTTER_COLOR_Cyan              => CLUTTER_COLOR_CYAN,
  CLUTTER_COLOR_DarkCyan          => CLUTTER_COLOR_DARK_CYAN,
  CLUTTER_COLOR_Magenta           => CLUTTER_COLOR_MAGENTA,
  CLUTTER_COLOR_DarkMagenta       => CLUTTER_COLOR_DARK_MAGENTA,
  CLUTTER_COLOR_Yellow            => CLUTTER_COLOR_YELLOW,
  CLUTTER_COLOR_DarkYellow        => CLUTTER_COLOR_DARK_YELLOW,
  CLUTTER_COLOR_Gray              => CLUTTER_COLOR_GRAY,
  CLUTTER_COLOR_DarkGray          => CLUTTER_COLOR_DARK_GRAY,
  CLUTTER_COLOR_LightGray         => CLUTTER_COLOR_LIGHT_GRAY,
  CLUTTER_COLOR_Butter            => CLUTTER_COLOR_BUTTER,
  CLUTTER_COLOR_LightButter       => CLUTTER_COLOR_BUTTER_LIGHT,
  CLUTTER_COLOR_DarkButter        => CLUTTER_COLOR_BUTTER_DARK,
  CLUTTER_COLOR_Orange            => CLUTTER_COLOR_ORANGE,
  CLUTTER_COLOR_LightOrange       => CLUTTER_COLOR_ORANGE_LIGHT,
  CLUTTER_COLOR_DarkOrange        => CLUTTER_COLOR_ORANGE_DARK,
  CLUTTER_COLOR_Chocolate         => CLUTTER_COLOR_CHOCOLATE,
  CLUTTER_COLOR_LightChocolate    => CLUTTER_COLOR_CHOCOLATE_LIGHT,
  CLUTTER_COLOR_DarkChocolate     => CLUTTER_COLOR_CHOCOLATE_DARK,
  CLUTTER_COLOR_Chameleon         => CLUTTER_COLOR_CHAMELEON,
  CLUTTER_COLOR_LightChameleon    => CLUTTER_COLOR_CHAMELEON_LIGHT,
  CLUTTER_COLOR_DarkChameleon     => CLUTTER_COLOR_CHAMELEON_DARK,
  CLUTTER_COLOR_SkyBlue           => CLUTTER_COLOR_SKY_BLUE,
  CLUTTER_COLOR_LightSkyBlue      => CLUTTER_COLOR_SKY_BLUE_LIGHT,
  CLUTTER_COLOR_DarkSkyBlue       => CLUTTER_COLOR_SKY_BLUE_DARK,
  CLUTTER_COLOR_Plum              => CLUTTER_COLOR_PLUM,
  CLUTTER_COLOR_LightPlum         => CLUTTER_COLOR_PLUM_LIGHT,
  CLUTTER_COLOR_DarkPlum          => CLUTTER_COLOR_PLUM_DARK,
  CLUTTER_COLOR_ScarletRed        => CLUTTER_COLOR_SCARLET_RED,
  CLUTTER_COLOR_LightScarletRed   => CLUTTER_COLOR_SCARLET_RED_LIGHT,
  CLUTTER_COLOR_DarkScarletRed    => CLUTTER_COLOR_SCARLET_RED_DARK,
  CLUTTER_COLOR_Aluminium1        => CLUTTER_COLOR_ALUMINIUM_1,
  CLUTTER_COLOR_Aluminium2        => CLUTTER_COLOR_ALUMINIUM_2,
  CLUTTER_COLOR_Aluminium3        => CLUTTER_COLOR_ALUMINIUM_3,
  CLUTTER_COLOR_Aluminium4        => CLUTTER_COLOR_ALUMINIUM_4,
  CLUTTER_COLOR_Aluminium5        => CLUTTER_COLOR_ALUMINIUM_5,
  CLUTTER_COLOR_Aluminium6        => CLUTTER_COLOR_ALUMINIUM_6,
  CLUTTER_COLOR_Transparent       => CLUTTER_COLOR_TRANSPARENT,
);

our enum ClutterEventAction is export (
  CLUTTER_EVENT_PROPAGATE => 0,
  CLUTTER_EVENT_STOP      => 1,
);

our subset ColorOrStatic is export of Mu where 
  ClutterColor | ClutterStaticColor | ClutterStaticColorExtra;
