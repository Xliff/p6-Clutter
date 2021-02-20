use v6;

use GLib::Raw::Exports;
use ATK::Raw::Exports;
use GIO::Raw::Exports;
use JSON::GLib::Raw::Exports;
use Pango::Raw::Exports;
use COGL::Raw::Exports;
use Clutter::Raw::Exports;

unit package Clutter::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need ATK::Raw::Definitions;
need ATK::Raw::Enums;
need ATK::Raw::Structs;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Quarks;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::DBus::Raw::Types;
need GIO::Raw::Exports;
need JSON::GLib::Raw::Definitions;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;
need COGL::Raw::Definitions;
need COGL::Raw::Enums;
need COGL::Raw::Structs;
need COGL::Compat::Types;
need Clutter::Raw::Definitions;
need Clutter::Raw::Enums;
need Clutter::Raw::Exceptions;
need Clutter::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@atk-exports,
                         |@gio-exports,
                         |@jg-exports,
                         |@cogl-exports,
                         |@pango-exports,
                         |@clutter-exports;
}
