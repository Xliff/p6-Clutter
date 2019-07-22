use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Animatable;

role Clutter::Roles::Animatable {
  has ClutterAnimatable $!c-anim;
  
  method Clutter::Raw::Types::Animatable 
    is also<Animatable>
  { $!c-anim }

  method setAnimatable ($animatable) {
    self.IS-PROTECTED;
    $!c-anim = $animatable;
  }

  method find_property (Str() $property_name)
    is also<find-property>
  {
    clutter_animatable_find_property($!c-anim, $property_name);
  }

  method get_initial_state (Str() $property_name, GValue() $value)
    is also<get-initial-state>
  {
    clutter_animatable_get_initial_state($!c-anim, $property_name, $value);
  }

  method animatable_get_type is also<animatable-get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_animatable_get_type, $n, $t );
  }

  method interpolate_value (
    Str() $property_name,
    ClutterInterval() $interval,
    Num() $progress,
    GValue() $value
  )
    is also<interpolate-value>
  {
    my gdouble $p = $progress;
    clutter_animatable_interpolate_value(
      $!c-anim,
      $property_name,
      $interval,
      $p,
      $value
    );
  }

  method set_final_state (Str() $property_name, GValue() $value)
    is also<set-final-state>
  {
    clutter_animatable_set_final_state($!c-anim, $property_name, $value);
  }

}
