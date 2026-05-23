import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';

class SurveyAnalyticsScreen extends StatelessWidget {
  const SurveyAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MVP mock aggregation. Replace with Firestore aggregation / Cloud Function later.
    final pref = <String, double>{
      'தமிழர் தேசம்': 48,
      'திமுக': 22,
      'அதிமுக': 18,
      'முடிவு இல்லை': 12,
    };
    final caste = <String, double>{
      'BC': 36,
      'MBC': 24,
      'SC': 18,
      'OC': 12,
      'Others': 10,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('சர்வே பகுப்பாய்வு')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const GlassCard(
            child: Text(
              'Admin analytics (MVP): இது demo charts.\n\nProduction-க்கு: Firestore data -> Cloud Function aggregation -> district-wise reports -> export.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12),
          _pieCard(context, title: 'வாக்கு முன்னுரிமை', data: pref),
          const SizedBox(height: 12),
          _pieCard(context, title: 'சாதி விகிதம்', data: caste),
          const SizedBox(height: 12),
          const GlassCard(
            child: Text(
              'Export:\n- CSV: csv package\n- Excel: excel package\n\nSuggestion: district-wise filters, date range, and “Export” button.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pieCard(
    BuildContext context, {
    required String title,
    required Map<String, double> data,
  }) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      const Color(0xFF4CAF50),
      const Color(0xFF2196F3),
      const Color(0xFFFF9800),
      const Color(0xFF9C27B0),
    ];

    final total = data.values.fold<double>(0, (a, b) => a + b);
    int idx = 0;
    final sections = data.entries.map((e) {
      final color = colors[idx++ % colors.length];
      return PieChartSectionData(
        color: color,
        value: e.value,
        title: '${(e.value / total * 100).toStringAsFixed(0)}%',
        radius: 70,
        titleStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 12,
        ),
      );
    }).toList();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: Row(
              children: [
                Expanded(child: PieChart(PieChartData(sections: sections))),
                const SizedBox(width: 10),
                SizedBox(
                  width: 140,
                  child: ListView(
                    children: data.entries.toList().asMap().entries.map((entry) {
                      final i = entry.key;
                      final e = entry.value;
                      final color = colors[i % colors.length];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                e.key,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

