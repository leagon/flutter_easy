import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

class DialogComplexView extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final Widget? message;

  final String? confirmTitle;
  final VoidCallback? onConfirm;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final Axis optionsAxis;

  const DialogComplexView({
    Key? key,
    this.icon,
    this.title,
    this.message,
    this.confirmTitle,
    this.onConfirm,
    this.cancelTitle,
    this.onCancel,
    this.optionsAxis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DialogComplexView(
      icon: icon,
      title: title,
      message: message,
      confirmTitle: confirmTitle,
      onConfirm: onConfirm,
      cancelTitle: cancelTitle,
      onCancel: onCancel,
      optionsAxis: optionsAxis,
    );
  }
}

class _DialogComplexView extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final Widget? message;

  final String? confirmTitle;
  final VoidCallback? onConfirm;
  final String? cancelTitle;
  final VoidCallback? onCancel;
  final Axis optionsAxis;

  const _DialogComplexView({
    Key? key,
    this.icon,
    this.title,
    this.message,
    this.confirmTitle,
    this.onConfirm,
    this.cancelTitle,
    this.onCancel,
    this.optionsAxis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// icon
            if (icon != null) ...[
              icon!,
              const SizedBox(height: 18),
            ],

            /// title
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle().black.w600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
            ],

            /// message
            if (message != null) ...[
              message!,
              const SizedBox(height: 20),
            ],
            if (optionsAxis == Axis.horizontal) ...[
              /// horizontal
              Row(
                children: [
                  /// cancel
                  if (cancelTitle != null)
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF3C5BFF),
                        ),
                        onPressed: onCancel,
                        child: AutoSizeText(
                          cancelTitle!,
                          maxLines: 1,
                          minFontSize: 5,
                        ),
                      ),
                    ),

                  if (cancelTitle != null && confirmTitle != null)
                    const SizedBox(width: 10),

                  /// confirm
                  if (confirmTitle != null)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).extension<EasyTheme>()?.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onConfirm,
                        child: AutoSizeText(
                          confirmTitle!,
                          maxLines: 1,
                          minFontSize: 5,
                        ),
                      ),
                    ),
                ],
              ),
            ] else ...[
              /// vertical
              Column(
                children: [
                  /// confirm
                  if (confirmTitle != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).extension<EasyTheme>()?.primary,
                        backgroundColor: Colors.white,
                        fixedSize: const Size.fromWidth(100),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: onConfirm,
                      child: AutoSizeText(
                        confirmTitle!,
                        maxLines: 1,
                        minFontSize: 5,
                      ),
                    ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3C5BFF),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    onPressed: onCancel,
                    child: AutoSizeText(
                      cancelTitle!,
                      maxLines: 1,
                      minFontSize: 5,
                    ),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
