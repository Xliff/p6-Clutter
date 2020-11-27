use v6.c;

use Method::Also;

use Clutter::Raw::Types;
use Clutter::Raw::Color;

# A lot of memory allocation going on, here. Consider doing in-place
# operations.

# Boxed

class Clutter::Color {
  has ClutterColor $!cc handles <red green blue alpha gist perl>;

  submethod BUILD (:$color) {
    $!cc = $color;
  }

  method Clutter::Raw::Structs::ClutterColor
    is also<ClutterColor>
  { $!cc }

  multi method new (ClutterColor $color) {
    $color ?? self.bless(:$color) !! Nil;
  }
  multi method new {
    my $color = clutter_color_alloc();

    $color ?? self.bless(:$color) !! Nil;
  }
  multi method new (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  ) {
    my gint8 ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);
    my       $color           = clutter_color_new($r, $g, $b, $a);

    $color ?? self.bless(:$color) !! Nil;
  }

  method new_from_hls (
    Clutter::Color:U:
    Num()             $hue,
    Num()             $luminance,
    Num()             $saturation,
                      :$alpha      is copy
  )
    is also<new-from-hls>
  {
    my gfloat ($h, $l, $s) = ($hue, $luminance, $saturation);
    my        $color       = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    if $alpha.defined {
      die '$alpha is not Int-compatible' unless $alpha.^lookup('Int');
      $alpha .= Int;
    }
    clutter_color_from_hls($color, $h, $l, $s);
    $color.alpha = $alpha if $alpha;
    self.bless(:$color);
  }

  method new_from_pixel (Clutter::Color:U: Int() $pixel)
    is also<new-from-pixel>
  {
    my guint $p     = $pixel;
    my       $color = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    clutter_color_from_pixel($color, $p);
    self.bless( :$color );
  }

  method new_from_string (
    Clutter::Color:U: Str() $str
  )
    is also<new-from-string>
  {
    my $color = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    clutter_color_from_string($color, $str);
    self.bless( :$color );
  }

  method new_from_color (
    Clutter::Color:U:
    ClutterColor()    $c
  )
    is also<new-from-color>
  {
    use nqp;

    # cw: Must use nqp to hllize the value, since it might come from a
    #     static color, and those need to be HLL-ized

    my $color = ClutterColor.new(
      nqp::hllize( nqp::decont($c.red)   ),
      nqp::hllize( nqp::decont($c.green) ),
      nqp::hllize( nqp::decont($c.blue)  ),
      nqp::hllize( nqp::decont($c.alpha) )
    );

    X::ClutterColor::Memory.new.throw unless $color;

    self.bless(:$color);
  }

  method get_static (Clutter::Color:U: $static is copy)
    is also<get-static>
  {
    die qq:to/DIE/.chomp unless $static ~~ Int || $static.^lookup('Int');
Clutter::Color.get_static only takes a ClutterStaticColor or Int-compatible
parameter. The type passed was { $static.^name }
DIE

    $static .= Int;
    my guint $s = $static;
    my $color = clutter_color_get_static($s);

    if $DEBUG {
      say "S-{ ClutterStaticColorEnum( $static ) } - {$_}: { $color."$_"() }"
        for <red green blue alpha>;
    }

    $color ?? self.bless(:$color) !! Nil;
  }

  method init (
    Clutter::Color:U:
    Int()             $red,
    Int()             $green,
    Int()             $blue,
    Int()             $alpha
  ) {
    my guint8 ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);
    my        $c               = self.alloc;

    clutter_color_init($c, $r, $g, $b, $a);
    $c;
  }

  multi method add (Clutter::Color:D: ClutterColor() $b, :$raw = False) {
    my $color = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    samewith($b, $color, :$raw);

  }
  multi method add (
    Clutter::Color:D:
    ClutterColor()    $b,
    ClutterColor()    $color,
                      :$raw   = False
  ) {
    return Nil unless $b && $color;

    clutter_color_add($!cc, $b, $color, :$raw);
    $raw ?? $color !! Clutter::Color.new($color);
  }

  method copy (Clutter::Color:D: :$raw = False) {
    my $color = clutter_color_copy($!cc);

    $color ??
      ( $raw ?? $color !! Clutter::Color.new($color) )
      !!
      Nil;
  }

  method alloc {
    clutter_color_alloc();
  }

  multi method darken (Clutter::Color:D:) {
    Clutter::Color.darken($!cc);
  }
  multi method darken (Clutter::Color:U: ClutterColor() $c, :$raw = False) {
    my $color //= self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    clutter_color_darken($color, $c);

    $color ??
      ( $raw ?? $color !! self.bless(:$color) )
      !!
      Nil;
  }

  multi method equal (ClutterColor() $v2) {
    Clutter::Color.equal($!cc, $v2);
  }
  multi method equal (
    Clutter::Color:U:
    ClutterColor()    $v1,
    ClutterColor()    $v2
  ) {
    so clutter_color_equal($v1, $v2);
  }

  multi method free (Clutter::Color:U: ClutterColor() $c) {
    clutter_color_free($c);
  }
  multi method free {
    Clutter::Color.free($!cc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_color_get_type, $n, $t );
  }

  multi method hash {
    Clutter::Color.hash($!cc);
  }
  multi method hash (Clutter::Color:U: ClutterColor() $c) {
    clutter_color_hash($c);
  }

  multi method interpolate (ClutterColor() $final, Num() $progress) {
    Clutter::Color.interpolate($!cc, $final, $progress);
  }
  multi method interpolate (
    Clutter::Color:U:
    ClutterColor()    $a,
    ClutterColor()    $b,
    Num()             $progress
  ) {
    return Nil unless $a && $b;

    my $color = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    my gdouble $p = $progress;

    clutter_color_interpolate($a, $b, $p, $color);

    self.bless(:$color);
  }

  multi method lighten (:$raw = False) {
    Clutter::Color.lighten($!cc, :$raw);
  }
  multi method lighten (Clutter::Color:U: $color, :$raw = False)
  {
    $color //= self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    clutter_color_lighten($!cc, $color);

    $color ??
      ( $raw ?? $color !! self.bless(:$color) )
      !!
      Nil;
  }

  multi method shade (Num() $factor) {
    Clutter::Color.shade($!cc, $factor, $);
  }
  multi method shade (
    Clutter::Color:U:
    ClutterColor()    $c1,
    Num()             $factor,
                      $color
  ) {
    return Nil unless $c1;

    $color //= self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    my gdouble $f = $factor;
    clutter_color_shade($c1, $f, $color);

    self.bless(:$color);
  }

  multi method subtract (
    Clutter::Color:U:
    ClutterColor()    $a,
    ClutterColor()    $b
  ) {
    return Nil unless $a && $b;

    my $color = self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    clutter_color_subtract($a, $b, $color);
    self.bless(:$color);
  }
  multi method subtract (ClutterColor $b) {
    Clutter::Color.subtract($!cc, $b);
  }

  proto method to_hls (|)
    is also<to-hls>
  { * }

  multi method to_hls {
    Clutter::Color.to_hls($!cc, $, $, $);
  }
  multi method to_hls (
    Clutter::Color:U:
    ClutterColor()    $color,
                      $hue        is rw,
                      $luminance  is rw,
                      $saturation is rw
  ) {
    $color //= self.alloc;

    X::ClutterColor::Memory.new.throw unless $color;

    my gdouble ($h, $l, $s) = 0e0 xx 3;

    clutter_color_to_hls($color, $h, $l, $s);
    ($hue, $luminance, $saturation) = ($h, $l, $s);
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
    Str()             $nick,
    Str()             $blurb,
    ClutterColor()    $default_value,
    Int()             $flags
  )
    is also<clutter-param-spec-color>
  {
    my GParamFlags $f = $flags;

    clutter_param_spec_color($nick, $blurb, $default_value, $f);
  }

  method get_from_value (GValue() $val) is also<get-from-value> {
    $!cc = clutter_value_get_color($val);
  }

  method set_to_value (GValue() $val) is also<set-to-value> {
    clutter_value_set_color($val, $!cc);
  }

}

