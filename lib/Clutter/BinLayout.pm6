use v6.c;

use Method::Also;
use NativeCall;


use Clutter::Raw::Types;

use Clutter::LayoutManager;

class Clutter::BinLayout is Clutter::LayoutManager {
  has ClutterBinLayout $!cbl;
  
  submethod BUILD (:$binlayout) {
    self.setLayoutManager( cast(ClutterLayoutManager, $!cbl = $binlayout) );
  }
  
  method Clutter::Raw::Types::ClutterBinLayout
    is also<ClutterBinLayout>
  { $!cbl }
  
  method new (ClutterBinAlignment $x_align, ClutterBinAlignment $y_align) {
    self.bless( binlayout => clutter_bin_layout_new($x_align, $y_align) );
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &clutter_bin_layout_get_type, $n, $t );
  }
  
}

sub clutter_bin_layout_get_type ()
  returns GType
  is native(clutter)
  is export
{ * }

sub clutter_bin_layout_new (
  guint $x_align, # ClutterBinAlignment $x_align, 
  guint $y_align  # ClutterBinAlignment $y_align
)
  returns ClutterBinLayout
  is native(clutter)
  is export
{ * }
