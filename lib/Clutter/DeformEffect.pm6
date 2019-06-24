use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Clutter::Compat::Types;
use Clutter::Raw::Types;

use GTK::Raw::Utils;

use Clutter::Raw::DeformEffect;

use GTK::Compat::Value;

use Clutter::OffscreenEffect;

our subset DeformEffectAncestry is export of Mu
  where ClutterDeformEffect | OffscreenEffectAncestry;

class Clutter::DeformEffect is Clutter::OffscreenEffect {
  has ClutterDeformEffect $!cde;

  submethod BUILD (:$deform) {
    given $deform {
      when DeformEffectAncestry {
        self.setupDeformEffect($deform);
      }
      when Clutter::DeformEffect {
      }
      default {
      }
    }
  }

  method setupDeformEffect (DeformEffectAncestry $deform) {
    self.IS-PROTECTED;
    my $to-parent;
    $!cde = do given $deform {
      when ClutterDeformEffect {
        $to-parent = cast(ClutterOffscreenEffect, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(ClutterOffscreenEffect, $_);
      }
    }
    self.setOffscreenEffect($to-parent);
  }

  method Clutter::Raw::Types::ClutterDeformEffect
  { $!cde }

  method new (ClutterDeformEffect $deform) {
    self.bless(:$deform);
  }

  method back_material is rw is also<back-material> {
    Proxy.new(
      FETCH => sub ($) {
        clutter_deform_effect_get_back_material($!cde);
      },
      STORE => sub ($, CoglHandle $material is copy) {
        clutter_deform_effect_set_back_material($!cde, $material);
      }
    );
  }

  # Type: guint
  method x-tiles is rw  is also<x_tiles> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('x-tiles', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('x-tiles', $gv);
      }
    );
  }

  # Type: guint
  method y-tiles is rw  is also<y_tiles> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('y-tiles', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('y-tiles', $gv);
      }
    );
  }

  method get_n_tiles (Int() $x_tiles, Int() $y_tiles) is also<get-n-tiles> {
    my guint ($xt, $yt) = resolve-uint($x_tiles, $y_tiles);
    clutter_deform_effect_get_n_tiles($!cde, $xt, $yt);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_deform_effect_get_type, $n, $t );
  }

  method invalidate {
    clutter_deform_effect_invalidate($!cde);
  }

  method set_n_tiles (Int() $x_tiles, Int() $y_tiles) is also<set-n-tiles> {
    my guint ($xt, $yt) = resolve-uint($x_tiles, $y_tiles);
    clutter_deform_effect_set_n_tiles($!cde, $xt, $yt);
  }

}