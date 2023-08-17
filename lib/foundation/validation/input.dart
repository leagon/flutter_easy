import 'package:formz/formz.dart';

enum InputValidationError { invalid, empty }

extension InputValidationErrorMessage on InputValidationError {
  String message({String title = 'Input', String? message}) {
    switch (this) {
      case InputValidationError.empty:
        return message ?? '$title is required';
      case InputValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Input extends FormzInput<String, InputValidationError> {
  const Input.pure() : super.pure("");
  const Input.dirty([String value = ""]) : super.dirty(value);

  @override
  InputValidationError? validator(String value) {
    // always valid
    return null;
  }
}

class InputRequired extends FormzInput<String, InputValidationError> {
  const InputRequired.pure() : super.pure("");
  const InputRequired.dirty([String value = ""]) : super.dirty(value);

  @override
  InputValidationError? validator(String value) {
    return value.isEmpty ? InputValidationError.empty : null;
  }
}
