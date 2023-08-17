import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_complex_view.dart';

/// Page with complex dialog with icon, title, message, cancelButton and/or okButton
class DialogPage extends StatelessWidget {
  const DialogPage({
    Key? key,
    this.icon,
    this.title,
    this.message,
    this.cancelTitle,
    this.onCancel,
    this.confirmTitle,
    this.onConfirm,
    this.barrierDismissible = true,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final Widget? message;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final String? confirmTitle;
  final VoidCallback? onConfirm;
  final bool barrierDismissible;

  static Route route({
    Widget? icon,
    String? title,
    Widget? message,
    String? cancelTitle = 'Cancel',
    VoidCallback? onCancel,
    String? confirmTitle = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    return CupertinoModalPopupRoute<void>(
      builder: (_) => DialogPage(
        icon: icon,
        title: title,
        message: message,
        cancelTitle: cancelTitle,
        onCancel: onCancel,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: WillPopScope(
        onWillPop: () async {
          barrierDismissible
              ? {
                  Navigator.of(context).pop(),
                  onCancel?.call(),
                }
              : null;
          return barrierDismissible;
        },
        child: GestureDetector(
          onTap: () {
            barrierDismissible
                ? {
                    Navigator.of(context).pop(),
                    onCancel?.call(),
                  }
                : null;
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: DialogComplexView(
                  icon: icon,
                  title: title,
                  message: message,
                  confirmTitle: confirmTitle,
                  onConfirm: () {
                    barrierDismissible
                        ? {
                            Navigator.of(context).pop(),
                            onConfirm?.call(),
                          }
                        : onConfirm?.call();
                  },
                  cancelTitle: cancelTitle,
                  onCancel: () {
                    barrierDismissible
                        ? {
                            Navigator.of(context).pop(),
                            onCancel?.call(),
                          }
                        : onCancel?.call();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
