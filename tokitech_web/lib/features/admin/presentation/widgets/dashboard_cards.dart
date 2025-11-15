import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/localized_text.dart';

class DashboardCards extends ConsumerWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = [
      _DashboardTileData('Total Students', '1,280', Colors.blue.shade50, Colors.blue.shade600),
      _DashboardTileData('Attendance Today', '92%', Colors.green.shade50, Colors.green.shade600),
      _DashboardTileData('Pending Tickets', '14', Colors.orange.shade50, Colors.orange.shade600),
      _DashboardTileData('Active Buses', '18', Colors.purple.shade50, Colors.purple.shade600),
    ];

    return ListView(
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: cards
              .map((tile) => _DashboardTile(
                    title: tile.title,
                    value: tile.value,
                    background: tile.background,
                    valueColor: tile.valueColor,
                  ))
              .toList(),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LocalizedText(
                'Attendance Trend',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Placeholder(fallbackHeight: 260),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashboardTileData {
  _DashboardTileData(this.title, this.value, this.background, this.valueColor);

  final String title;
  final String value;
  final Color background;
  final Color valueColor;
}

class _DashboardTile extends StatelessWidget {
  const _DashboardTile({
    required this.title,
    required this.value,
    required this.background,
    required this.valueColor,
  });

  final String title;
  final String value;
  final Color background;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocalizedText(
              title,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
