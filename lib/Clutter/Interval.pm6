use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::Interval;

use GLib::Value;

class Clutter::Interval {
  has ClutterInterval $!ci is implementor;

  submethod BUILD (:$interval) {
    $!ci = $interval;
  }

  method Clutter::Raw::Definitions::ClutterInterval
    is also<ClutterInterval>
  { $!ci }

  multi method new (ClutterInterval $interval) {
    $interval ?? self.bless(:$interval) !! Nil;
  }
  multi method new (GValue() $initial, GValue() $final) {
    self.new_with_values($initial, $final);
  }

  method new_with_values (GValue() $initial, GValue() $final)
    is also<new-with-values>
  {
    my $interval = clutter_interval_new_with_values($!ci, $initial, $final);

    $interval ?? self.bless(:$interval) !! Nil
  }

  method clone (:$raw = False) {
    my $c = clutter_interval_clone($!ci);

    $c ??
      ( $raw ?? $c !! Clutter::Interval.new($c) )
      !!
      GValue;
  }

  method compute (Num() $factor) {
    my gdouble $f = $factor;

    clutter_interval_compute($!ci, $f);
  }

  method compute_value (Num() $factor, GValue() $value, :$raw = False)
    is also<compute-value>
  {
    my gdouble $f = $factor;
    my $v = clutter_interval_compute_value($!ci, $f, $value);

    $v ??
      ( $raw ?? $v !! GLib::Value.new($v) )
      !!
      GValue;
  }

  method get_final_value (GValue() $value) is also<get-final-value> {
    clutter_interval_get_final_value($!ci, $value);
  }

  method get_initial_value (GValue() $value) is also<get-initial-value> {
    clutter_interval_get_initial_value($!ci, $value);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_interval_get_type, $n, $t );
  }

  method get_value_type is also<get-value-type> {
    GTypeEnum( clutter_interval_get_value_type($!ci) );
  }

  method is_valid is also<is-valid> {
    so clutter_interval_is_valid($!ci);
  }

  method peek_final_value (:$raw = False) is also<peek-final-value> {
    my $v = clutter_interval_peek_final_value($!ci);

    $v ??
      ( $raw ?? $v !! GLib::Value.new($v) )
      !!
      GValue;
  }

  method peek_initial_value (:$raw = False) is also<peek-initial-value> {
    my $v = clutter_interval_peek_initial_value($!ci);

    $v ??
      ( $raw ?? $v !! GLib::Value.new($v) )
      !!
      GValue;
  }

  method set_final_value (GValue() $value) is also<set-final-value> {
    clutter_interval_set_final_value($!ci, $value);
  }

  method set_initial_value (GValue() $value) is also<set-initial-value> {
    clutter_interval_set_initial_value($!ci, $value);
  }

  method validate (GParamSpec() $pspec) {
    clutter_interval_validate($!ci, $pspec);
  }

}
