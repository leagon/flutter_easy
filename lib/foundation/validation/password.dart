import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum PasswordValidationError { empty, invalid }

extension PasswordValidationErrorMessage on PasswordValidationError {
  String invalidMessage({String title = 'Password', String? message}) {
    switch (this) {
      case PasswordValidationError.empty:
        return message ?? '$title is required';
      case PasswordValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure("");

  const Password.dirty([String value = ""]) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return value.isEmpty ? PasswordValidationError.empty : null;
  }
}

class PasswordRequired extends FormzInput<String, PasswordValidationError> {
  const PasswordRequired.pure() : super.pure("");

  const PasswordRequired.dirty([String value = ""]) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return value.isEmpty
        ? PasswordValidationError.empty
        : value.contains(RegularExpression.uppercase.regExp) &&
                value.contains(RegularExpression.lowercase.regExp) &&
                value.contains(RegularExpression.specialCharacters.regExp) &&
                value.length > 10
            ? null
            : PasswordValidationError.invalid;
  }
}
