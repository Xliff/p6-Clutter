use v6.c;

unit package Clutter::Raw::Exceptions;

class X::ClutterColor::Memory is Exception is export {
  method message { 'Cannot allocate ClutterColor!' }
}
