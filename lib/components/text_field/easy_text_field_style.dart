import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum EasyTextFieldBorder { underlined, outlined }

class EasyTextFieldStyle with Diagnosticable {
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? placeholderColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? clearColor;
  final Color? focusErrorBorderColor;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final EasyTextFieldBorder border;

  bool get isUnderlined => border == EasyTextFieldBorder.underlined;

  bool get isOutlined => border == EasyTextFieldBorder.outlined;

  EasyTextFieldStyle({
    this.fontColor,
    this.backgroundColor,
    this.placeholderColor,
    this.borderColor,
    this.focusBorderColor,
    this.borderRadius,
    this.clearColor,
    this.focusErrorBorderColor,
    this.borderWidth = 0.5,
    this.border = EasyTextFieldBorder.outlined,
  });

  EasyTextFieldStyle merge(EasyTextFieldStyle? other) {
    if (other == null) {
      return this;
    }
    return EasyTextFieldStyle(
      fontColor: other.fontColor ?? fontColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      placeholderColor: other.placeholderColor ?? placeholderColor,
      borderColor: other.borderColor ?? borderColor,
      focusBorderColor: other.focusBorderColor ?? focusBorderColor,
      borderRadius: other.borderRadius ?? borderRadius,
      clearColor: other.clearColor ?? clearColor,
      focusErrorBorderColor:
          other.focusErrorBorderColor ?? focusErrorBorderColor,
      borderWidth: other.borderWidth,
      border: other.border,
    );
  }

  factory EasyTextFieldStyle.outlined({
    Color? fontColor,
    Color? backgroundColor,
    Color? placeholderColor,
    Color? borderColor,
    Color? focusBorderColor,
    BorderRadius? borderRadius,
    Color? clearColor,
    Color? focusErrorBorderColor,
    double borderWidth = 0.5,
  }) {
    return EasyTextFieldStyle(
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      placeholderColor: placeholderColor,
      borderColor: borderColor,
      focusBorderColor: focusBorderColor,
      borderRadius: borderRadius,
      clearColor: clearColor,
      focusErrorBorderColor: focusErrorBorderColor,
      borderWidth: borderWidth,
      border: EasyTextFieldBorder.outlined,
    );
  }

  factory EasyTextFieldStyle.underlined({
    Color? fontColor,
    Color? backgroundColor,
    Color? placeholderColor,
    Color? borderColor,
    Color? focusBorderColor,
    BorderRadius? borderRadius,
    Color? clearColor,
    Color? focusErrorBorderColor,
    double borderWidth = 0.5,
  }) {
    return EasyTextFieldStyle(
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      placeholderColor: placeholderColor,
      borderColor: borderColor,
      focusBorderColor: focusBorderColor,
      borderRadius: borderRadius,
      clearColor: clearColor,
      focusErrorBorderColor: focusErrorBorderColor,
      borderWidth: borderWidth,
      border: EasyTextFieldBorder.underlined,
    );
  }

  static EasyTextFieldStyle defaultOutlinedTextFieldStyle = EasyTextFieldStyle(
    fontColor: Colors.black87,
    backgroundColor: Colors.white,
    placeholderColor: Colors.black26,
    borderColor: const Color(0xFFDCDFE6),
    focusBorderColor: const Color(0xFF3C5BFF),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    clearColor: Colors.black26,
    focusErrorBorderColor: const Color(0xFFF44336),
    borderWidth: 0.5,
    border: EasyTextFieldBorder.outlined,
  );

  static EasyTextFieldStyle defaultUnderlinedTextFieldStyle =
      EasyTextFieldStyle(
    fontColor: Colors.black87,
    backgroundColor: Colors.white,
    placeholderColor: Colors.black26,
    borderColor: const Color(0xFFDCDFE6),
    focusBorderColor: const Color(0xFF3C5BFF),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    clearColor: Colors.black26,
    focusErrorBorderColor: const Color(0xFFF44336),
    borderWidth: 0.5,
    border: EasyTextFieldBorder.underlined,
  );
}

/// TuringTextFieldStyle - transparent
EasyTextFieldStyle transparent = EasyTextFieldStyle(
  borderColor: Colors.transparent,
  focusBorderColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  focusErrorBorderColor: Colors.transparent,
);

/// TuringTextFieldStyle - search
EasyTextFieldStyle search = EasyTextFieldStyle(
  borderColor: Colors.transparent,
  focusBorderColor: Colors.transparent,
  backgroundColor: const Color(0xFFF5F5F5),
  focusErrorBorderColor: Colors.transparent,
  borderWidth: 0.0,
  border: EasyTextFieldBorder.outlined,
  borderRadius: BorderRadius.circular(18),
);

/// TuringTextFieldStyle - edit
EasyTextFieldStyle edit = EasyTextFieldStyle.outlined(
  borderColor: Colors.transparent,
  focusBorderColor: Colors.transparent,
  backgroundColor: const Color(0xFFF5F5F5),
  focusErrorBorderColor: Colors.transparent,
  borderRadius: BorderRadius.circular(6),
);

EasyTextFieldStyle edgeCamera = EasyTextFieldStyle.outlined(
  borderWidth: 1,
  borderColor: Colors.transparent,
  focusBorderColor: const Color(0xFF3C5BFF),
  backgroundColor: const Color(0xFFF5F5F5),
  focusErrorBorderColor: const Color(0xFFF44336),
  borderRadius: BorderRadius.circular(6),
);
