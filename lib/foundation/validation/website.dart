import 'package:formz/formz.dart';

import '../regular_expression/regular_expression.dart';

enum WebsiteValidationError { invalid, empty }

extension WebsiteValidationErrorMesage on WebsiteValidationError {
  String message({String title = 'Website', String? message}) {
    switch (this) {
      case WebsiteValidationError.empty:
        return message ?? '$title is required';
      case WebsiteValidationError.invalid:
        return message ?? '$title format is not valid';
    }
  }
}

class Website extends FormzInput<String, WebsiteValidationError> {
  const Website.pure() : super.pure("");
  const Website.dirty([String value = ""]) : super.dirty(value);

  @override
  WebsiteValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : (RegularExpression.websiteRegExp.hasMatch(value)
            ? null
            : WebsiteValidationError.invalid);
  }
}

class WebsiteRequired extends FormzInput<String, WebsiteValidationError> {
  const WebsiteRequired.pure() : super.pure('');
  const WebsiteRequired.dirty([String value = '']) : super.dirty(value);

  @override
  WebsiteValidationError? validator(String value) {
    return value.isEmpty
        ? WebsiteValidationError.empty
        : RegularExpression.websiteRegExp.hasMatch(value)
            ? null
            : WebsiteValidationError.invalid;
  }
}
