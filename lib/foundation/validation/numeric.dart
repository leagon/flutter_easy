import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum NumericValidationError { invalid, empty }

extension NumbericValidationErrorMessage on NumericValidationError {
  String message({String title = 'Input', String? message}) {
    switch (this) {
      case NumericValidationError.empty:
        return message ?? '$title is required';
      case NumericValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Numeric extends FormzInput<String, NumericValidationError> {
  const Numeric.pure() : super.pure("");
  const Numeric.dirty([String value = ""]) : super.dirty(value);

  @override
  NumericValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (RegularExpression.numericRegExp.hasMatch(value)
            ? null
            : NumericValidationError.invalid);
  }
}

class NumericRequired extends FormzInput<String, NumericValidationError> {
  const NumericRequired.pure() : super.pure("");
  const NumericRequired.dirty([String value = ""]) : super.dirty(value);

  @override
  NumericValidationError? validator(String value) {
    return value.isEmpty
        ? NumericValidationError.empty
        : RegularExpression.numericRegExp.hasMatch(value)
            ? null
            : NumericValidationError.invalid;
  }
}
