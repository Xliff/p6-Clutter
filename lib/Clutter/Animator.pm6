use v6.c;

use Clutter::Raw::Types;
use Clutter::Raw::Animator;

use GLib::GList;
use GLib::Value;
use Clutter::Actor;
use Clutter::Timeline;

use GLib::Roles::ListData;
use GLib::Roles::Object;
use Clutter::Roles::Scriptable;

class Clutter::Animator::Key { ... }

our subset ClutterAnimatorAncestry is export of Mu
  where ClutterAnimator | ClutterScriptable | GObject;

class Clutter::Animator {
  also does GLib::Roles::Object;
  also does Clutter::Roles::Scriptable;

  has ClutterAnimator $!anim is implementor;

  submethod BUILD (:$animator) {
    self.setClutterAnimator($animator) if $animator;
  }

  method setClutterAnimator (ClutterAnimatorAncestry $_) {
    my $to-parent;

    $!anim = do {
      when ClutterAnimator {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when ClutterScriptable {
        $to-parent = cast(GObject, $_);
        $!cs = $_;
        cast(ClutterAnimator, $_);
      }

      default {
        $to-parent = $_;
        cast(ClutterAnimator, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-ClutterScriptable;
  }

  method new {
    my $animator = clutter_animator_new();

    $animator ?? self.bless(:$animator) !! Nil;
  }

  method duration is rw {
    Proxy.new:
      FETCH => -> $           { self.get_duration    },
      STORE => -> $, Int() \d { self.set_duration(d) };
  }

  method timeline (:$raw = False) is rw {
    Proxy.new:
      FETCH => -> $                       { self.get_timeline(:$raw) },
      STORE => -> $, ClutterTimeline() \t { self.set_timeline(t)     };
  }

  proto method compute_value (|)
  { * }

  multi method compute_value (
    GObject() $object,
    Str()     $property_name,
    Num()     $progress,
              :$raw           = False
  ) {
    my $v = GValue.new;
    samewith($object, $property_name, $progress, $v);

    $raw ?? $v !! GLib::Value.new($v);
  }
  multi method compute_value (
    GObject() $object,
    Str()     $property_name,
    Num()     $progress,
    GValue()  $value
  ) {
    my gdouble $p = $progress;

    so clutter_animator_compute_value(
      $!anim,
      $object,
      $property_name,
      $progress,
      $value
    );
  }

  method get_duration {
    clutter_animator_get_duration($!anim);
  }

  method get_keys (
    GObject() $object,
    Str()     $property_name,
    Num()     $progress,
              :$glist         = False,
              :$raw           = False
  ) {
    my $kl = clutter_animator_get_keys(
      $!anim,
      $object,
      $property_name,
      $progress
    );

    return Nil unless $kl;
    return $kl if $glist && $raw;

    $kl = GLib::GList.new($kl) but GLib::Roles::ListData[ClutterAnimatorKey];

    $raw ?? $kl.Array
         !! $kl.Array({ Clutter::Animator::Key.new($_) });
  }

  method get_timeline (:$raw = False) {
    my $t = clutter_animator_get_timeline($!anim);

    $t ??
      ( $raw ?? $t !! Clutter::Timeline.new($t) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_animator_get_type, $n, $t );
  }

  method property_get_ease_in (GObject() $object, Str() $property_name) {
    so clutter_animator_property_get_ease_in($!anim, $object, $property_name);
  }

  method property_get_interpolation (GObject() $object, Str() $property_name) {
    ClutterInterpolationEnum(
      clutter_animator_property_get_interpolation(
        $!anim,
        $object,
        $property_name
      )
    );
  }

  method property_set_ease_in (
    GObject() $object,
    Str()     $property_name,
    Int()     $ease_in
  ) {
    my gboolean $e = $ease_in.so.Int;

    so clutter_animator_property_set_ease_in(
      $!anim,
      $object,
      $property_name,
      $e
    );
  }

  method property_set_interpolation (
    GObject() $object,
    Str()     $property_name,
    Int()     $interpolation
  ) {
    my ClutterInterpolation $i = $interpolation;

    clutter_animator_property_set_interpolation(
      $!anim,
      $object,
      $property_name,
      $i
    );
  }

  method remove_key (
    GObject() $object,
    Str()     $property_name,
    Num()     $progress
  ) {
    my gdouble $p = $progress;

    clutter_animator_remove_key($!anim, $object, $property_name, $p);
  }

  method set (*@keys) {
    die '@keys must be divisible by 5!' unless +@keys %% 5;

    for @keys.rotor(5) {
      say .gist;
      self.set_key( |$_ );
    }
  }

  method set_duration (Int() $duration) {
    my guint $d = $duration;

    clutter_animator_set_duration($!anim, $duration);
  }

  method set_key (
              $object         is copy,
    Str()     $property_name,
    Int()     $mode,
    Num()     $progress,
              $value          is copy
  ) {
    my guint   $m = $mode;
    my gdouble $p = $progress;

    die "Cannot use set_key on a non-Clutter::Actor, without a {
         '' }GValue-compatible value!"
      unless $object ~~ Clutter::Actor            ||
             $value  ~~ (GLib::Value, GValue).any;

    # cw: Must resolve value type based on property name!
    my $v = do if $value ~~ (GLib::Value, GValue).any {
      $value;
    } else {
      $object.?getAnimatableValue($property_name, $value);
    }
    die "No animatable value found for '{ $property_name }'" unless $v;
    $v      .= GValue  if $v.^lookup('GValue');
    $object .= GObject if $object.^lookup('GObject');

    clutter_animator_set_key($!anim, $object, $property_name, $m, $p, $v);
    self;
  }

  method set_timeline (ClutterTimeline $timeline) {
    clutter_animator_set_timeline($!anim, $timeline);
  }

  method start (:$raw = False) {
    my $a = clutter_animator_start($!anim);

    $a ??
      ( $raw ?? $a !! Clutter::Timeline.new($a) )
      !!
      Nil;
  }

}

 class Clutter::Animator::Key {
   has ClutterAnimatorKey $!ak;

   submethod BUILD ( :animator-key(:$!ak) ) { }

   multi method new (ClutterAnimatorKey $animator-key) {
     $animator-key ?? self.bless(:$animator-key) !! Nil;
   }
   multi method new {
     my $animator-key = ClutterAnimatorKey.new;

     $animator-key ?? self.bless(:$animator-key) !! Nil;
   }

   method get_mode {
     clutter_animator_key_get_mode($!ak);
   }

   method get_object (:$raw = False) {
     my $o = clutter_animator_key_get_object($!ak);

     $o ??
      ( $raw ?? $o !! GLib::Roles::Object.new-object-obj($o) )
      !!
      Nil;
   }

   method get_progress {
     clutter_animator_key_get_progress($!ak);
   }

   method get_property_name {
     clutter_animator_key_get_property_name($!ak);
   }

   method get_property_type (:$enums = True) {
     my $v = clutter_animator_key_get_property_type($!ak);
     if $enums {
       return GTypeEnum($v) if $v = GTypeEnum.enums.values.any;
     }
     $v;
   }

   method get_type {
     state ($n, $t);

     unstable_get_type( self.^name, &clutter_animator_key_get_type, $n, $t );
   }

   proto method get_value (|)
   { * }

   multi method get_value (:$raw = False) {
     my $v = GValue.new;
     samewith($v);

     $v ??
       ( $raw ?? $v !! GLib::Value.new($v) )
       !!
       Nil;
   }
   multi method get_value (GValue() $value) {
     clutter_animator_key_get_value($!ak, $value);
   }

 }
