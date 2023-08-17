import '../error/easy_error.dart';

enum EasyStatus { idle, loading, process, success, failure }

class Status {
  final EasyStatus status;
  final String? message;
  final EasyError error;
  final bool toast;

  const Status({
    required this.status,
    this.message,
    this.error = CustomError.success,
    this.toast = true,
  });

  bool get isIdle => status == EasyStatus.idle;

  bool get isLoading => status == EasyStatus.loading;

  bool get isProcess => status == EasyStatus.process;

  bool get isSuccess => status == EasyStatus.success;

  bool get isFailure => status == EasyStatus.failure;

  const Status.failure({this.error = CustomError.success, this.toast = true})
      : message = null,
        status = EasyStatus.failure;

  const Status.success({this.message, this.toast = false})
      : error = CustomError.success,
        status = EasyStatus.success;

  const Status.loading()
      : status = EasyStatus.loading,
        message = null,
        error = CustomError.success,
        toast = true;

  const Status.idle()
      : status = EasyStatus.idle,
        message = null,
        error = CustomError.success,
        toast = false;

  const Status.process()
      : status = EasyStatus.process,
        message = null,
        error = CustomError.success,
        toast = false;

  @override
  String toString() {
    return '$status\nmessage = $message\nerror = $error';
  }
}
