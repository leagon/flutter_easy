import 'dart:core';

class RegularExpression {
  static RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,}$");

  static RegExp phoneRegExp = RegExp(r'(^[0-9()+-.#/*@:,x ]+$)');

  static RegExp nameRegExp = RegExp(r"(\w*[a-zA-Z0-9]\w*)");

  static RegExp websiteRegExp = RegExp(
      r"([(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))");

  static RegExp uppercaseRegExp = RegExp(r'[A-Z]');
  static RegExp lowercaseRegExp = RegExp(r'[a-z]');

  static RegExp specialCharactersRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static RegExp macAddressRegExp =
      RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
  static RegExp macAddressPartsRegExp = RegExp(r'[0-9A-Fa-f]');

  static RegExp nvrPasswordRegExp = RegExp(r'(^[A-Za-z0-9!@#^&]+$)');

  static RegExp numericRegExp = RegExp(r'(^[0-9]*$)');
}
