import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

class DialogColumnView extends StatelessWidget {
  final String? title;
  final String? message;
  final List<DialogOption> options;

  const DialogColumnView({
    Key? key,
    this.title,
    this.message,
    this.options = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: title != null
          ? Align(
              alignment: Alignment.center,
              child: Text(title!, textAlign: TextAlign.center),
            )
          : null,
      titleTextStyle: const TextStyle().black.w600.s17,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 70),
      contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      children: [
        if (message != null) ...[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 16.0),
            child: Text(message!, textAlign: TextAlign.center),
          ),
        ],
        Divider(height: 0.5, color: Colors.black.withOpacity(0.23)),
        for (var option in options) ...[
          SimpleDialogOption(
            onPressed: () {
              option.onPressed?.call();
              Navigator.of(context).maybePop();
            },
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: Text(option.title, style: option.style.column(context)),
            ),
          ),
          Divider(height: 0.5, color: Colors.black.withOpacity(0.23)),
        ],
      ],
    );
  }
}
