import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum NameValidationError { invalid, empty }

extension NameValidationErrorMesage on NameValidationError {
  String message({String title = 'Name', String? message}) {
    switch (this) {
      case NameValidationError.empty:
        return message ?? '$title is required';
      case NameValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure("");

  const Name.dirty([String value = ""]) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    // Consider empty as valid
    return value.isEmpty
        ? null
        : (RegularExpression.nameRegExp.hasMatch(value)
            ? null
            : NameValidationError.invalid);
  }
}

class NameRequired extends FormzInput<String, NameValidationError> {
  const NameRequired.pure() : super.pure('');

  const NameRequired.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    final name = value.trim();
    return name.isEmpty
        ? NameValidationError.empty
        : RegularExpression.nameRegExp.hasMatch(name)
            ? null
            : NameValidationError.invalid;
  }
}
