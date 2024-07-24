import 'package:currency_converter/app.dart';
import 'package:currency_converter/services/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const AssignmentApp(),
    ),
  );
}
