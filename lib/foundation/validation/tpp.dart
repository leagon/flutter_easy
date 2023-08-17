import 'package:formz/formz.dart';

enum TppValidationError { empty, invalid, tooShort }

class Tpp extends FormzInput<String, TppValidationError> {
  const Tpp.pure() : super.pure('');

  const Tpp.dirty({String value = ''}) : super.dirty(value);

  @override
  TppValidationError? validator(String value) {
    if (value.length < 7) {
      return TppValidationError.tooShort;
    }

    for (int codeUnit in value.codeUnits) {
      if (codeUnit > '9'.codeUnitAt(0) || codeUnit < '0'.codeUnitAt(0)) {
        return TppValidationError.invalid;
      }
    }

    return null;
  }
}
