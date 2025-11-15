import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final translationServiceProvider = Provider<TranslationService>((ref) {
  return TranslationService();
});

class TranslationService {
  TranslationService({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  final http.Client _client;
  final Map<String, Map<String, String>> _cache = {};

  static const _baseUrl = String.fromEnvironment('TRANSLATION_BASE_URL', defaultValue: '');
  static const _apiKey = String.fromEnvironment('TRANSLATION_API_KEY', defaultValue: '');

  Future<String> translate({required String text, required Locale locale}) async {
    if (locale.languageCode == 'en' || text.trim().isEmpty) {
      return text;
    }

    final cached = _cache[locale.languageCode]?[text];
    if (cached != null) {
      return cached;
    }

    if (_baseUrl.isEmpty) {
      // Translation service is not configured yet; fall back to source copy.
      return text;
    }

    try {
      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          if (_apiKey.isNotEmpty) 'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'text': text,
          'targetLang': locale.languageCode,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final translated = (decoded['translatedText'] ?? text) as String;
        _cache.putIfAbsent(locale.languageCode, () => {})[text] = translated;
        return translated;
      }
    } catch (error) {
      debugPrint('Translation error: $error');
    }

    return text;
  }
}
