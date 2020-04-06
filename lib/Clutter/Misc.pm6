use v6.c;

use Clutter::Raw::Types;
use Clutter::Raw::Event;

use GLib::Roles::StaticClass;

class Clutter::Misc {
  also does GLib::Roles::StaticClass;

  method keysym_to_unicode (Int $kc) {
    my gint $kkc = $kc;

    clutter_keysym_to_unicode($kkc);
  }

  method unicode_to_keysym(Int() $wc) {
    my guint $wwc = $wc;

    clutter_unicode_to_keysym($wwc);
  }
}
