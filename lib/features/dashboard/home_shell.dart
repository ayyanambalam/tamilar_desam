import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_router.dart';
import '../../core/constants/app_strings.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.child});
  final Widget child;

  int _locationToIndex(String location) {
    if (location.startsWith(Routes.news)) return 1;
    if (location.startsWith(Routes.events)) return 2;
    if (location.startsWith(Routes.donate)) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        return;
      case 1:
        context.go(Routes.news);
        return;
      case 2:
        context.go(Routes.events);
        return;
      case 3:
        context.go(Routes.donate);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => _onTap(context, i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: AppStrings.homeTa,
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper_rounded),
            label: AppStrings.newsTa,
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: AppStrings.eventsTa,
          ),
          NavigationDestination(
            icon: Icon(Icons.volunteer_activism_outlined),
            selectedIcon: Icon(Icons.volunteer_activism),
            label: AppStrings.donateTa,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openMore(context),
        icon: const Icon(Icons.menu_rounded),
        label: const Text(AppStrings.moreTa),
      ),
    );
  }

  void _openMore(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (ctx) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 24),
          children: [
            const ListTile(
              title: Text(
                'விரைவு இணைப்புகள்',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            _tile(ctx, Icons.groups_2_rounded, 'கட்சி தலைவர்கள்', Routes.leaders),
            _tile(ctx, Icons.how_to_reg_rounded, 'உறுப்பினர் பதிவு', Routes.membership),
            _tile(ctx, Icons.assignment_rounded, 'சர்வே', Routes.survey),
            _tile(ctx, Icons.analytics_rounded, 'சர்வே பகுப்பாய்வு', Routes.surveyAnalytics),
            _tile(ctx, Icons.hub_rounded, 'பூத் மேலாண்மை', Routes.booth),
            _tile(ctx, Icons.badge_rounded, 'தன்னார்வலர்கள்', Routes.volunteers),
            _tile(ctx, Icons.notifications_rounded, 'அறிவிப்புகள்', Routes.notifications),
            const Divider(),
            _tile(ctx, Icons.admin_panel_settings_rounded, 'அட்மின்', Routes.admin),
          ],
        );
      },
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
  }
}

