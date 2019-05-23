use v6.c;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::Raw::Color;

class Clutter::Color {
  has ClutterColor $!cc;

  submethod BUILD (:$color) {
    $!cc = $color;
  }

  method new {
    self.bless( color => clutter_color_alloc() );
  }

  method new (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  ) {
    my ($r, $g, $b, $a) = resolve-uint8($r, $g, $b, $a);
    self.bless( color => clutter_color_new($r, $g, $b, $a) );
  }

  method new_from_hls (
    Clutter::Color:U:
    Num() $hue,
    Num() $luminance,
    Num() $saturation
  )
    is also<new-from-hls>
  {
    my $c = ClutterColor.new;
    my gfloat ($h, $l, $s) = ($hue, $luminance, $saturation);
    clutter_color_from_hls($c, $h, $l, $s);
    self.bless( color => $c );
  }

  method new_from_pixel (Clutter::Color:U: Int() $pixel)
    is also<new-from-pixel>
  {
    my $c = ClutterColor.new
    my guint $p = resolve-uint($pixel);
    clutter_color_from_pixel($c, $p);
    self.bless( color => $c );
  }

  method new_from_string (
    Clutter::Color:U: Str() $str
  )
    is also<new-from-string>
  {
    my $c = ClutterColor.new;
    clutter_color_from_string($c, $str);
    self.bless( color => $c );
  }

  method get_static (Clutter::Color:U: Int() $static) is also<get-static> {
    my guint $s = resolve-uint($static);
    self.bless( color => clutter_color_get_static($s) );
  }

  multi method add (Clutter::Color:D: ClutterColor() $b) {
    my $c = ClutterColor.new;
    samewith($b, $c);
    self.bless( color => $c );
  }
  multi method add (
    Clutter::Color:D:
    ClutterColor() $b,
    ClutterColor() $result
  ) {
    clutter_color_add($!cc, $b, $result);
  }

  method copy (Clutter::Color:D:) {
    self.bless( color => clutter_color_copy($!cc) );
  }

  method alloc {
    clutter_color_alloc($!cc);
  }

  multi method darken (Clutter::Color:D:) {
    Clutter::Color.darken(($!cc);
  }
  multi method darken (Clutter::Color:U: ClutterColor() $color) {
    my $c = ClutterColor.new;
    clutter_color_darken($color, $c);
    self.bless( color => $c );
  }

  method equal (Clutter::Color:U: ClutterColor() $v1, ClutterColor() $v2) {
    clutter_color_equal($v1, $v2);
  }
  method equal (ClutterColor() $v2) {
    clutter_color_equal($!cc, $v2);
  }

  method free (Clutter::Color:U ClutterColor() $c) {
    clutter_color_free($c);
  }
  method free {
    Clutter::Color($!cc);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_color_get_type, $n, $t );
  }

  method hash (Clutter::Color:U: ClutterColor() $c) {
    clutter_color_hash($c);
  }
  method hash {
    Clutter::Color.hash($!cc);
  }

  method init (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  ) {
    my $c = ClutterColor.new;
    my guint8 ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);
    clutter_color_init($c, $r, $g, $b, $a);
    $c;
  }

  method interpolate (ClutterColor() $final, Num() $progress) {
    Clutter::Color.interpolate($!cc, $final, $progress);
  }
  multi method interpolate (
    Clutter::Color:U:
    ClutterColor() $a,
    ClutterColor() $b,
    Num() $progress
  ) {
    my $c = ClutterColor.new;
    clutter_color_interpolate($a, $b, $p, $c);
    self.bless( color => $c );
  }

  multi method lighten (Clutter::Color:U: ClutterColor() $color) {
    self.bless( color => clutter_color_lighten($!cc, $result) );
  }
  multi method lighten {
    Clutter::Color.lighten($!cc);
  }

  method shade (
    Clutter::Color:U:
    ClutterColor() $color,
    Num() $factor
  ) {
    my $c = ClutterColor.new;
    my gdouble $f = $factor;
    self.bless( color => clutter_color_shade($!cc, $f, $c) );
  }
  method shade (Num() $factor) {
    Clutter::Color.shade($!cc, $factor);
  }

  method subtract (
    Clutter::Color:U:
    ClutterColor() $a,
    ClutterColor() $b
  ) {
    my $c = ClutterColor.new;
    clutter_color_subtract($a, $b, $c);
    self.bless( color => $c );
  }
  method subtract (ClutterColor $b) {
    Clutter::Color.subtract($!cc, $b);
  }

  method to_hls (
    Clutter::Color::U:
    ClutterColor() $c,
    Num() $hue        is rw,
    Num() $luminance  is rw,
    Num() $saturation is rw
  ) is also<to-hls> {
    my gdouble ($h, $l, $s) = ($hue, $luminance, $saturation);
    clutter_color_to_hls($c, $hue, $luminance, $saturation);
    ($hue, $luminance, $saturation) = ($h, $l, $s);
  }
  method to_hls is also<to-hls> {
    my ($h, $l, $s) = 0 xx 3;
    Clutter::Color.to_hls($!cc, $h, $l, $s);
  }

  method to_pixel is also<to-pixel> {
    clutter_color_to_pixel($!cc);
  }

  method to_string is also<to-string> {
    clutter_color_to_string($!cc);
  }

  method param_color_get_type is also<clutter-param-color-get-type> {
    state ($n, $t);
    unstable_get_typeclutter_param_color_get_type();
  }

  method param_spec_color (
    Clutter::Color:U:
    Str() $nick,
    Str() $blurb,
    ClutterColor() $default_value,
    Int() $flags # GParamFlags $flags
  )
    is also<clutter-param-spec-color>
  {
    my guint $f = resolve-uint($flags);
    clutter_param_spec_color($nick, $blurb, $default_value, $f);
  }

  method get_from_value (GValue() $val) is also<get-from-value> {
    $!cc = clutter_value_get_color($val);
  }

  method set_to_value (GValue() $val) is also<set-to-value> {
    clutter_value_set_color($val, $!ccs);
  }

}
