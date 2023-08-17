import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum EmailValidationError { invalid, empty }

extension EmailValidationErrorMessage on EmailValidationError {
  String message({String title = 'Email', String? message}) {
    switch (this) {
      case EmailValidationError.empty:
        return message ?? '$title is required';
      case EmailValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure("");

  const Email.dirty([String value = ""]) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    // Consider empty as valid
    return value.isEmpty
        ? null
        : (RegularExpression.email.regExp.hasMatch(value)
            ? null
            : EmailValidationError.invalid);
  }
}

class EmailRequired extends FormzInput<String, EmailValidationError> {
  const EmailRequired.pure() : super.pure("");

  const EmailRequired.dirty([String value = ""]) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.empty
        : (RegularExpression.email.regExp.hasMatch(value)
            ? null
            : EmailValidationError.invalid);
  }
}
