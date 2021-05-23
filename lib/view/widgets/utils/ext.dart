import 'dart:ui';

extension ColorExt on String {
  /// Converts a hex color code to [Color].
  ///
  /// **For example:**
  /// ```dart
  /// Color hexToColor = "EAFAF1".toColor();
  /// ```
  /// **Then `hexToColor` should be:**
  /// ```dart
  /// Color(0xFFEAFAF1)
  /// ```
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";

    if (hexColor.length == 8) return Color(int.parse("0x$hexColor"));
  }

  colorToTitle() {
    switch (this) {
      case "#FDFEFE":
        return "Default";
        break;
      case "#F5EEF8":
        return "Purple";
        break;
      case "#E8F8F5":
        return "Green";
        break;
      case "#EBF5FB":
        return "Blue";
        break;
      case "#FEF9E7":
        return "Yellow";
        break;
    }
  }
}
