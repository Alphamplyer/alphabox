import 'package:alphabox/animes/presentation/screens/season_anime_list_screen.dart';
import 'package:alphabox/settings/screen/settings_screen.dart';
import 'package:alphabox/shared/extensions/app_theme_extension.dart';
import 'package:alphabox/shared/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalizations.toolsScreenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.appLocalizations.toolsScreenAnimeCategoryTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text(
                    context.appLocalizations.toolsScreenAnimeCategoryDescription,
                    style: const TextStyle(
                      fontSize: 16,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                title: Text(
                  context.appLocalizations.animeOfTheSeasonToolTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(context.appLocalizations.animeOfTheSeasonToolDescription),
                tileColor: context.theme.appColors.secondaryBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SeasonAnimeListScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }  
}