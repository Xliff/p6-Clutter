use v6.c;

unit package Clutter::Raw::Exports;

our @clutter-exports is export;

BEGIN {
  @clutter-exports = <
    Clutter::Raw::Definitions
    Clutter::Raw::Enums
    Clutter::Raw::Exceptions
    Clutter::Raw::Structs
  >;
}
