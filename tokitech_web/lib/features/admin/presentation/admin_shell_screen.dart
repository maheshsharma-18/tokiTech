import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/locale_controller.dart';
import 'widgets/admin_sidebar.dart';
import 'widgets/dashboard_cards.dart';
import 'widgets/top_bar.dart';

class AdminShellScreen extends ConsumerWidget {
  const AdminShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeController = ref.watch(localeControllerProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                AdminTopBar(
                  onLanguageTap: (locale) => localeController.setLocale(locale),
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: DashboardCards(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F7FA),
    );
  }
}
