use v6.c;

use NativeCall;


use Clutter::Raw::Types;

use Clutter::Actor;

our subset ClutterCloneAncestry of Mu
  where ClutterClone | ClutterActor;

class Clutter::Clone is Clutter::Actor {
  has ClutterClone $!cc;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$clone) {
    given $clone {
      when ClutterCloneAncestry {
        my $to-parent;
        $!cc = do {
          when ClutterClone {
            $to-parent = cast(ClutterActor, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(ClutterClone, $_);
          }
        }
        self.setClutterActor($to-parent);
      }

      when Clutter::Clone {
      }

      default {
      }
    }
  }

  multi method new (ClutterCloneAncestry $clone) {
    $clone ?? self.bless(:$clone) !! Nil;
  }
  multi method new (ClutterActor() $source) {
    my $clone = clutter_clone_new($source);

    $clone ?? self.bless(:$clone) !! Nil;
  }

  method source(:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = clutter_clone_get_source($!cc);

        $a ??
          ( $raw ?? $a !! Clutter::Actor.new($a) )
          !!
          Nil
      },
      STORE => sub ($, ClutterActor() $source is copy) {
        clutter_clone_set_source($!cc, $source);
      }
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_clone_get_type, $n, $t );
  }

}

sub clutter_clone_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_clone_new (ClutterActor $source)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_clone_get_source (ClutterClone $self)
  returns ClutterActor
  is native(clutter)
  is export
{ * }

sub clutter_clone_set_source (ClutterClone $self, ClutterActor $source)
  is native(clutter)
  is export
{ * }
