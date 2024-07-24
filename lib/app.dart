import 'package:currency_converter/screens/home.dart';
import 'package:currency_converter/services/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignmentApp extends StatelessWidget {
  const AssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment',
      themeMode: ThemeMode.dark,
      theme: themeProvider.theme,
      home: const HomePage(),
    );
  }
}
