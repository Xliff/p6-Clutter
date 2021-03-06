use v6.c;

use GLib::Raw::Definitions;

unit package Clutter::Raw::Enums;

constant ClutterActorAlign is export := guint32;
our enum ClutterActorAlignEnum is export <
  CLUTTER_ACTOR_ALIGN_FILL
  CLUTTER_ACTOR_ALIGN_START
  CLUTTER_ACTOR_ALIGN_CENTER
  CLUTTER_ACTOR_ALIGN_END
>;

constant ClutterScrollFinishFlags is export := guint32;
our enum ClutterScrollFinishFlagsEnum is export (
  CLUTTER_SCROLL_FINISHED_NONE       => 0,
  CLUTTER_SCROLL_FINISHED_HORIZONTAL => 1,
  CLUTTER_SCROLL_FINISHED_VERTICAL   => 1 +< 1,
);

constant ClutterScalingFilter is export := guint32;
our enum ClutterScalingFilterEnum is export <
  CLUTTER_SCALING_FILTER_LINEAR
  CLUTTER_SCALING_FILTER_NEAREST
  CLUTTER_SCALING_FILTER_TRILINEAR
>;

constant ClutterRequestMode is export := guint32;
our enum ClutterRequestModeEnum is export <
  CLUTTER_REQUEST_HEIGHT_FOR_WIDTH
  CLUTTER_REQUEST_WIDTH_FOR_HEIGHT
  CLUTTER_REQUEST_CONTENT_SIZE
>;

constant ClutterSnapEdge is export := guint32;
our enum ClutterSnapEdgeEnum is export <
  CLUTTER_SNAP_EDGE_TOP
  CLUTTER_SNAP_EDGE_RIGHT
  CLUTTER_SNAP_EDGE_BOTTOM
  CLUTTER_SNAP_EDGE_LEFT
>;

constant ClutterLongPressState is export := guint32;
our enum ClutterLongPressStateEnum is export <
  CLUTTER_LONG_PRESS_QUERY
  CLUTTER_LONG_PRESS_ACTIVATE
  CLUTTER_LONG_PRESS_CANCEL
>;

constant ClutterBindCoordinate is export := guint32;
our enum ClutterBindCoordinateEnum is export <
  CLUTTER_BIND_X
  CLUTTER_BIND_Y
  CLUTTER_BIND_WIDTH
  CLUTTER_BIND_HEIGHT
  CLUTTER_BIND_POSITION
  CLUTTER_BIND_SIZE
  CLUTTER_BIND_ALL
>;

constant ClutterAllocationFlags is export := guint32;
our enum ClutterAllocationFlagsEnum is export (
  CLUTTER_ALLOCATION_NONE         => 0,
  CLUTTER_ABSOLUTE_ORIGIN_CHANGED => 1 +< 1,
  CLUTTER_DELEGATE_LAYOUT         => 1 +< 2,
);

