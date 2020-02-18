use v6.c;

use Cairo;

use NativeCall;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package Clutter::Raw::Definitions;

# Number of times a forced compile has been made.
constant forced = 9;

constant clutter is export = 'clutter-1.0',v0;

constant cairo_rectangle_int_t is export = Cairo::cairo_rectangle_int_t;

constant ClutterActorCreateChildFunc is export := Pointer;
constant ClutterProgressFunc         is export := Pointer;
constant ClutterTimelineProgressFunc is export := Pointer;

class ClutterAction                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterActor                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterActorMeta                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterAlignConstraint          is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterAlpha                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterAnimatable               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBackend                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBinLayout                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBindConstraint           is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBlurEffect               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBoxLayout                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterBrightnessContrastEffect is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterCanvas                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterChildMeta                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterConstraint               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterClickAction              is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterClone                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterContainer                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterContent                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterDragAction               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterDropAction               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterDeformEffect             is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterDesaturateEffect         is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterDeviceManager            is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterEffect                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterEventSequence            is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterFixedLayout              is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterFlowLayout               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterFog                      is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterGeometry                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterGestureAction            is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterGroup                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterGridLayout               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterGridLayoutMeta           is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterImage                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterInputDevice              is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterInterval                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterKeyframeTransition       is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterLayoutManager            is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterLayoutMeta               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterMargin                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterMatrix                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterOffscreenEffect          is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPageTurnEffect           is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPanAction                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPath                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPathConstraint           is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPaintVolume              is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterPropertyTransition       is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterSettings                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterScript                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterScrollActor              is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterScriptable               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterSnapConstraint           is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterStage                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterTapAction                is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterText                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterTextBuffer               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterTimeline                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterTransition               is repr<CPointer> does GLib::Roles::Pointers is export { }
class ClutterTransitionGroup          is repr<CPointer> does GLib::Roles::Pointers is export { }