our $CLUTTER_COLOR_White           is export;
our $CLUTTER_COLOR_Black           is export;
our $CLUTTER_COLOR_Red             is export;
our $CLUTTER_COLOR_DarkRed         is export;
our $CLUTTER_COLOR_Green           is export;
our $CLUTTER_COLOR_DarkGreen       is export;
our $CLUTTER_COLOR_Blue            is export;
our $CLUTTER_COLOR_DarkBlue        is export;
our $CLUTTER_COLOR_Cyan            is export;
our $CLUTTER_COLOR_DarkCyan        is export;
our $CLUTTER_COLOR_Magenta         is export;
our $CLUTTER_COLOR_DarkMagenta     is export;
our $CLUTTER_COLOR_Yellow          is export;
our $CLUTTER_COLOR_DarkYellow      is export;
our $CLUTTER_COLOR_Gray            is export;
our $CLUTTER_COLOR_DarkGray        is export;
our $CLUTTER_COLOR_LightGray       is export;
our $CLUTTER_COLOR_Butter          is export;
our $CLUTTER_COLOR_LightButter     is export;
our $CLUTTER_COLOR_DarkButter      is export;
our $CLUTTER_COLOR_Orange          is export;
our $CLUTTER_COLOR_LightOrange     is export;
our $CLUTTER_COLOR_DarkOrange      is export;
our $CLUTTER_COLOR_Chocolate       is export;
our $CLUTTER_COLOR_LightChocolate  is export;
our $CLUTTER_COLOR_DarkChocolate   is export;
our $CLUTTER_COLOR_Chameleon       is export;
our $CLUTTER_COLOR_LightChameleon  is export;
our $CLUTTER_COLOR_DarkChameleon   is export;
our $CLUTTER_COLOR_SkyBlue         is export;
our $CLUTTER_COLOR_LightSkyBlue    is export;
our $CLUTTER_COLOR_DarkSkyBlue     is export;
our $CLUTTER_COLOR_Plum            is export;
our $CLUTTER_COLOR_LightPlum       is export;
our $CLUTTER_COLOR_DarkPlum        is export;
our $CLUTTER_COLOR_ScarletRed      is export;
our $CLUTTER_COLOR_LightScarletRed is export;
our $CLUTTER_COLOR_DarkScarletRed  is export;
our $CLUTTER_COLOR_Aluminium1      is export;
our $CLUTTER_COLOR_Aluminium2      is export;
our $CLUTTER_COLOR_Aluminium3      is export;
our $CLUTTER_COLOR_Aluminium4      is export;
our $CLUTTER_COLOR_Aluminium5      is export;
our $CLUTTER_COLOR_Aluminium6      is export;
our $CLUTTER_COLOR_Transparent     is export;

