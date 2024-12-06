import 'package:alphabox/presentation/screens/tools_screens.dart';
import 'package:alphabox/shared/configs/app_locale.dart';
import 'package:alphabox/shared/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AlphaBoxApp extends StatelessWidget {
  const AlphaBoxApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => AppLocale()),
      ],
      builder: (context, _) => MaterialApp(
        title: 'AlphaBox',
        locale: context.watch<AppLocale>().currentLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: context.watch<AppTheme>().themeMode,
        debugShowCheckedModeBanner: false,
        home: const ToolsPage(),
      ),
    );
  }
}
