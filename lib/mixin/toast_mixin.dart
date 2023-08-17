import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';
import 'package:fluttertoast/fluttertoast.dart' hide Toast;

mixin ToastMixin {
  static FToast get _fToast => FToast();

  void _init(BuildContext context) {
    _fToast.init(context);
  }

  /// dismiss toast
  void toastDismiss() => _fToast.removeCustomToast();

  /// show text toast
  void toastText(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    toastDismiss();
    _init(context);
    _fToast.showToast(
      child: TextToast(message: message),
      gravity: ToastGravity.CENTER,
      toastDuration: duration,
    );
  }

  /// show loading toast
  void toastLoading(BuildContext context, {String? message}) {
    toastDismiss();
    _init(context);
    _fToast.showToast(
      child: LoadingToast(message: message),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 60),
    );
  }

  /// show scucess toast
  void toastSuccess(
    BuildContext context, {
    String? message,
    Duration duration = const Duration(seconds: 2),
  }) {
    toastImage(
      context,
      const Icon(Icons.check, size: 42, color: Colors.white),
      message: message,
      duration: duration,
    );
  }

  /// show failed toast
  void toastFailed(
    BuildContext context, {
    String? message,
    Duration duration = const Duration(seconds: 2),
  }) {
    toastImage(
      context,
      const Icon(Icons.error_outline, size: 42, color: Colors.white),
      message: message,
      duration: duration,
    );
  }

  /// show TuringError toast
  void toastError(
    BuildContext context,
    EasyError e, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final bool isSocketError = e.ec == ErrorCode.socketException;
    final message = isSocketError
        ? "There is a problem connecting to network. Please try again later."
        : e.em;
    toastFailed(context, message: message, duration: duration);
  }

  /// show image toast
  void toastImage(
    BuildContext context,
    Widget image, {
    String? message,
    Duration duration = const Duration(seconds: 2),
    double? width,
    double? height,
  }) {
    toastDismiss();
    _init(context);
    _fToast.showToast(
      child: ImageToast(image: image, message: message),
      gravity: ToastGravity.CENTER,
      toastDuration: duration,
    );
  }

  /// show toast with custom child
  void toast(
    BuildContext context, {
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) {
    toastDismiss();
    _init(context);
    _fToast.showToast(
      child: ToastBackground(boxConstraints: desenBoxConstrains, child: child),
      gravity: ToastGravity.CENTER,
      toastDuration: duration,
    );
  }

  /// show status toast
  void toastStatus(
    BuildContext context,
    Status status, {
    Duration duration = const Duration(seconds: 2),
  }) {
    toastDismiss();
    _init(context);
    if (status.isLoading) toastLoading(context);
    if (status.isSuccess && status.toast) {
      toastSuccess(context, message: status.message, duration: duration);
    }
    if (status.isFailure && status.toast) {
      toastError(context, status.error, duration: duration);
    }
  }
}
