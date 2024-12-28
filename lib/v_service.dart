import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class VService {
  static final VService _instance = VService._();

  VService._();

  factory VService() => _instance;

  final ValueNotifier<ThemeMode> _currentThemeMode =
      ValueNotifier(defaultThemeMode);

  Map<String, String> _mapLocale = {};

  final ValueNotifier<Locale> _currentLocale = ValueNotifier(defaultLocale);

  ValueNotifier<ThemeMode> get getCurrentThemeMode => _currentThemeMode;

  ValueNotifier<Locale> get getCurrentLocale => _currentLocale;

  void setThemeMode(ThemeMode themeMode) {
    log('get_localization: themeMode changed to -> ${themeMode.name}');
    _currentThemeMode.value = themeMode;
  }

  Future<void> loadLocale({Locale? locale}) async {
    log('get_localization: Locale changed to -> $locale');

    locale = locale ?? _currentLocale.value;

    String jsonString = await rootBundle.loadString(
        'assets/lang/${locale.languageCode}_${locale.countryCode}.json');

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _mapLocale = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    _currentLocale.value = locale;
  }

  String translate(String key) {
    return _mapLocale[key] ?? key;
  }
}
