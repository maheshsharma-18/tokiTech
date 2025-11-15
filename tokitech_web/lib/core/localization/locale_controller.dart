import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeControllerProvider = StateNotifierProvider<LocaleController, Locale>(
  (ref) => LocaleController()..loadPersistedLocale(),
);

class LocaleController extends StateNotifier<Locale> {
  LocaleController() : super(const Locale('en'));

  static const _cacheKey = 'preferred_locale';

  Future<void> loadPersistedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_cacheKey);
    if (code != null && code.isNotEmpty) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, locale.languageCode);
  }

  bool isCurrent(Locale locale) => state.languageCode == locale.languageCode;
}