INIT {
  $CLUTTER_COLOR_White            = Clutter::Color.get_static(CLUTTER_COLOR_WHITE);
  $CLUTTER_COLOR_Black            = Clutter::Color.get_static(CLUTTER_COLOR_BLACK);
  $CLUTTER_COLOR_Red              = Clutter::Color.get_static(CLUTTER_COLOR_RED);
  $CLUTTER_COLOR_DarkRed          = Clutter::Color.get_static(CLUTTER_COLOR_DARK_RED);
  $CLUTTER_COLOR_Green            = Clutter::Color.get_static(CLUTTER_COLOR_GREEN);
  $CLUTTER_COLOR_DarkGreen        = Clutter::Color.get_static(CLUTTER_COLOR_DARK_GREEN);
  $CLUTTER_COLOR_Blue             = Clutter::Color.get_static(CLUTTER_COLOR_BLUE);
  $CLUTTER_COLOR_DarkBlue         = Clutter::Color.get_static(CLUTTER_COLOR_DARK_BLUE);
  $CLUTTER_COLOR_Cyan             = Clutter::Color.get_static(CLUTTER_COLOR_CYAN);
  $CLUTTER_COLOR_DarkCyan         = Clutter::Color.get_static(CLUTTER_COLOR_DARK_CYAN);
  $CLUTTER_COLOR_Magenta          = Clutter::Color.get_static(CLUTTER_COLOR_MAGENTA);
  $CLUTTER_COLOR_DarkMagenta      = Clutter::Color.get_static(CLUTTER_COLOR_DARK_MAGENTA);
  $CLUTTER_COLOR_Yellow           = Clutter::Color.get_static(CLUTTER_COLOR_YELLOW);
  $CLUTTER_COLOR_DarkYellow       = Clutter::Color.get_static(CLUTTER_COLOR_DARK_YELLOW);
  $CLUTTER_COLOR_Gray             = Clutter::Color.get_static(CLUTTER_COLOR_GRAY);
  $CLUTTER_COLOR_DarkGray         = Clutter::Color.get_static(CLUTTER_COLOR_DARK_GRAY);
  $CLUTTER_COLOR_LightGray        = Clutter::Color.get_static(CLUTTER_COLOR_LIGHT_GRAY);
  $CLUTTER_COLOR_Butter           = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER);
  $CLUTTER_COLOR_LightButter      = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER_LIGHT);
  $CLUTTER_COLOR_DarkButter       = Clutter::Color.get_static(CLUTTER_COLOR_BUTTER_DARK);
  $CLUTTER_COLOR_Orange           = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE);
  $CLUTTER_COLOR_LightOrange      = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE_LIGHT);
  $CLUTTER_COLOR_DarkOrange       = Clutter::Color.get_static(CLUTTER_COLOR_ORANGE_DARK);
  $CLUTTER_COLOR_Chocolate        = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE);
  $CLUTTER_COLOR_LightChocolate   = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE_LIGHT);
  $CLUTTER_COLOR_DarkChocolate    = Clutter::Color.get_static(CLUTTER_COLOR_CHOCOLATE_DARK);
  $CLUTTER_COLOR_Chameleon        = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON);
  $CLUTTER_COLOR_LightChameleon   = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON_LIGHT);
  $CLUTTER_COLOR_DarkChameleon    = Clutter::Color.get_static(CLUTTER_COLOR_CHAMELEON_DARK);
  $CLUTTER_COLOR_SkyBlue          = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE);
  $CLUTTER_COLOR_LightSkyBlue     = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE_LIGHT);
  $CLUTTER_COLOR_DarkSkyBlue      = Clutter::Color.get_static(CLUTTER_COLOR_SKY_BLUE_DARK);
  $CLUTTER_COLOR_Plum             = Clutter::Color.get_static(CLUTTER_COLOR_PLUM);
  $CLUTTER_COLOR_LightPlum        = Clutter::Color.get_static(CLUTTER_COLOR_PLUM_LIGHT);
  $CLUTTER_COLOR_DarkPlum         = Clutter::Color.get_static(CLUTTER_COLOR_PLUM_DARK);
  $CLUTTER_COLOR_ScarletRed       = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED);
  $CLUTTER_COLOR_LightScarletRed  = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED_LIGHT);
  $CLUTTER_COLOR_DarkScarletRed   = Clutter::Color.get_static(CLUTTER_COLOR_SCARLET_RED_DARK);
  $CLUTTER_COLOR_Aluminium1       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_1);
  $CLUTTER_COLOR_Aluminium2       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_2);
  $CLUTTER_COLOR_Aluminium3       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_3);
  $CLUTTER_COLOR_Aluminium4       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_4);
  $CLUTTER_COLOR_Aluminium5       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_5);
  $CLUTTER_COLOR_Aluminium6       = Clutter::Color.get_static(CLUTTER_COLOR_ALUMINIUM_6);
  $CLUTTER_COLOR_Transparent      = Clutter::Color.get_static(CLUTTER_COLOR_TRANSPARENT);
}
