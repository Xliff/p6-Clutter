use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Animatable;

role Clutter::Roles::Animatable {
  has ClutterAnimatable $!canim;

  method setAnimatable ($animatable) {
    self.IS-PROTECTED;
    $!canim = $animatable;
  }

  method find_property (Str() $property_name)
    is also<find-property>
  {
    clutter_animatable_find_property($!canim, $property_name);
  }

  method get_initial_state (Str() $property_name, GValue() $value)
    is also<get-initial-state>
  {
    clutter_animatable_get_initial_state($!canim, $property_name, $value);
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
      $!canim,
      $property_name,
      $interval,
      $p,
      $value
    );
  }

  method set_final_state (Str() $property_name, GValue() $value)
    is also<set-final-state>
  {
    clutter_animatable_set_final_state($!canim, $property_name, $value);
  }

}
