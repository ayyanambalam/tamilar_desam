import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'theme.dart';

class TamilarDesamApp extends ConsumerWidget {
  const TamilarDesamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'தமிழர் தேசம்',
      theme: AppTheme.light(),
      routerConfig: router,
      supportedLocales: const [
        Locale('ta', 'IN'),
        Locale('en'),
      ],
      locale: const Locale('ta', 'IN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

