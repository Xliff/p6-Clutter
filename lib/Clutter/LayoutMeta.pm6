use v6.c;

use Method::Also;
use NativeCall;


use Clutter::Raw::Types;

use Clutter::ChildMeta;

our subset LayoutMetaAncestry of Mu
  where ClutterLayoutMeta | ClutterChildMeta;

class Clutter::LayoutMeta is Clutter::ChildMeta {
  has ClutterLayoutMeta $!clmeta;
  
  submethod BUILD (:$metalayout) {
    given $metalayout {
      when LayoutMetaAncestry {
        self.setLayoutMeta($metalayout);
      }
      when Clutter::LayoutMeta {
      }
      default {
      } 
    }
  }
  
  method setLayoutMeta(LayoutMetaAncestry $_) {
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
  
  method Clutter::Raw::Types::ClutterLayoutMeta
    is also<LayoutMeta>
  { $!clmeta }
    
  method new (ClutterLayoutMeta $metalayout) {
    # No GLib::Roles::References
    # No destroy yet, so no upref logic.
    self.bless(:$metalayout);
  }
  
  method get_manager is also<get-manager> {
    ::('Clutter::LayoutManager').new( 
      clutter_layout_meta_get_manager($!clmeta)
    );
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
