use v6;

use CompUnit::Util :re-export;

use GLib::Raw::Exports;
use Pango::Raw::Exports;
use COGL::Raw::Exports;
use Clutter::Raw::Exports;

unit package GLib::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;
need COGL::Raw::Definitions;
need COGL::Raw::Enums;
need COGL::Raw::Structs;
need COGL::Compat::Types;
need Clutter::Compat::Types;
need Clutter::Raw::Definitions;
need Clutter::Raw::Enums;
need Clutter::Raw::Structs;
need Clutter::Compat::Types;

BEGIN {
  re-export($_) for
    |@glib-exports,
    |@cogl-exports,
    |@pango-exports,
    |@clutter-exports;
}
