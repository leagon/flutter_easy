import 'package:flutter/material.dart';

class EasyTheme extends ThemeExtension<EasyTheme> {
  final Color? primary;
  final Color? destructive;

  const EasyTheme({
    required this.primary,
    required this.destructive,
  });

  @override
  EasyTheme copyWith({
    Color? primary,
    Color? destructive,
  }) {
    return EasyTheme(
      primary: primary ?? this.primary,
      destructive: destructive ?? this.destructive,
    );
  }

  @override
  EasyTheme lerp(ThemeExtension<EasyTheme>? other, double t) {
    if (other is! EasyTheme) return this;
    return EasyTheme(
      primary: Color.lerp(primary, other.primary, t),
      destructive: Color.lerp(destructive, other.destructive, t),
    );
  }
}
