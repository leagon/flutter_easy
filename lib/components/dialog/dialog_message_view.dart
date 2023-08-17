import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';
import 'package:flutter_easy/theme/theme_values.dart';

class DialogMessageView extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final String? confirmTitle;
  final VoidCallback? onConfirm;

  const DialogMessageView({
    super.key,
    this.title,
    this.message,
    this.messageWidget,
    this.cancelTitle,
    this.onCancel,
    this.confirmTitle,
    this.onConfirm,
  }) : assert(message == null || messageWidget == null);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _DialogIosMessageView(
            title: title,
            message: message,
            messageWidget: messageWidget,
            cancelTitle: cancelTitle,
            onCancel: onCancel,
            confirmTitle: confirmTitle,
            onConfirm: onConfirm,
          )
        : _DialogAndroidMessageView(
            title: title,
            message: message,
            messageWidget: messageWidget,
            cancelTitle: cancelTitle,
            onCancel: onCancel,
            confirmTitle: confirmTitle,
            onConfirm: onConfirm,
          );
  }
}

class _DialogIosMessageView extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final String? confirmTitle;
  final VoidCallback? onConfirm;

  const _DialogIosMessageView({
    this.title,
    this.message,
    this.messageWidget,
    this.cancelTitle,
    this.onCancel,
    this.confirmTitle,
    this.onConfirm,
  }) : assert(message == null || messageWidget == null);

  @override
  Widget build(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    List<CupertinoDialogAction> actions = <CupertinoDialogAction>[];

    if (cancelTitle != null) {
      final cancelAction = CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: onCancel,
        child: Text(cancelTitle!, style: const TextStyle().black54),
      );
      actions.add(cancelAction);
    }

    if (confirmTitle != null) {
      final okAction = CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: onConfirm,
        child: Text(confirmTitle!,
            style: TextStyle(
              color: easyTheme?.primary ?? kDefaultPrimaryColor,
            )),
      );
      actions.add(okAction);
    }

    return CupertinoAlertDialog(
      title: title != null
          ? Text(title!, style: const TextStyle().black.w600)
          : null,
      content: message != null
          ? Text(
              message!,
              style: const TextStyle().s13.black,
              textAlign: TextAlign.center,
            )
          : messageWidget != null
              ? messageWidget!
              : null,
      actions: actions,
    );
  }
}

class _DialogAndroidMessageView extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final String? confirmTitle;
  final VoidCallback? onConfirm;

  const _DialogAndroidMessageView({
    this.title,
    this.message,
    this.messageWidget,
    this.cancelTitle,
    this.onCancel,
    this.confirmTitle,
    this.onConfirm,
  }) : assert(message == null || messageWidget == null);

  @override
  Widget build(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    List<TextButton> actions = <TextButton>[];

    if (cancelTitle != null) {
      final cancelAction = TextButton(
        onPressed: onCancel,
        child: Text(
          cancelTitle!.toUpperCase(),
          style: TextStyle(
            color: easyTheme?.primary ?? kDefaultPrimaryColor,
          ).s14.w500,
        ),
      );
      actions.add(cancelAction);
    }

    if (confirmTitle != null) {
      final okAction = TextButton(
        onPressed: onConfirm,
        child: Text(confirmTitle!.toUpperCase(),
            style: TextStyle(
              color: easyTheme?.primary ?? kDefaultPrimaryColor,
            ).s14.w500),
      );
      actions.add(okAction);
    }

    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle().s16.black87.w500,
            )
          : null,
      scrollable: true,
      content: message != null
          ? Text(
              message!,
              style: const TextStyle().s13.black,
            )
          : messageWidget != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [messageWidget!],
                )
              : null,
      actions: actions,
    );
  }
}
