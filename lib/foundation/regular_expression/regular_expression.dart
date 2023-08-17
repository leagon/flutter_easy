import 'dart:core';

enum RegularExpression {
  email(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9_.-]+\.[a-zA-Z]{2,}$"),
  phone(r'(^[0-9()+-.#/*@:,x ]+$)'),
  name(r"(\w*[a-zA-Z0-9]\w*)"),
  website(
      r"([(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))"),
  uppercase(r'[A-Z]'),
  lowercase(r'[a-z]'),
  specialCharacters(r'[!@#$%^&*(),.?":{}|<>]'),
  macAddress(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'),
  partMacAddress(r'[0-9A-Fa-f]'),
  numberic(r'(^[0-9]*$)'),
  aa('');

  final String exp;

  const RegularExpression(this.exp);

  RegExp get regExp => RegExp(exp);
}
