use v6.c;

use Method::Also;


use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::Color;

# Boxed

class Clutter::Color {
  has ClutterColor $!cc handles <red green blue alpha gist perl>;

  submethod BUILD (:$color) {
    $!cc = $color;
  }

  method Clutter::Raw::Types::ClutterColor
    is also<ClutterColor>
  { $!cc }

  multi method new (ClutterColor $color) {
    self.bless(:$color)
  }
  multi method new {
    self.bless( color => clutter_color_alloc() );
  }
  multi method new (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  ) {
    my ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);
    self.bless( color => clutter_color_new($r, $g, $b, $a) );
  }

  method new_from_hls (
    Clutter::Color:U:
    Num() $hue,
    Num() $luminance,
    Num() $saturation,
    :$alpha is copy
  )
    is also<new-from-hls>
  {
    my $c = ClutterColor.new;
    if $alpha.defined {
      die '$alpha is not Int-compatible' unless $alpha.^can('Int').elems;
      $alpha .= Int;
    }
    my gfloat ($h, $l, $s) = ($hue, $luminance, $saturation);
    clutter_color_from_hls($c, $h, $l, $s);
    $c.alpha = $alpha if $alpha.defined;
    self.bless( color => $c );
  }

  method new_from_pixel (Clutter::Color:U: Int() $pixel)
    is also<new-from-pixel>
  {
    my $c = ClutterColor.new;
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

  method new_from_color (
    Clutter::Color:U:
    ClutterColor() $color
  )
    is also<new-from-color>
  {
    self.bless(
      color => ClutterColor.new(
        red   => $color.red,
        green => $color.green,
        blue  => $color.blue,
        alpha => $color.alpha
      )
    );
  }

  method get_static (Clutter::Color:U: $static is copy)
    is also<get-static>
  {
    die qq:to/DIE/.chomp unless $static ~~ Int || $static.^can('Int').elems;
Clutter::Color.get_static only takes a ClutterStaticColor or Int-compatible
parameter. The type passed was { $static.^name }
DIE

    $static .= Int;
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
    $result
  }

  method copy (Clutter::Color:D:) {
    self.bless( color => clutter_color_copy($!cc) );
  }

  method alloc {
    clutter_color_alloc();
  }

  multi method darken (Clutter::Color:D:) {
    Clutter::Color.darken($!cc);
  }
  multi method darken (Clutter::Color:U: ClutterColor() $color) {
    my $c = ClutterColor.new;
    clutter_color_darken($color, $c);
    self.bless( color => $c );
  }

  multi method equal (Clutter::Color:U: ClutterColor() $v1, ClutterColor() $v2) {
    clutter_color_equal($v1.p, $v2.p);
  }
  multi method equal (ClutterColor() $v2) {
    clutter_color_equal($!cc.p, $v2.p);
  }

  multi method free (Clutter::Color:U: ClutterColor() $c) {
    clutter_color_free($c);
  }
  multi method free {
    Clutter::Color($!cc);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_color_get_type, $n, $t );
  }

  multi method hash (Clutter::Color:U: ClutterColor() $c) {
    clutter_color_hash($c);
  }
  multi method hash {
    Clutter::Color.hash($!cc);
  }

  method init (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  ) {
    my $c = ClutterColor.new;
    say 'color init';
    my guint8 ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);
    clutter_color_init($c, $r, $g, $b, $a);
    $c;
  }

  multi method interpolate (ClutterColor() $final, Num() $progress) {
    Clutter::Color.interpolate($!cc, $final, $progress);
  }
  multi method interpolate (
    Clutter::Color:U:
    ClutterColor() $a,
    ClutterColor() $b,
    Num() $progress
  ) {
    my $c = ClutterColor.new;
    my gdouble $p = $progress;
    clutter_color_interpolate($a, $b, $p, $c);
    self.bless( color => $c );
  }

  multi method lighten (Clutter::Color:U: ClutterColor() $color) {
    self.bless( color => clutter_color_lighten($!cc, $color) );
  }
  multi method lighten {
    Clutter::Color.lighten($!cc);
  }

  multi method shade (
    Clutter::Color:U:
    ClutterColor() $color,
    Num() $factor
  ) {
    my $c = ClutterColor.new;
    my gdouble $f = $factor;
    self.bless( color => clutter_color_shade($!cc, $f, $c) );
  }
  multi method shade (Num() $factor) {
    Clutter::Color.shade($!cc, $factor);
  }

  multi method subtract (
    Clutter::Color:U:
    ClutterColor() $a,
    ClutterColor() $b
  ) {
    my $c = ClutterColor.new;
    clutter_color_subtract($a, $b, $c);
    self.bless( color => $c );
  }
  multi method subtract (ClutterColor $b) {
    Clutter::Color.subtract($!cc, $b);
  }

  proto method to_hls (|)
    is also<to-hls>
  { * }

  multi method to_hls (
    Clutter::Color:U:
    ClutterColor() $c,
    Num() $hue        is rw,
    Num() $luminance  is rw,
    Num() $saturation is rw
  ) {
    my gdouble ($h, $l, $s) = ($hue, $luminance, $saturation);
    clutter_color_to_hls($c, $hue, $luminance, $saturation);
    ($hue, $luminance, $saturation) = ($h, $l, $s);
  }
  multi method to_hls {
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
    unstable_get_type(
      'Clutter::Color::Param', &clutter_param_color_get_type(), $n, $t
    );
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
    clutter_value_set_color($val, $!cc);
  }

}

