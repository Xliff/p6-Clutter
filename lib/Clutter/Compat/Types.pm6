use v6.c;

use Cairo;

use NativeCall;

use GLib::Roles::Pointers;

unit package Clutter::Compat::Types;

class JsonNode     is repr('CPointer') is export does GLib::Roles::Pointers { }
