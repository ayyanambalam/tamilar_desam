import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/glass_card.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.partyNameTa),
        actions: [
          IconButton(
            onPressed: () => context.go(Routes.notifications),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
        children: [
          _bannerSlider(),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _quickStat(
                  context,
                  title: 'உறுப்பினர்கள்',
                  value: '12,48,560',
                  icon: Icons.groups_2_rounded,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _quickStat(
                  context,
                  title: 'நிகழ்வுகள்',
                  value: '38',
                  icon: Icons.event_available_rounded,
                  color: scheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _sectionCard(
            context,
            title: 'தலைவர் செய்தி',
            subtitle:
                'மக்களுக்கான அரசியல் என்பது வாக்குறுதி அல்ல — அது செயலில் காட்டப்படும் மாற்றம்.',
            icon: Icons.record_voice_over_rounded,
            onTap: () => context.go(Routes.leaders),
          ),
          const SizedBox(height: 12),
          _sectionCard(
            context,
            title: 'சமீபத்திய செய்திகள்',
            subtitle: 'கட்சியின் முக்கிய செய்திகள் மற்றும் ஊடக வெளியீடுகள்.',
            icon: Icons.newspaper_rounded,
            onTap: () => context.go(Routes.news),
          ),
          const SizedBox(height: 12),
          _sectionCard(
            context,
            title: 'அறிவிப்புகள்',
            subtitle: 'ராலி, கூட்டம், மாவட்ட அறிவிப்புகள்.',
            icon: Icons.campaign_rounded,
            onTap: () => context.go(Routes.notifications),
          ),
          const SizedBox(height: 12),
          _sectionCard(
            context,
            title: 'உறுப்பினர் பதிவு',
            subtitle: 'OTP உறுதி செய்து உறுப்பினர் அட்டை (QR + PDF) பெறுங்கள்.',
            icon: Icons.how_to_reg_rounded,
            onTap: () => context.go(Routes.membership),
          ),
          const SizedBox(height: 12),
          _sectionCard(
            context,
            title: 'சர்வே',
            subtitle: 'வாக்காளர் முன்னுரிமை, உள்ளூர் பிரச்சினைகள், திருப்தி அளவீடு.',
            icon: Icons.assignment_rounded,
            onTap: () => context.go(Routes.survey),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Row(
              children: [
                Icon(Icons.volunteer_activism_rounded, color: scheme.secondary),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'நன்கொடை வழங்கி மாற்றத்தை ஆதரியுங்கள்',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                FilledButton(
                  onPressed: () => context.go(Routes.donate),
                  child: const Text('நன்கொடை'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _socialLinks(context),
        ],
      ),
    );
  }

  Widget _bannerSlider() {
    final items = [
      _BannerItem(
        title: 'மக்களுக்கான அரசியல்',
        subtitle: 'தமிழ்நாட்டின் ஒவ்வொரு வீட்டிலும் மாற்றத்தின் குரல்',
        icon: Icons.how_to_vote_rounded,
      ),
      _BannerItem(
        title: 'இளைஞர் சக்தி',
        subtitle: 'புதிய தலைமுறைக்கான புதிய தீர்வுகள்',
        icon: Icons.flash_on_rounded,
      ),
      _BannerItem(
        title: 'வளர்ச்சி • நீதி • நம்பிக்கை',
        subtitle: 'அரசியல் ஒரு சேவை',
        icon: Icons.auto_graph_rounded,
      ),
    ];

    return CarouselSlider(
      items: items.map((e) => _bannerCard(e)).toList(),
      options: CarouselOptions(
        height: 160,
        viewportFraction: 0.92,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
    );
  }

  Widget _bannerCard(_BannerItem item) {
    return Builder(
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scheme.primary.withOpacity(0.95),
                scheme.secondary.withOpacity(0.95),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.secondary.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white.withOpacity(0.85),
                  child: Icon(item.icon, size: 28, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _quickStat(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return GlassCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.18),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: GlassCard(
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: scheme.primary.withOpacity(0.18),
              child: Icon(icon, color: scheme.secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.72),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }

  Widget _socialLinks(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'சமூக ஊடகங்கள்',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _SocialChip(icon: Icons.facebook_rounded, label: 'Facebook'),
              _SocialChip(icon: Icons.ondemand_video_rounded, label: 'YouTube'),
              _SocialChip(icon: Icons.camera_alt_rounded, label: 'Instagram'),
              _SocialChip(icon: Icons.alternate_email_rounded, label: 'X / Twitter'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'குறிப்பு: URL-களை Firebase Console மூலம் புதுப்பிக்கலாம் (settings collection).',
            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

class _BannerItem {
  _BannerItem({required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final IconData icon;
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: scheme.primary.withOpacity(0.12),
        border: Border.all(color: Colors.white.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