our %static-color is export;

INIT {

  our $CLUTTER_COLOR_White           is export = Clutter::Color.get_static(CLUTTER_COLOR_WHITE);
  our $CLUTTER_COLOR_Black           is export = Clutter::Color.get_static(CLUTTER_COLOR_BLACK);
  our $CLUTTER_COLOR_Red             is export = Clutter::Color.get_static(CLUTTER_COLOR_RED);
  our $CLUTTER_COLOR_DarkRed         is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_RED);
  our $CLUTTER_COLOR_Green           is export = Clutter::Color.get_static(CLUTTER_COLOR_GREEN);
  our $CLUTTER_COLOR_DarkGreen       is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_GREEN);
  our $CLUTTER_COLOR_Blue            is export = Clutter::Color.get_static(CLUTTER_COLOR_BLUE);
  our $CLUTTER_COLOR_DarkBlue        is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_BLUE);
  our $CLUTTER_COLOR_Cyan            is export = Clutter::Color.get_static(CLUTTER_COLOR_CYAN);
  our $CLUTTER_COLOR_DarkCyan        is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_CYAN);
  our $CLUTTER_COLOR_Magenta         is export = Clutter::Color.get_static(CLUTTER_COLOR_MAGENTA);
  our $CLUTTER_COLOR_DarkMagenta     is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_MAGENTA);
  our $CLUTTER_COLOR_Yellow          is export = Clutter::Color.get_static(CLUTTER_COLOR_YELLOW);
  our $CLUTTER_COLOR_DarkYellow      is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_YELLOW);
  our $CLUTTER_COLOR_Gray            is export = Clutter::Color.get_static(CLUTTER_COLOR_GRAY);
  our $CLUTTER_COLOR_DarkGray        is export = Clutter::Color.get_static(CLUTTER_COLOR_DARK_GRAY);
  our $CLUTTER_COLOR_LightGray       is export = Clutter::Color.get_static(CLUTTER_COLOR_LIGHT_GRAY);
  our $CLUTTER_COLOR_Butter          is export = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER);
  our $CLUTTER_COLOR_LightButter     is export = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER_LIGHT);
  our $CLUTTER_COLOR_DarkButter      is export = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER_DARK);
  our $CLUTTER_COLOR_Orange          is export = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE);
  our $CLUTTER_COLOR_LightOrange     is export = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE_LIGHT);
  our $CLUTTER_COLOR_DarkOrange      is export = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE_DARK);
  our $CLUTTER_COLOR_Chocolate       is export = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE);
  our $CLUTTER_COLOR_LightChocolate  is export = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE_LIGHT);
  our $CLUTTER_COLOR_DarkChocolate   is export = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE_DARK);
  our $CLUTTER_COLOR_Chameleon       is export = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON);
  our $CLUTTER_COLOR_LightChameleon  is export = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON_LIGHT);
  our $CLUTTER_COLOR_DarkChameleon   is export = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON_DARK);
  our $CLUTTER_COLOR_SkyBlue         is export = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE);
  our $CLUTTER_COLOR_LightSkyBlue    is export = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE_LIGHT);
  our $CLUTTER_COLOR_DarkSkyBlue     is export = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE_DARK);
  our $CLUTTER_COLOR_Plum            is export = Clutter::Color.get_static(CLUTTER_COLOR_PLUM);
  our $CLUTTER_COLOR_LightPlum       is export = Clutter::Color.get_static(CLUTTER_COLOR_PLUM_LIGHT);
  our $CLUTTER_COLOR_DarkPlum        is export = Clutter::Color.get_static(CLUTTER_COLOR_PLUM_DARK);
  our $CLUTTER_COLOR_ScarletRed      is export = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED);
  our $CLUTTER_COLOR_LightScarletRed is export = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED_LIGHT);
  our $CLUTTER_COLOR_DarkScarletRed  is export = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED_DARK);
  our $CLUTTER_COLOR_Aluminium1      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_1);
  our $CLUTTER_COLOR_Aluminium2      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_2);
  our $CLUTTER_COLOR_Aluminium3      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_3);
  our $CLUTTER_COLOR_Aluminium4      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_4);
  our $CLUTTER_COLOR_Aluminium5      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_5);
  our $CLUTTER_COLOR_Aluminium6      is export = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_6);
  our $CLUTTER_COLOR_Transparent     is export = Clutter::Color.get_static(CLUTTER_COLOR_TRANSPARENT);

}