constant ClutterAnimationMode is export := guint32;
our enum ClutterAnimationModeEnum is export (
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

constant ClutterPanAxis is export := guint32;
our enum ClutterPanAxisEnum is export (
  CLUTTER_PAN_AXIS_NONE =>  0,
  'CLUTTER_PAN_X_AXIS',
  'CLUTTER_PAN_Y_AXIS',
  'CLUTTER_PAN_AXIS_AUTO'
);

constant ClutterTextureError is export := guint32;
our enum ClutterTextureErrorEnum is export <
  CLUTTER_TEXTURE_ERROR_OUT_OF_MEMORY
  CLUTTER_TEXTURE_ERROR_NO_YUV
  CLUTTER_TEXTURE_ERROR_BAD_FORMAT
>;

constant ClutterGridPosition is export := guint32;
our enum ClutterGridPositionEnum is export <
  CLUTTER_GRID_POSITION_LEFT
  CLUTTER_GRID_POSITION_RIGHT
  CLUTTER_GRID_POSITION_TOP
  CLUTTER_GRID_POSITION_BOTTOM
>;

constant ClutterInputDeviceType is export := guint32;
our enum ClutterInputDeviceTypeEnum is export <
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

constant ClutterShaderType is export := guint32;
our enum ClutterShaderTypeEnum is export <
  CLUTTER_VERTEX_SHADER
  CLUTTER_FRAGMENT_SHADER
>;

constant ClutterRepaintFlags is export := guint32;
our enum ClutterRepaintFlagsEnum is export (
  CLUTTER_REPAINT_FLAGS_PRE_PAINT           => 1,
  CLUTTER_REPAINT_FLAGS_POST_PAINT          => 1 +< 1,
  CLUTTER_REPAINT_FLAGS_QUEUE_REDRAW_ON_ADD => 1 +< 2,
);

constant ClutterGestureTriggerEdge is export := guint32;
our enum ClutterGestureTriggerEdgeEnum is export (
  CLUTTER_GESTURE_TRIGGER_EDGE_NONE =>  0,
  'CLUTTER_GESTURE_TRIGGER_EDGE_AFTER',
  'CLUTTER_GESTURE_TRIGGER_EDGE_BEFORE'
);

constant ClutterContentGravity is export := guint32;
our enum ClutterContentGravityEnum is export <
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

constant ClutterTimelineDirection is export := guint32;
our enum ClutterTimelineDirectionEnum is export <
  CLUTTER_TIMELINE_FORWARD
  CLUTTER_TIMELINE_BACKWARD
>;

constant ClutterSwipeDirection is export := guint32;
our enum ClutterSwipeDirectionEnum is export (
  CLUTTER_SWIPE_DIRECTION_UP    => 1,
  CLUTTER_SWIPE_DIRECTION_DOWN  => 1 +< 1,
  CLUTTER_SWIPE_DIRECTION_LEFT  => 1 +< 2,
  CLUTTER_SWIPE_DIRECTION_RIGHT => 1 +< 3,
);

constant ClutterPickMode is export := guint32;
our enum ClutterPickModeEnum is export (
  CLUTTER_PICK_NONE => 0,
  'CLUTTER_PICK_REACTIVE',
  'CLUTTER_PICK_ALL'
);

constant ClutterFlowOrientation is export := guint32;
our enum ClutterFlowOrientationEnum is export <
  CLUTTER_FLOW_HORIZONTAL
  CLUTTER_FLOW_VERTICAL
>;

constant ClutterScriptError is export := guint32;
our enum ClutterScriptErrorEnum is export <
  CLUTTER_SCRIPT_ERROR_INVALID_TYPE_FUNCTION
  CLUTTER_SCRIPT_ERROR_INVALID_PROPERTY
  CLUTTER_SCRIPT_ERROR_INVALID_VALUE
>;

constant ClutterGravity is export := guint32;
our enum ClutterGravityEnum is export (
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

constant ClutterTableAlignment is export := guint32;
our enum ClutterTableAlignmentEnum is export <
  CLUTTER_TABLE_ALIGNMENT_START
  CLUTTER_TABLE_ALIGNMENT_CENTER
  CLUTTER_TABLE_ALIGNMENT_END
>;

constant ClutterImageError is export := guint32;
our enum ClutterImageErrorEnum is export <
  CLUTTER_IMAGE_ERROR_INVALID_DATA
>;

constant ClutterZoomAxis is export := guint32;
our enum ClutterZoomAxisEnum is export <
  CLUTTER_ZOOM_X_AXIS
  CLUTTER_ZOOM_Y_AXIS
  CLUTTER_ZOOM_BOTH
>;

constant ClutterStepMode is export := guint32;
our enum ClutterStepModeEnum is export <
  CLUTTER_STEP_MODE_START
  CLUTTER_STEP_MODE_END
>;

constant ClutterBinAlignment is export := guint32;
our enum ClutterBinAlignmentEnum is export <
  CLUTTER_BIN_ALIGNMENT_FIXED
  CLUTTER_BIN_ALIGNMENT_FILL
  CLUTTER_BIN_ALIGNMENT_START
  CLUTTER_BIN_ALIGNMENT_END
  CLUTTER_BIN_ALIGNMENT_CENTER
>;

constant ClutterScrollDirection is export := guint32;
our enum ClutterScrollDirectionEnum is export <
  CLUTTER_SCROLL_UP
  CLUTTER_SCROLL_DOWN
  CLUTTER_SCROLL_LEFT
  CLUTTER_SCROLL_RIGHT
  CLUTTER_SCROLL_SMOOTH
>;

constant ClutterEventFlags is export := guint32;
our enum ClutterEventFlagsEnum is export (
  CLUTTER_EVENT_NONE           => 0,
  CLUTTER_EVENT_FLAG_SYNTHETIC => 1,
);

constant ClutterOrientation is export := guint32;
our enum ClutterOrientationEnum is export <
  CLUTTER_ORIENTATION_HORIZONTAL
  CLUTTER_ORIENTATION_VERTICAL
>;

constant ClutterShaderError is export := guint32;
our enum ClutterShaderErrorEnum is export <
  CLUTTER_SHADER_ERROR_NO_ASM
  CLUTTER_SHADER_ERROR_NO_GLSL
  CLUTTER_SHADER_ERROR_COMPILE
>;

constant ClutterInputMode is export := guint32;
our enum ClutterInputModeEnum is export <
  CLUTTER_INPUT_MODE_MASTER
  CLUTTER_INPUT_MODE_SLAVE
  CLUTTER_INPUT_MODE_FLOATING
>;

constant ClutterInputAxis is export := guint32;
our enum ClutterInputAxisEnum is export <
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

constant ClutterBoxAlignment is export := guint32;
our enum ClutterBoxAlignmentEnum is export <
  CLUTTER_BOX_ALIGNMENT_START
  CLUTTER_BOX_ALIGNMENT_END
  CLUTTER_BOX_ALIGNMENT_CENTER
>;

constant ClutterRotateAxis is export := guint32;
our enum ClutterRotateAxisEnum is export <
  CLUTTER_X_AXIS
  CLUTTER_Y_AXIS
  CLUTTER_Z_AXIS
>;

constant ClutterScrollSource is export := guint32;
our enum ClutterScrollSourceEnum is export <
  CLUTTER_SCROLL_SOURCE_UNKNOWN
  CLUTTER_SCROLL_SOURCE_WHEEL
  CLUTTER_SCROLL_SOURCE_FINGER
  CLUTTER_SCROLL_SOURCE_CONTINUOUS
>;

constant ClutterTouchpadGesturePhase is export := guint32;
our enum ClutterTouchpadGesturePhaseEnum is export <
  CLUTTER_TOUCHPAD_GESTURE_PHASE_BEGIN
  CLUTTER_TOUCHPAD_GESTURE_PHASE_UPDATE
  CLUTTER_TOUCHPAD_GESTURE_PHASE_END
  CLUTTER_TOUCHPAD_GESTURE_PHASE_CANCEL
>;

constant ClutterAlignAxis is export := guint32;
our enum ClutterAlignAxisEnum is export <
  CLUTTER_ALIGN_X_AXIS
  CLUTTER_ALIGN_Y_AXIS
  CLUTTER_ALIGN_BOTH
>;

constant ClutterDragAxis is export := guint32;
our enum ClutterDragAxisEnum is export (
  CLUTTER_DRAG_AXIS_NONE =>  0,
  'CLUTTER_DRAG_X_AXIS',
  'CLUTTER_DRAG_Y_AXIS'
);

constant ClutterTextDirection is export := guint32;
our enum ClutterTextDirectionEnum is export <
  CLUTTER_TEXT_DIRECTION_DEFAULT
  CLUTTER_TEXT_DIRECTION_LTR
  CLUTTER_TEXT_DIRECTION_RTL
>;

constant ClutterActorFlags is export := guint32;
our enum ClutterActorFlagsEnum is export (
  CLUTTER_ACTOR_MAPPED    => 1 +< 1,
  CLUTTER_ACTOR_REALIZED  => 1 +< 2,
  CLUTTER_ACTOR_REACTIVE  => 1 +< 3,
  CLUTTER_ACTOR_VISIBLE   => 1 +< 4,
  CLUTTER_ACTOR_NO_LAYOUT => 1 +< 5,
);

constant ClutterTextureQuality is export := guint32;
our enum ClutterTextureQualityEnum is export <
  CLUTTER_TEXTURE_QUALITY_LOW
  CLUTTER_TEXTURE_QUALITY_MEDIUM
  CLUTTER_TEXTURE_QUALITY_HIGH
>;

constant ClutterUnitType is export := guint32;
our enum ClutterUnitTypeEnum is export <
  CLUTTER_UNIT_PIXEL
  CLUTTER_UNIT_EM
  CLUTTER_UNIT_MM
  CLUTTER_UNIT_POINT
  CLUTTER_UNIT_CM
>;

constant ClutterEventType is export := guint32;
our enum ClutterEventTypeEnum is export (
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

constant ClutterInterpolation is export := guint32;
our enum ClutterInterpolationEnum is export <
  CLUTTER_INTERPOLATION_LINEAR
  CLUTTER_INTERPOLATION_CUBIC
>;

constant ClutterRotateDirection is export := guint32;
our enum ClutterRotateDirectionEnum is export <
  CLUTTER_ROTATE_CW
  CLUTTER_ROTATE_CCW
>;

constant ClutterOffscreenRedirect is export := guint32;
our enum ClutterOffscreenRedirectEnum is export (
  CLUTTER_OFFSCREEN_REDIRECT_AUTOMATIC_FOR_OPACITY => 1,
  CLUTTER_OFFSCREEN_REDIRECT_ALWAYS                => 1 +< 1,
);

constant ClutterContentRepeat is export := guint32;
our enum ClutterContentRepeatEnum is export (
  CLUTTER_REPEAT_NONE   => 0,
  CLUTTER_REPEAT_X_AXIS => 1,
  CLUTTER_REPEAT_Y_AXIS => 1 +< 1,
  CLUTTER_REPEAT_BOTH   => 3
);

constant ClutterStaticColor is export := guint32;
our enum ClutterStaticColorEnum is export (
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

constant ClutterEventAction is export := guint32;
our enum ClutterEventActionEnum is export (
  CLUTTER_EVENT_PROPAGATE => 0,
  CLUTTER_EVENT_STOP      => 1,
);

constant ClutterModifierType is export := guint32;
our enum ClutterModifierTypeEnum is export (
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

constant ClutterButtonPress is export := guint32;
our enum ClutterButtonPressEnum is export (
  CLUTTER_BUTTON_PRIMARY => 1,
  'CLUTTER_BUTTON_MIDDLE',
  'CLUTTER_BUTTON_SECONDARY'
);

constant ClutterPathNodeType is export := guint32;
our enum ClutterPathNodeTypeEnum is export (
  CLUTTER_PATH_MOVE_TO      => 0,
  CLUTTER_PATH_LINE_TO      => 1,
  CLUTTER_PATH_CURVE_TO     => 2,
  CLUTTER_PATH_CLOSE        => 3,
  CLUTTER_PATH_RELATIVE     => 32,

  CLUTTER_PATH_REL_MOVE_TO  => 32, # CLUTTER_PATH_MOVE_TO | CLUTTER_PATH_RELATIVE,
  CLUTTER_PATH_REL_LINE_TO  => 33, # CLUTTER_PATH_LINE_TO | CLUTTER_PATH_RELATIVE,
  CLUTTER_PATH_REL_CURVE_TO => 34, # CLUTTER_PATH_CURVE_TO | CLUTTER_PATH_RELATIVE
);

constant ClutterInitError is export := gint32;
our enum ClutterInitErrorEnum is export (
  CLUTTER_INIT_SUCCESS        =>  1,
  CLUTTER_INIT_ERROR_UNKNOWN  =>  0,
  CLUTTER_INIT_ERROR_THREADS  => -1,
  CLUTTER_INIT_ERROR_BACKEND  => -2,
  CLUTTER_INIT_ERROR_INTERNAL => -3
);

constant ClutterScrollMode is export := guint32;
our enum ClutterScrollModeEnum is export (
  CLUTTER_SCROLL_NONE         => 0,
  CLUTTER_SCROLL_HORIZONTALLY => 1,
  CLUTTER_SCROLL_VERTICALLY   => 2,
  CLUTTER_SCROLL_BOTH         => 3  # CLUTTER_SCROLL_HORIZONTALLY | CLUTTER_SCROLL_VERTICALLY
);
