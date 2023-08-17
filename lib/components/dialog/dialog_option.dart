import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';
import 'package:flutter_easy/theme/theme_values.dart';

enum DialogOptionStyle {
  normal,
  cancel,
  destructive;

  bool get isCancel => this == DialogOptionStyle.cancel;

  bool get isNormal => this == DialogOptionStyle.normal;

  TextStyle column(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    switch (this) {
      case DialogOptionStyle.cancel:
        return const TextStyle().w600.s14.black54;
      case DialogOptionStyle.normal:
        return TextStyle(
          color: easyTheme?.primary ?? kDefaultPrimaryColor,
        ).w600.s14;
      case DialogOptionStyle.destructive:
        return TextStyle(
          color: easyTheme?.destructive ?? kDefaultDestructiveColor,
        ).w600.s14;
    }
  }

  TextStyle bottomSheet(BuildContext context) {
    final easyTheme = Theme.of(context).extension<EasyTheme>();

    switch (this) {
      case DialogOptionStyle.cancel:
        return const TextStyle().s20.black54;
      case DialogOptionStyle.destructive:
        return TextStyle(
          color: easyTheme?.destructive ?? kDefaultDestructiveColor,
        ).s20;
      case DialogOptionStyle.normal:
        return Platform.isIOS
            ? TextStyle(color: easyTheme?.selected ?? kDefaultSelectedColor).s20
            : const TextStyle().s20.black87;
    }
  }
}

class DialogOption {
  final DialogOptionStyle style;
  final String title;
  final Widget? icon;
  final VoidCallback? onPressed;
  final TextAlign titleAlign;
  final bool selected;

  DialogOption({
    required this.style,
    required this.title,
    this.icon,
    this.onPressed,
    this.titleAlign = TextAlign.start,
    this.selected = false,
  });

  factory DialogOption.normal({
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    TextAlign titleAlign = TextAlign.start,
    bool selected = false,
  }) {
    return DialogOption(
      style: DialogOptionStyle.normal,
      title: title,
      icon: icon,
      onPressed: onPressed,
      titleAlign: titleAlign,
      selected: selected,
    );
  }

  factory DialogOption.cancel({
    String title = 'Cancel',
    Widget? icon,
    VoidCallback? onPressed,
    TextAlign titleAlign = TextAlign.start,
  }) {
    return DialogOption(
      style: DialogOptionStyle.cancel,
      title: title,
      icon: icon,
      onPressed: onPressed,
      titleAlign: titleAlign,
    );
  }

  factory DialogOption.destructive({
    required String title,
    Widget? icon,
    VoidCallback? onPressed,
    TextAlign titleAlign = TextAlign.start,
  }) {
    return DialogOption(
      style: DialogOptionStyle.destructive,
      title: title,
      icon: icon,
      onPressed: onPressed,
      titleAlign: titleAlign,
    );
  }
}
