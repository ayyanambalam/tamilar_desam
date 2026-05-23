import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/widgets/glass_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('செய்திகள் & ஊடகம்'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabs: const [
            Tab(text: 'செய்திகள்'),
            Tab(text: 'அறிக்கைகள்'),
            Tab(text: 'YouTube'),
            Tab(text: 'கேலரி'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _NewsFeedTab(),
          _PressReleaseTab(),
          _VideosTab(),
          _GalleryTab(),
        ],
      ),
    );
  }
}

class _NewsFeedTab extends StatelessWidget {
  const _NewsFeedTab();

  @override
  Widget build(BuildContext context) {
    final items = [
      _NewsItem(
        title: 'மாவட்ட அளவில் மக்கள் சந்திப்பு தொடக்கம்',
        body: 'தமிழர் தேசம் கட்சி மாவட்ட வாரியாக மக்கள் சந்திப்பு நிகழ்ச்சிகளைத் தொடங்குகிறது.',
        date: '23 மே 2026',
      ),
      _NewsItem(
        title: 'விவசாயிகளுக்கு ஆதரவு – புதிய திட்ட அறிக்கை',
        body: 'குறைந்த வட்டி கடன், உற்பத்தி ஊக்கத்தொகை உள்ளிட்ட திட்டங்கள் அறிவிப்பு.',
        date: '20 மே 2026',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final item = items[i];
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              Text(
                item.body,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    item.date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Share.share('${item.title}\n\n${item.body}'),
                    icon: const Icon(Icons.share_rounded),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PressReleaseTab extends StatelessWidget {
  const _PressReleaseTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
      children: const [
        GlassCard(
          child: Text(
            'இது “Press Releases” டாப்.\n\nFirebase Firestore collection: news வகையில் type=press_release எனச் சேமிக்கலாம்.',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _VideosTab extends StatelessWidget {
  const _VideosTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
      children: const [
        GlassCard(
          child: Text(
            'YouTube இணைப்புகளை Firestore-ல் சேமித்து,\nurl_launcher மூலம் திறக்கலாம் அல்லது YouTube Player package சேர்க்கலாம்.',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _GalleryTab extends StatelessWidget {
  const _GalleryTab();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: 6,
      itemBuilder: (context, i) {
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.06),
                    child: const Icon(Icons.image_rounded, size: 42),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'படம் ${i + 1}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NewsItem {
  _NewsItem({
    required this.title,
    required this.body,
    required this.date,
  });

  final String title;
  final String body;
  final String date;
}

