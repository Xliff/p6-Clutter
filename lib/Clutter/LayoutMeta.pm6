use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use Clutter::ChildMeta;

our subset ClutterLayoutMetaAncestry of Mu
  where ClutterLayoutMeta | ClutterChildMetaAncestry;

class Clutter::LayoutMeta is Clutter::ChildMeta {
  has ClutterLayoutMeta $!clmeta;

  submethod BUILD (:$layoutmeta) {
    given $layoutmeta {
      when    ClutterLayoutMetaAncestry { self.setLayoutMeta($_) }
      when    Clutter::LayoutMeta       { }
      default                           { }
    }
  }

  method setLayoutMeta(ClutterLayoutMetaAncestry $_) {
    my $to-parent;
    $!clmeta = do {
      when ClutterLayoutMeta {
        $to-parent = cast(ClutterChildMeta, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterLayoutMeta, $_);
      }
    };
    self.setChildMeta($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterLayoutMeta
    is also<
      LayoutMeta
      ClutterLayoutMeta
    >
  { $!clmeta }

  method new (ClutterLayoutMetaAncestry $layoutmeta) {
    # No GLib::Roles::References
    # No destroy yet, so no upref logic.
    $layoutmeta ?? self.bless(:$layoutmeta) !! Nil
  }

  method get_manager (:$raw = False) is also<get-manager> {
    my $m = clutter_layout_meta_get_manager($!clmeta);

    $m ??
      ( $raw ?? $m !!::('Clutter::LayoutManager').new($m) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &clutter_layout_meta_get_type, $n, $t );
  }

}

sub clutter_layout_meta_get_manager (ClutterLayoutMeta $data)
  returns ClutterLayoutManager
  is native(clutter)
  is export
  { * }

sub clutter_layout_meta_get_type ()
  returns GType
  is native(clutter)
  is export
  { * }
