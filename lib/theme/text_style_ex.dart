import 'package:flutter/material.dart';

import 'font_size.dart';

extension TextStyleEx on TextStyle {
  TextStyle get white => color(Colors.white);

  TextStyle get black => color(Colors.black);

  TextStyle get black87 => color(Colors.black87);

  TextStyle get black54 => color(Colors.black54);

  TextStyle get black38 => color(Colors.black38);

  TextStyle get black26 => color(Colors.black26);

  TextStyle get black12 => color(Colors.black12);

  TextStyle get red => color(Colors.red);

  TextStyle get yellow => color(Colors.yellow);

  TextStyle get blue => color(Colors.blue);

  TextStyle get grey => color(Colors.grey);

  TextStyle color(Color color) => copyWith(color: color);

  TextStyle get s34 => copyWith(
        fontSize: FontSize.s34.size,
        letterSpacing: FontSize.s34.letterSpacing,
        height: FontSize.s34.lineHeight,
      );

  TextStyle get s28 => copyWith(
        fontSize: FontSize.s28.size,
        letterSpacing: FontSize.s28.letterSpacing,
        height: FontSize.s28.lineHeight,
      );

  TextStyle get s22 => copyWith(
        fontSize: FontSize.s22.size,
        letterSpacing: FontSize.s22.letterSpacing,
        height: FontSize.s22.lineHeight,
      );

  TextStyle get s20 => copyWith(
        fontSize: FontSize.s20.size,
        letterSpacing: FontSize.s20.letterSpacing,
        height: FontSize.s20.lineHeight,
      );

  TextStyle get s17 => copyWith(
        fontSize: FontSize.s17.size,
        letterSpacing: FontSize.s17.letterSpacing,
        height: FontSize.s17.lineHeight,
      );

  TextStyle get s16 => copyWith(
        fontSize: FontSize.s16.size,
        letterSpacing: FontSize.s16.letterSpacing,
        height: FontSize.s16.lineHeight,
      );

  TextStyle get s15 => copyWith(
        fontSize: FontSize.s15.size,
        letterSpacing: FontSize.s15.letterSpacing,
        height: FontSize.s15.lineHeight,
      );

  TextStyle get s14 => copyWith(
        fontSize: FontSize.s14.size,
        letterSpacing: FontSize.s14.letterSpacing,
        height: FontSize.s14.lineHeight,
      );

  TextStyle get s13 => copyWith(
        fontSize: FontSize.s13.size,
        letterSpacing: FontSize.s13.letterSpacing,
        height: FontSize.s13.lineHeight,
      );

  TextStyle get s12 => copyWith(
        fontSize: FontSize.s12.size,
        letterSpacing: FontSize.s12.letterSpacing,
        height: FontSize.s12.lineHeight,
      );

  TextStyle get s11 => copyWith(
        fontSize: FontSize.s11.size,
        letterSpacing: FontSize.s11.letterSpacing,
        height: FontSize.s11.lineHeight,
      );

  TextStyle fontSize(double fontSize) => copyWith(fontSize: fontSize);

  TextStyle letterSpacing(double letterSpacing) =>
      copyWith(letterSpacing: letterSpacing);

  TextStyle height(double height) => copyWith(height: height);

  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);

  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
}
