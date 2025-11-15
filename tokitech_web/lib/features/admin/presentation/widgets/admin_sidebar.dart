import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/localized_text.dart';
import '../../application/menu_state.dart';

class AdminSidebar extends ConsumerWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(adminMenuProvider);

    return Container(
      width: 288,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFF013A63),
                child: Text('TT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 12),
              LocalizedText(
                'Toki Tech',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                for (final module in AdminModule.values)
                  _SidebarTile(
                    label: module.label,
                    icon: module.icon,
                    selected: module == selected,
                    onTap: () => ref.read(adminMenuProvider.notifier).select(module),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: selected ? const Color(0xFFE5F4FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Icon(icon, color: selected ? const Color(0xFF006778) : Colors.black54),
          title: LocalizedText(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? const Color(0xFF006778) : Colors.black87,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
