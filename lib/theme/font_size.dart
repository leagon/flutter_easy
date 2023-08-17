enum FontSize {
  s34(34, 0.37, 41 / 34),
  s28(28, 0.36, 34 / 28),
  s22(22, 0.35, 24 / 20),
  s20(20, 0.38, 24 / 20),
  s17(17, -0.41, 22 / 17),
  s16(16, -0.32, 21 / 16),
  s15(15, -0.24, 20 / 15),
  s14(14, -0.08, 19 / 14),
  s13(13, -0.08, 18 / 13),
  s12(12, 0, 16 / 12),
  s11(11, 0.07, 13 / 11);

  final double size;
  final double letterSpacing;
  final double lineHeight;

  const FontSize(this.size, this.letterSpacing, this.lineHeight);
}
