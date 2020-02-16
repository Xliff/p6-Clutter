use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use Clutter::ActorMeta;

use GLib::Roles::Object;

our subset ClutterEffectAncestry of Mu is export
  where ClutterEffect | ClutterActorMetaAncestry;

class Clutter::Effect is Clutter::ActorMeta {
  also does GLib::Roles::Object;

  has ClutterEffect $!c-eff;

  method Clutter::Raw::Definitions::ClutterEffect
    is also<ClutterEffect>
  { $!c-eff }

  method setEffect(ClutterEffect $effect) {
    #self.IS-PROTECTED;
    say 'setEffect' if $DEBUG;
    my $to-parent;
    given $effect {
      when ClutterEffectAncestry {
        $!c-eff = do {
          when ClutterEffect {
            $to-parent = cast(ClutterActorMeta, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterEffect, $_);
          }
        }
        self.setActorMeta($to-parent);
      }

      when Clutter::Effect {
      }

      default {
      }
    }
  }

  method queue_repaint is also<queue-repaint> {
    clutter_effect_queue_repaint($!c-eff);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_effect_get_type, $n, $t );
  }

}

sub clutter_effect_queue_repaint (ClutterEffect $effect)
  is native(clutter)
  is export
{ * }

sub clutter_effect_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }
