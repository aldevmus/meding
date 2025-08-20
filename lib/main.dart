import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_theme.dart';

import 'package:meding_app/services/deep_link_service.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

import 'firebase_options.dart';

import 'package:meding_app/app/routes/app_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MedingApp());
}

class MedingApp extends StatefulWidget {
  const MedingApp({super.key});

  @override
  State<MedingApp> createState() => _MedingAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MedingAppState? state = context.findAncestorStateOfType<_MedingAppState>();

    state?.setLocale(newLocale);
  }
}

// --- *** تمت إضافة WidgetsBindingObserver هنا *** ---

class _MedingAppState extends State<MedingApp> with WidgetsBindingObserver {
  Locale? _locale;

  final DeepLinkService _deepLinkService =
      DeepLinkService(navigatorKey: navigatorKey);

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // --- *** إضافة قسم Observer لحل مشكلة اللخبطة *** ---

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _deepLinkService.initDeepLinks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _deepLinkService.dispose();
    super.dispose();
  }

  // هذه الدالة يتم استدعاؤها عندما تتغير حالة التطبيق (يعود للواجهة مثلاً)

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // عند العودة للتطبيق، قم بإعادة بناء الواجهة لإصلاح أي لخبطة رسومية

      setState(() {});
    }
  }

  // ---------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final languageCode = _locale?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return MaterialApp(
      // --- *** إضافة المفتاح هنا لحل مشكلة تغير الخط *** ---
      navigatorKey: navigatorKey,

      key: ValueKey(_locale),

      title: 'Meding App',

      theme: AppTheme.getTheme(languageCode, Brightness.light),

      darkTheme: AppTheme.getTheme(languageCode, Brightness.dark),

      themeMode: ThemeMode.system,

      localizationsDelegates: AppLocalizations.localizationsDelegates,

      supportedLocales: AppLocalizations.supportedLocales,

      locale: _locale,

      debugShowCheckedModeBanner: false,
      
      initialRoute: AppRouter.splash,

      routes: AppRouter.getRoutes(),

    );
  }
}
