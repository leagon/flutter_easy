import 'package:flutter/material.dart';

import 'font_size.dart';

const kDefaultPrimaryColor = Color(0xFF3C5BFF);

extension TextStyleEx on TextStyle {
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get black87 => copyWith(color: Colors.black87);

  TextStyle get black54 => copyWith(color: Colors.black54);

  TextStyle get black38 => copyWith(color: Colors.black38);

  TextStyle get black26 => copyWith(color: Colors.black26);

  TextStyle get black12 => copyWith(color: Colors.black12);

  TextStyle get red => copyWith(color: Colors.red);

  TextStyle get yellow => copyWith(color: Colors.yellow);

  TextStyle get blue => copyWith(color: Colors.blue);

  TextStyle get grey => copyWith(color: Colors.grey);

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

  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);

  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
}
