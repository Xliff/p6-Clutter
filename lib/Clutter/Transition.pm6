use v6.c;

use Method::Also;


use Clutter::Raw::Types;



use Clutter::Raw::Transition;

use GTK::Roles::Properties;
use GTK::Roles::Protection;

use Clutter::Timeline;

my @attributes = <
  animatable
  interval
  remove_on_complete    remove-on-complete
>;

my @set-methods = <
  from_value            from-value
  to_value              to-value
>;

class Clutter::Transition is Clutter::Timeline {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Protection;

  has ClutterTransition $!ct;

  submethod BUILD (:$transition) {
    self.setTransition($transition) if $transition.defined;
  }

  method setTransition (ClutterTransition $transition) {
    #self.IS-PROTECTED;
    self.setTimeline( cast(ClutterTimeline, $!ct = $transition) );
  }

  method Clutter::Raw::Definitions::ClutterTransition
    is also<ClutterTransition>
  { $!ct }

  method new (ClutterTransition $transition) {
    self.bless(:$transition);
  }

  method setup (*%data) {
    for %data.keys -> $_ is copy {
      when @attributes.any  {
        say "TrA: {$_}" if $DEBUG;
        self."$_"() = %data{$_};
        %data{$_}:delete;
      }

      when @set-methods.any {
        my $proper-name = S:g/_/-/;
        say "TrSM: {$_}" if $DEBUG;
        self."set-{ $proper-name }"( |%data{$_} );
        %data{$_}:delete;
      }

      when 'from' {
        say "Tr from = { %data<from>.value }" if $DEBUG;
        self.set-from-value( %data<from> );
        %data<from>:delete;

      }
      when 'to' {
        say "Tr to = { %data<to>.value }" if $DEBUG;
        self.set-to-value( %data<to> );
        %data<to>:delete;
      }
    }

    self.Clutter::Timeline::setup( |%data ) if %data.keys;
    self;
  }

  method animatable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Animatable.new( clutter_transition_get_animatable($!ct) );
      },
      STORE => sub ($, ClutterAnimatable() $animatable is copy) {
        clutter_transition_set_animatable($!ct, $animatable);
      }
    );
  }

  method interval is rw {
    Proxy.new(
      FETCH => sub ($) {
        Clutter::Interval.new( clutter_transition_get_interval($!ct) );
      },
      STORE => sub ($, ClutterInterval() $interval is copy) {
        clutter_transition_set_interval($!ct, $interval);
      }
    );
  }

  method remove_on_complete is rw is also<remove-on-complete> {
    Proxy.new(
      FETCH => sub ($) {
        so clutter_transition_get_remove_on_complete($!ct);
      },
      STORE => sub ($, Int() $remove_complete is copy) {
        my gboolean $rc = resolve-bool($remove_complete);
        clutter_transition_set_remove_on_complete($!ct, $rc);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_transition_get_type, $n, $t );
  }

  method set_from_value (GValue() $value) is also<set-from-value> {
    clutter_transition_set_from_value($!ct, $value);
  }

  method set_to_value (GValue() $value) is also<set-to-value> {
    clutter_transition_set_to_value($!ct, $value);
  }

}
