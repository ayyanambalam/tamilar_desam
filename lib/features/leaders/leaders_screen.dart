import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';

class LeadersScreen extends StatelessWidget {
  const LeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaders = const [
      _Leader(
        name: 'திரு. மு. அருண்',
        position: 'கட்சித் தலைவர்',
        district: 'சென்னை',
        phone: '+91 90000 00001',
        email: 'leader@tamilarDesam.org',
      ),
      _Leader(
        name: 'திருமதி. க. மீனா',
        position: 'பொது செயலாளர்',
        district: 'கோயம்புத்தூர்',
        phone: '+91 90000 00002',
        email: 'meena@tamilarDesam.org',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('கட்சி தலைவர்கள்')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: leaders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final l = leaders[i];
          return GlassCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.black.withOpacity(0.06),
                  child: const Icon(Icons.person_rounded, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(
                        '${l.position} • ${l.district}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.call_rounded, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l.phone,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.email_rounded, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l.email,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Leader {
  const _Leader({
    required this.name,
    required this.position,
    required this.district,
    required this.phone,
    required this.email,
  });

  final String name;
  final String position;
  final String district;
  final String phone;
  final String email;
}

