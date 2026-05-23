import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/admin/admin_dashboard_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/booth/booth_management_screen.dart';
import '../features/dashboard/home_shell.dart';
import '../features/dashboard/home_tab_screen.dart';
import '../features/donations/donation_screen.dart';
import '../features/events/events_screen.dart';
import '../features/leaders/leaders_screen.dart';
import '../features/membership/membership_screen.dart';
import '../features/news/news_screen.dart';
import '../features/notifications/notification_center_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/survey/survey_analytics_screen.dart';
import '../features/survey/survey_form_screen.dart';
import '../features/volunteers/volunteers_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';

  static const home = '/home';
  static const news = '/news';
  static const events = '/events';
  static const donate = '/donate';

  static const leaders = '/leaders';
  static const membership = '/membership';
  static const survey = '/survey';
  static const surveyAnalytics = '/survey-analytics';
  static const booth = '/booth';
  static const volunteers = '/volunteers';
  static const notifications = '/notifications';
  static const admin = '/admin';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      /// Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeTabScreen()),
          ),
          GoRoute(
            path: Routes.news,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: NewsScreen()),
          ),
          GoRoute(
            path: Routes.events,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: EventsScreen()),
          ),
          GoRoute(
            path: Routes.donate,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DonationScreen()),
          ),
        ],
      ),

      // Secondary screens
      GoRoute(
        path: Routes.leaders,
        builder: (context, state) => const LeadersScreen(),
      ),
      GoRoute(
        path: Routes.membership,
        builder: (context, state) => const MembershipScreen(),
      ),
      GoRoute(
        path: Routes.survey,
        builder: (context, state) => const SurveyFormScreen(),
      ),
      GoRoute(
        path: Routes.surveyAnalytics,
        builder: (context, state) => const SurveyAnalyticsScreen(),
      ),
      GoRoute(
        path: Routes.booth,
        builder: (context, state) => const BoothManagementScreen(),
      ),
      GoRoute(
        path: Routes.volunteers,
        builder: (context, state) => const VolunteersScreen(),
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const NotificationCenterScreen(),
      ),
      GoRoute(
        path: Routes.admin,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => _RouterErrorScreen(error: state.error),
  );
});

class _RouterErrorScreen extends StatelessWidget {
  const _RouterErrorScreen({this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('பிழை')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Route error: ${error ?? 'Unknown'}',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

