import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum MacAddressValidationError { invalid, empty }

extension MacAddressValidationErrorMesage on MacAddressValidationError {
  String message({String title = 'Mac address', String? message}) {
    switch (this) {
      case MacAddressValidationError.empty:
        return message ?? '$title is required';
      case MacAddressValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class MacAddress extends FormzInput<String, MacAddressValidationError> {
  const MacAddress.pure() : super.pure("");
  const MacAddress.dirty([String value = ""]) : super.dirty(value);

  @override
  MacAddressValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (RegularExpression.macAddressRegExp.hasMatch(value)
            ? null
            : MacAddressValidationError.invalid);
  }
}

class MacAddressRequired extends FormzInput<String, MacAddressValidationError> {
  const MacAddressRequired.pure() : super.pure('');
  const MacAddressRequired.dirty([String value = '']) : super.dirty(value);

  @override
  MacAddressValidationError? validator(String value) {
    return value.isEmpty
        ? MacAddressValidationError.empty
        : RegularExpression.macAddressRegExp.hasMatch(value)
            ? null
            : MacAddressValidationError.invalid;
  }
}
