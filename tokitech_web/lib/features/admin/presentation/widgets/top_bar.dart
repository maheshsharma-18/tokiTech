import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/locale_controller.dart';
import '../../../../core/widgets/localized_text.dart';

class AdminTopBar extends ConsumerWidget {
  const AdminTopBar({super.key, required this.onLanguageTap});

  final void Function(Locale locale) onLanguageTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LocalizedText(
                'Good Morning, Principal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              LocalizedText('Here is what is happening across your school today.'),
            ],
          ),
          const Spacer(),
          SegmentedButton<Locale>(
            segments: const [
              ButtonSegment(value: Locale('en'), label: Text('EN')),
              ButtonSegment(value: Locale('te'), label: Text('TE')),
            ],
            selected: {locale},
            onSelectionChanged: (value) => onLanguageTap(value.first),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: Color(0xFF013A63),
            child: Text('P', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
