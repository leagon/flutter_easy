import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

class EasyBackButton extends StatelessWidget {
  final String? previousTitle;
  final Color color;
  final VoidCallback? onPressed;
  final Widget? backIcon;

  const EasyBackButton({
    Key? key,
    this.backIcon,
    this.previousTitle,
    this.color = Colors.black87,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            backIcon ?? Icon(Icons.arrow_back_ios, color: color),
            if (previousTitle != null)
              Text(
                previousTitle!,
                style: const TextStyle().s16.copyWith(color: color),
              ),
          ],
        ),
      ),
    );
  }

  factory EasyBackButton.close({
    Color? color,
    VoidCallback? onPressed,
  }) =>
      EasyBackButton(
        backIcon: Icon(Icons.close, color: color ?? Colors.black87),
        onPressed: onPressed,
      );

  factory EasyBackButton.cancel({
    Color? color,
    VoidCallback? onPressed,
  }) =>
      EasyBackButton.text(
        'Cancel',
        color: color ?? const Color(0xFF3C5BFF),
        onPressed: onPressed,
      );

  factory EasyBackButton.text(
    String text, {
    Color color = const Color(0xFF3C5BFF),
    VoidCallback? onPressed,
  }) =>
      EasyBackButton(
        backIcon: Text(text, style: const TextStyle().copyWith(color: color)),
        onPressed: onPressed,
      );
}
