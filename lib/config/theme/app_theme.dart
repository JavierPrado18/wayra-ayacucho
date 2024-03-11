import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    const colorSeed = Color(0xff24baec);
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
        iconTheme: const IconThemeData(color: colorSeed),
        appBarTheme: AppBarTheme(
            backgroundColor: colorSeed, foregroundColor: Colors.white));
  }
}
