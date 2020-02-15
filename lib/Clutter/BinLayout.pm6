use v6.c;

use Method::Also;
use NativeCall;

use Clutter::Raw::Types;

use Clutter::LayoutManager;

our subset ClutterBinLayoutAncestry is export of Mu
  where ClutterBinLayout | ClutterLayoutManagerAncestry;

class Clutter::BinLayout is Clutter::LayoutManager {
  has ClutterBinLayout $!cbl;

  submethod BUILD (:$binlayout) {
    my $to-parent;
    $!cbl = do given $binlayout {
      when ClutterBinLayout {
        $to-parent = cast(ClutterLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ClutterBinLayout, $_);
      }
    }
    self.setLayoutManager($to-parent);
  }

  method Clutter::Raw::Definitions::ClutterBinLayout
    is also<ClutterBinLayout>
  { $!cbl }

  multi method new (ClutterBinLayoutAncestry $binlayout) {
    $binlayout ?? self.bless(:$binlayout) !! Nil;
  }
  multi method new (Int() $x_align, Int() $y_align) {
    my $binlayout = clutter_bin_layout_new($x_align, $y_align);
    my ClutterBinAlignment ($xa, $ya) = ($x_align, $y_align);

    $binlayout ?? self.bless(:$binlayout) !! Nil;
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
