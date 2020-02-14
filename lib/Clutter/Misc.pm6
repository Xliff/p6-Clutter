use v6.c;


use Clutter::Raw::Types;



use Clutter::Raw::Event;

class Clutter::Misc {
  
  method new (|) {
    warn 'Cannot instantiate Clutter::Misc. Please use the static invocation.';
    Clutter::Misc;
  }
  
  method keysym_to_unicode (Int $kc) {
    my gint $kkc = resolve-int($kc);
    clutter_keysym_to_unicode($kkc);
  }

  method unicode_to_keysym(Int() $wc) {
    my guint $wwc = resolve-uint($wc);
    clutter_unicode_to_keysym($wwc);
  }
  
}
