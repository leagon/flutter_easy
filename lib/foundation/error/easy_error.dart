abstract class EasyError {
  final int ec;
  final String em;
  final String dm;

  const EasyError(this.ec, this.em, this.dm);

  bool get isError => ec != ErrorCode.success;

  bool get isNotError => !isError;

  @override
  String toString() {
    return 'ErrorCode: $ec --- ErrorMessage: $em --- DebugMessage: $dm';
  }

  EasyError copyWith({int? ec, String? em, String? dm});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is EasyError &&
        other.ec == ec &&
        other.em == em &&
        other.dm == dm;
  }

  @override
  int get hashCode => ec.hashCode ^ em.hashCode ^ dm.hashCode;
}

class ErrorCode {
  static const success = 0;
  static const connectionTimeout = -1;
  static const sendTimeout = -2;
  static const receiveTimeout = -3;
  static const badCertificate = -4;
  static const badResponse = -5;
  static const cancel = -6;
  static const connectionError = -7;
  static const apiUnknown = -8;
  static const socketException = -9;
  static const dartException = -10;
  static const dartError = -11;
  static const ignore = -12;
  static const other = -13;
  static const unknown = -99;
}

class CustomError extends EasyError {
  const CustomError(super.ec, super.em, super.dm);

  @override
  CustomError copyWith({int? ec, String? em, String? dm}) {
    return CustomError(ec ?? this.ec, em ?? this.em, dm ?? this.dm);
  }

  static const success =
      CustomError(ErrorCode.success, 'Not error', 'CustomError');
  static const unknown =
      CustomError(ErrorCode.unknown, 'Unknown error', 'CustomError');
  static const timeout = CustomError(
    ErrorCode.receiveTimeout,
    "The connection has timed out. Check your network connection and try again.",
    "CustomError",
  );

  static CustomError other(String message) =>
      CustomError(ErrorCode.other, message, 'CustomError');
}
