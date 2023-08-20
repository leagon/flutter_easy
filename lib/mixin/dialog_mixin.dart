import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

mixin DialogMixin {
  /// show message dialog, there are two styles for ios and android.
  void showMessageDialog(
    BuildContext context, {
    String? title,
    String? message,
    Widget? messageWidget,
    String? confirmTitle = 'OK',
    VoidCallback? onConfirm,
    String? cancelTitle = 'Cancel',
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final messageView = DialogMessageView(
      title: title,
      message: message,
      messageWidget: messageWidget,
      confirmTitle: confirmTitle,
      onConfirm: () {
        onConfirm?.call();
        Navigator.of(context).maybePop();
      },
      cancelTitle: cancelTitle,
      onCancel: () {
        onCancel?.call();
        Navigator.of(context).maybePop();
      },
    );

    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => messageView,
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => messageView,
      );
    }
  }

  /// show complex dialog, it's a custom designed style.
  void showComplexDialog(
    BuildContext context, {
    Widget? icon,
    String? title,
    Widget? message,
    String? confirmTitle = 'OK',
    VoidCallback? onConfirm,
    String? cancelTitle = 'Cancel',
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    Axis optionsAxis = Axis.horizontal,
  }) {
    final messageView = DialogComplexView(
      icon: icon,
      title: title,
      message: message,
      confirmTitle: confirmTitle,
      optionsAxis: optionsAxis,
      onConfirm: () {
        onConfirm?.call();
        Navigator.of(context).maybePop();
      },
      cancelTitle: cancelTitle,
      onCancel: () {
        onCancel?.call();
        Navigator.of(context).maybePop();
      },
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => messageView,
    );
  }

  /// show column dialog
  /// it's a custom designed style with column buttons (above two buttons).
  void showColumnDialog(
    BuildContext context, {
    String? title,
    String? message,
    List<DialogOption> options = const [],
    bool barrierDismissible = true,
  }) {
    final columnView = DialogColumnView(
      title: title,
      message: message,
      options: options,
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => columnView,
    );
  }

  /// show dialog with dialog data
  void showDataDialog(BuildContext context, DialogData data) {
    switch (data.style) {
      case DialogDataStyle.message:
        showMessageDialog(
          context,
          title: data.title,
          message: data.message,
          messageWidget: data.messageWidget,
          cancelTitle: data.cancelTitle,
          onCancel: data.onCancel,
          confirmTitle: data.confirmTitle,
          onConfirm: data.onConfirm,
          barrierDismissible: data.barrierDismissible,
        );
        break;
      case DialogDataStyle.complex:
        showComplexDialog(
          context,
          icon: data.icon,
          title: data.title,
          message: data.messageWidget,
          cancelTitle: data.cancelTitle,
          onCancel: data.onCancel,
          confirmTitle: data.confirmTitle,
          onConfirm: data.onConfirm,
          optionsAxis: data.optionsAxis,
          barrierDismissible: data.barrierDismissible,
        );
        break;
      case DialogDataStyle.column:
        showColumnDialog(
          context,
          title: data.title,
          message: data.message,
          options: data.options,
          barrierDismissible: data.barrierDismissible,
        );
        break;
      case DialogDataStyle.bottomSheet:
        showBottomSheetDialog(
          context,
          title: data.title,
          message: data.message,
          options: data.options,
        );
        break;
    }
  }

  /// show bottom sheet for iOS or android.
  /// iOS build with a cancel button by default.
  /// Android doesn't have cancel button and message by default.
  void showBottomSheetDialog(
    BuildContext context, {
    String? title,
    String? message,
    List<DialogOption> options = const [],
  }) {
    Platform.isIOS
        ? showCupertinoBottomSheetDialog(
            context,
            title: title,
            message: message,
            options: options,
          )
        : showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => BottomSheetView(
              title: title,
              message: message,
              options: options,
            ),
          );
  }

  /// show bottom sheet for iOS.
  /// Build with a cancel button by default.
  void showCupertinoBottomSheetDialog(
    BuildContext context, {
    String? title,
    String? message,
    List<DialogOption> options = const [],
    Widget? messageWidget,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      builder: (context) => CupertinoBottomSheetView(
        title: title,
        message: message,
        options: options,
        messageWidget: messageWidget,
      ),
    );
  }

  /// show Error Dialog
  void showErrorDialog(
    BuildContext context, {
    required EasyError e,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    VoidCallback? onRetry,
  }) {
    final bool isSocketError = e.ec == ErrorCode.socketException;
    final String? title = isSocketError
        ? "Network Error"
        : e.dm.isNotEmpty
            ? e.dm.capitalize()
            : null;
    final String message = isSocketError
        ? "There is a problem connecting to network. Please try again later."
        : e.em;
    final String? cancelTitle = isSocketError ? "Cancel" : null;
    final String okTitle = isSocketError && onRetry != null ? "Retry" : "OK";

    showMessageDialog(
      context,
      title: title,
      message: message,
      cancelTitle: cancelTitle,
      confirmTitle: okTitle,
      onConfirm: isSocketError ? onRetry : onConfirm,
      onCancel: onCancel,
    );
  }
}
