import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final Color _primaryColor = const Color(0xff181818);
  final Color _errorColor = const Color(0xffdf493e);

  Color get primaryColor => _primaryColor;
  Color get errorColor => _errorColor;

  ThemeData get theme => _getThemeData();

  ThemeData _getThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: _primaryColor,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
