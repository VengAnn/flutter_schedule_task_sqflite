import 'package:flutter/material.dart';

class ThemeCustom {
  static final ligthMode = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade900,
    ),
  );

  //darkMode
  static final darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300,
    ),
  );
}
