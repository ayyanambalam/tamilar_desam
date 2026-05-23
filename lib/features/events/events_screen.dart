import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';
import '../../core/widgets/primary_button.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      _Event(
        title: 'மாவட்ட ராலி',
        date: '26 மே 2026 • மாலை 5:00',
        place: 'மதுரை',
      ),
      _Event(
        title: 'தன்னார்வலர் கூட்டம்',
        date: '29 மே 2026 • காலை 10:00',
        place: 'திருச்சி',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('நிகழ்வுகள்')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final e = events[i];
          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.title, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 18, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.date,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.place_rounded, size: 18, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.place,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'பதிவு செய்யவும்',
                  icon: Icons.edit_calendar_rounded,
                  onPressed: () => _openRegistration(context, e),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openRegistration(BuildContext context, _Event event) {
    final name = TextEditingController();
    final phone = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            top: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'நிகழ்வு பதிவு',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'பெயர்'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'மொபைல் எண்'),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: 'சமர்ப்பிக்கவும்',
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('பதிவு முடிந்தது: ${event.title}')),
                  );
                  // TODO: Save into Firestore: events/{eventId}/registrations
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Event {
  _Event({required this.title, required this.date, required this.place});
  final String title;
  final String date;
  final String place;
}

