use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::BindConstraint;

use Clutter::Constraint;

class Clutter::BindConstraint is Clutter::Constraint {
  has ClutterBindConstraint $!cb;
  
  submethod BUILD (:$bindconstraint) {
    self.setConstraint( cast(ClutterConstraint, $!cb = $bindconstraint) );
  }
  
  method Clutter::Raw::Definitions::ClutterBindConstraint
    is also<ClutterBindConstraint>
  { $!cb }
  
  method new (
    ClutterActor() $source,
    Int() $coordinate, # ClutterBindCoordinate $coordinate, 
    Num() $offset      # gfloat $offset
  ) {
    my gfloat $o = $offset;
    my guint $c = resolve-uint($coordinate);
    self.bless( 
      bindconstraint => clutter_bind_constraint_new($source, $c, $o)
    );
  }
  
  method get_coordinate is also<get-coordinate> {
    clutter_bind_constraint_get_coordinate($!cb);
  }

  method get_offset is also<get-offset> {
    clutter_bind_constraint_get_offset($!cb);
  }

  method get_source is also<get-source> {
    ::('Clutter::Actor').new( clutter_bind_constraint_get_source($!cb) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_bind_constraint_get_type, $n, $t );
  }

  method set_coordinate (Int() $coordinate) is also<set-coordinate> {
    my guint $c = resolve-uint($coordinate);
    clutter_bind_constraint_set_coordinate($!cb, $c);
  }

  method set_offset (Num() $offset) is also<set-offset> {
    my gfloat $o = $offset;
    clutter_bind_constraint_set_offset($!cb, $o);
  }

  method set_source (ClutterActor() $source) is also<set-source> {
    clutter_bind_constraint_set_source($!cb, $source);
  }

}
