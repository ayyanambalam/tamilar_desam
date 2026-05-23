import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';

class BoothManagementScreen extends StatelessWidget {
  const BoothManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booths = const [
      _Booth(boothNo: 'B-102', area: 'அண்ணாநகர்', voters: 1240, performance: 78),
      _Booth(boothNo: 'B-141', area: 'கே.கே.நகர்', voters: 980, performance: 64),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('பூத் மேலாண்மை')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: booths.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final b = booths[i];
          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${b.boothNo} • ${b.area}',
                    style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _pill(Icons.people_alt_rounded, 'வாக்காளர்கள்: ${b.voters}'),
                    const SizedBox(width: 10),
                    _pill(Icons.speed_rounded, 'Performance: ${b.performance}%'),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'MVP: Booth agent list, volunteer tracking, daily visit logs போன்றவை Firestore-ல் சேர்க்கலாம்.',
                  style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _Booth {
  const _Booth({
    required this.boothNo,
    required this.area,
    required this.voters,
    required this.performance,
  });

  final String boothNo;
  final String area;
  final int voters;
  final int performance;
}

