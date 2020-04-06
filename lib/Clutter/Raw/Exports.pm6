use v6.c;

unit package Clutter::Raw::Exports;

our @clutter-exports is export;

BEGIN {
  @clutter-exports = <
    Clutter::Compat::Types
    Clutter::Raw::Definitions
    Clutter::Raw::Enums
    Clutter::Raw::Exceptions
    Clutter::Raw::Structs
    Clutter::Compat::Types
  >;
}
