import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/locale_controller.dart';
import '../services/translation_service.dart';

class LocalizedText extends ConsumerWidget {
  const LocalizedText(
    this.englishText, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String englishText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);

    if (locale.languageCode == 'en') {
      return Text(
        englishText,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    return FutureBuilder<String>(
      future: ref
          .read(translationServiceProvider)
          .translate(text: englishText, locale: locale),
      builder: (context, snapshot) {
        final text = snapshot.data ?? englishText;
        return Text(
          text,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}
