import 'package:flutter/material.dart';

extension ColorX on Color {
  Color get textColor {
    final Brightness brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.light ? Colors.black : Colors.white;
  }
}
