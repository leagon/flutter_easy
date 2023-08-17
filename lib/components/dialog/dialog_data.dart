import 'package:flutter/material.dart';

import 'dialog_option.dart';

enum DialogDataStyle { message, complex, column, bottomSheet }

class DialogData {
  final DialogDataStyle style;

  final Widget? icon;
  final String? title;

  final String? message;
  final Widget? messageWidget;

  final String? cancelTitle;
  final VoidCallback? onCancel;

  final String? confirmTitle;
  final VoidCallback? onConfirm;

  final List<DialogOption> options;
  final Axis optionsAxis;

  final bool barrierDismissible;

  const DialogData({
    required this.style,
    this.icon,
    this.title,
    this.message,
    this.messageWidget,
    this.cancelTitle,
    this.onCancel,
    this.confirmTitle,
    this.onConfirm,
    this.options = const [],
    this.barrierDismissible = true,
    this.optionsAxis = Axis.horizontal,
  }) : assert(message == null || messageWidget == null);

  factory DialogData.message({
    String? title,
    String? message,
    Widget? messageWidget,
    String? cancelTitle = 'Cancel',
    VoidCallback? onCancel,
    String? confirmTitle = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return DialogData(
      style: DialogDataStyle.message,
      title: title,
      message: message,
      messageWidget: messageWidget,
      cancelTitle: cancelTitle,
      onCancel: onCancel,
      confirmTitle: confirmTitle,
      onConfirm: onConfirm,
      barrierDismissible: barrierDismissible,
    );
  }

  factory DialogData.complex({
    Widget? icon,
    String? title,
    Widget? message,
    String? cancelTitle = 'Cancel',
    VoidCallback? onCancel,
    String? confirmTitle = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    Axis optionsAxis = Axis.horizontal,
  }) {
    return DialogData(
      style: DialogDataStyle.complex,
      icon: icon,
      title: title,
      messageWidget: message,
      cancelTitle: cancelTitle,
      onCancel: onCancel,
      confirmTitle: confirmTitle,
      onConfirm: onConfirm,
      barrierDismissible: barrierDismissible,
      optionsAxis: optionsAxis,
    );
  }

  factory DialogData.column({
    String? title,
    String? message,
    List<DialogOption> options = const [],
    bool barrierDismissible = true,
  }) {
    return DialogData(
      style: DialogDataStyle.column,
      title: title,
      message: message,
      options: options,
      barrierDismissible: barrierDismissible,
    );
  }

  factory DialogData.bottomSheet({
    String? title,
    String? message,
    List<DialogOption> options = const [],
  }) {
    return DialogData(
      style: DialogDataStyle.bottomSheet,
      title: title,
      message: message,
      options: options,
    );
  }
}
