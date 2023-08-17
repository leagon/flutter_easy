import 'package:flutter_easy/foundation/error/easy_error.dart';

mixin TuringErrorMixin {
  handleError(dynamic error) {
    throw convertError(error);
  }

  convertError(dynamic error) {
    if (error is EasyError) return error;
    return CustomError.other(error.toString());
  }
}
