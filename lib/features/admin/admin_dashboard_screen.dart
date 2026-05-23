import 'package:flutter/material.dart';

import '../../core/widgets/glass_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('அட்மின் டாஷ்போர்டு')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const GlassCard(
            child: Text(
              'நீங்கள் “Firebase Console only” என்பதை தேர்ந்தெடுத்ததால்,\nAdmin actions பெரும்பாலும் Firebase Console/Firestore rules மூலம் செய்யலாம்.\n\nMVP: இந்த screen-ல் quick links + in-app admin tools சேர்க்கலாம்.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12),
          _tile(
            context,
            icon: Icons.verified_user_rounded,
            title: 'Membership Approval',
            subtitle: 'memberships collection → status=approved',
          ),
          _tile(
            context,
            icon: Icons.post_add_rounded,
            title: 'News Posting',
            subtitle: 'news collection → create/update posts',
          ),
          _tile(
            context,
            icon: Icons.event_note_rounded,
            title: 'Event Management',
            subtitle: 'events collection → schedules + registrations',
          ),
          _tile(
            context,
            icon: Icons.groups_rounded,
            title: 'Volunteer Management',
            subtitle: 'volunteers collection → attendance + roles',
          ),
          _tile(
            context,
            icon: Icons.pie_chart_rounded,
            title: 'District Reports',
            subtitle: 'survey aggregation → export excel/pdf',
          ),
          const SizedBox(height: 12),
          const GlassCard(
            child: Text(
              'Security suggestion:\n- users/{uid}.role = admin\n- Firestore security rules: allow admin-only writes\n- Sensitive data encryption (client) + avoid storing Aadhaar unless needed.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
          subtitle: Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title (MVP stub)')),
          ),
        ),
      ),
    );
  }
}

