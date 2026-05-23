import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

class VolunteersScreen extends StatelessWidget {
  const VolunteersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final volunteers = const [
      _Volunteer(name: 'சண்முகம்', district: 'சென்னை', status: 'Active'),
      _Volunteer(name: 'பிரியா', district: 'திருச்சி', status: 'Active'),
      _Volunteer(name: 'கார்த்திக்', district: 'மதுரை', status: 'On Leave'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('தன்னார்வலர்கள்')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('வருகை பதிவு', style: TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                PrimaryButton(
                  label: 'இன்று வருகை பதிவு',
                  icon: Icons.fact_check_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Attendance saved (MVP stub)')),
                    );
                    // TODO: Save attendance logs to Firestore.
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...volunteers.map(
            (v) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.black.withOpacity(0.06),
                      child: const Icon(Icons.person_rounded),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.name,
                              style: const TextStyle(fontWeight: FontWeight.w900)),
                          const SizedBox(height: 2),
                          Text(
                            v.district,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: v.status == 'Active'
                            ? const Color(0xFF4CAF50).withOpacity(0.15)
                            : const Color(0xFFFF9800).withOpacity(0.15),
                      ),
                      child: Text(
                        v.status,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Volunteer {
  const _Volunteer({required this.name, required this.district, required this.status});
  final String name;
  final String district;
  final String status;
}

