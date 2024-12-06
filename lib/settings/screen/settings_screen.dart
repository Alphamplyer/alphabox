
import 'package:alphabox/shared/configs/app_locale.dart';
import 'package:alphabox/shared/configs/app_theme.dart';
import 'package:alphabox/shared/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.watch<AppTheme>();
    final AppLocale appLocale = context.watch<AppLocale>();
    print(AppLocalizations.supportedLocales.join(', '));

    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalizations.settingsScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              context.appLocalizations.settingsScreenLanguageCategoryTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              context.appLocalizations.settingsScreenLanguageCategoryDescription,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            ListTile(
              title: Text(context.appLocalizations.languageLabel),
              trailing: DropdownButton<String>(
                value: appLocale.currentLocale.languageCode,
                onChanged: (String? languageCode) {
                  if (languageCode == null) {
                    return;
                  }
                  appLocale.setLocale(Locale(languageCode));
                },
                items: AppLocalizations.supportedLocales.map((Locale locale) => DropdownMenuItem<String>(
                    value: locale.languageCode,
                    child: Text(context.appLocalizations.language(locale.languageCode)),
                  ))
                  .toList(),
              ),
            ),
            Text(
              context.appLocalizations.settingsScreenThemeCategoryTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              context.appLocalizations.settingsScreenThemeCategoryDescription,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            ListTile(
              title: Text(context.appLocalizations.themeLabel),
              trailing: DropdownButton<ThemeMode>(
                value: appTheme.themeMode,
                onChanged: (ThemeMode? themeMode) {
                  if (themeMode == null) {
                    return;
                  }
                  appTheme.setThemeMode(themeMode);
                },
                items: ThemeMode.values
                    .map((ThemeMode themeMode) => DropdownMenuItem<ThemeMode>(
                          value: themeMode,
                          child: Text(context.appLocalizations.theme(themeMode.name)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}