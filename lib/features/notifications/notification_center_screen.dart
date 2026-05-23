import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _Noti(
        title: 'Breaking: முக்கிய அறிவிப்பு',
        body: 'இன்றைய கூட்டம் மாலை 6:00க்கு மாற்றப்பட்டது.',
        time: '1 மணி நேரம் முன்',
      ),
      _Noti(
        title: 'பிரச்சார செய்தி',
        body: 'உங்கள் வார்டில் மக்கள் சந்திப்பு நாளை நடைபெறும்.',
        time: 'நேற்று',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('அறிவிப்புகள்')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final n = items[i];
          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n.title, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(
                  n.body,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  n.time,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.6),
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

class _Noti {
  const _Noti({required this.title, required this.body, required this.time});
  final String title;
  final String body;
  final String time;
}

