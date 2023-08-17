import 'package:flutter/material.dart';
import 'package:flutter_easy/theme/theme_values.dart';

class EasyTheme extends ThemeExtension<EasyTheme> {
  final Color primary;
  final Color destructive;
  final Color selected;

  const EasyTheme({
    this.primary = kDefaultPrimaryColor,
    this.destructive = kDefaultDestructiveColor,
    this.selected = kDefaultSelectedColor,
  });

  @override
  EasyTheme copyWith({
    Color? primary,
    Color? destructive,
    Color? selected,
  }) {
    return EasyTheme(
      primary: primary ?? this.primary,
      destructive: destructive ?? this.destructive,
      selected: selected ?? this.selected,
    );
  }

  @override
  EasyTheme lerp(ThemeExtension<EasyTheme>? other, double t) {
    if (other is! EasyTheme) return this;
    return EasyTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      selected: Color.lerp(selected, other.selected, t)!,
    );
  }
}
