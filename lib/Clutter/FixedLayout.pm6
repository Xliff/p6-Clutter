use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Clutter::Raw::Types;

use Clutter::LayoutManager;

class Clutter::FixedLayout is Clutter::LayoutManager {
  has ClutterFixedLayout $!cfl;
  
  submethod BUILD (:$fixed) {
  }
