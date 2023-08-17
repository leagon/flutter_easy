import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';
import 'package:flutter_easy/theme/theme_values.dart';

import 'dialog_option.dart';

class BottomSheetView extends StatelessWidget {
  final String? title;
  final String? message;
  final List<DialogOption> options;

  const BottomSheetView({
    super.key,
    this.title,
    this.message,
    this.options = const [],
  });

  @override
  Widget build(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            ListTile(
              tileColor: Colors.white,
              dense: true,
              title: Text(
                title!,
                style: const TextStyle().black87.s17,
              ),
            ),
            const Divider(height: 0.5, color: Colors.white),
          ],
          for (var option in options) ...[
            ListTile(
              tileColor: Colors.white,
              dense: true,
              leading: option.icon,
              minLeadingWidth: 0,
              title: Text(
                option.title,
                style: option.style.isNormal && option.selected
                    ? TextStyle(
                        color: easyTheme?.selected ?? kDefaultSelectedColor,
                      ).s20
                    : option.style.bottomSheet(context),
                textAlign: option.titleAlign,
              ),
              onTap: () {
                Navigator.of(context).pop();
                option.onPressed?.call();
              },
            ),
            const Divider(height: 0.5, color: Colors.white),
          ]
        ],
      ),
    );
  }
}

class CupertinoBottomSheetView extends StatelessWidget {
  final String? title;
  final String? message;
  final List<DialogOption> options;
  final Widget? messageWidget;

  const CupertinoBottomSheetView({
    super.key,
    this.title,
    this.message,
    this.options = const [],
    this.messageWidget,
  });

  @override
  Widget build(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    return CupertinoActionSheet(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle().s13.black87,
            )
          : null,
      message: message != null
          ? Text(
              message!,
              style: const TextStyle().s13.black54,
            )
          : messageWidget,
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Cancel',
            style: TextStyle(
              color: easyTheme?.selected ?? kDefaultSelectedColor,
            ).s20.w600),
      ),
      actions: options
          .map((option) => CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                option.onPressed?.call();
              },
              child: Text(
                option.title,
                style: option.style.bottomSheet(context),
              )))
          .toList(),
    );
  }
}
