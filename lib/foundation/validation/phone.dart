import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum PhoneValidationError { invalid, empty }

extension PhoneValidationErrorMesage on PhoneValidationError {
  String message({String title = 'Phone', String? message}) {
    switch (this) {
      case PhoneValidationError.empty:
        return message ?? '$title is required';
      case PhoneValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure("");
  const Phone.dirty([String value = ""]) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (RegularExpression.phoneRegExp.hasMatch(value)
            ? null
            : PhoneValidationError.invalid);
  }
}

class PhoneRequired extends FormzInput<String, PhoneValidationError> {
  const PhoneRequired.pure() : super.pure('');
  const PhoneRequired.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneValidationError.empty
        : RegularExpression.phoneRegExp.hasMatch(value)
            ? null
            : PhoneValidationError.invalid;
  }
}
