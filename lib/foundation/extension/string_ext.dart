extension StringExt on String {
  String capitalize() {
    if (isEmpty) return '';
    if (length == 1) {
      return toUpperCase();
    } else {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
  }

  String placeholder({String placeholder = '-'}) {
    if (isEmpty) return placeholder;
    return this;
  }
}
