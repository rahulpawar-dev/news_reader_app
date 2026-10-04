import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  final _box = Hive.box('settings_box');

  @override
  ThemeMode build() {

    final isDark = _box.get('isDarkMode', defaultValue: false);
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final isCurrentlyDark = state == ThemeMode.dark;
    // Swaping  the state
    state = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;

    _box.put('isDarkMode', !isCurrentlyDark);
  }
}