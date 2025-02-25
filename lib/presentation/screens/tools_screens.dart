import 'package:alphabox/animes/presentation/screens/season_anime_list_screen.dart';
import 'package:alphabox/reading_notations/presentation/screens/create_reading_notation_screen.dart';
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

              const SizedBox(height: 16),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Reading",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text(
                    "Tools for my reading",
                    style: TextStyle(
                      fontSize: 16,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text(
                  "Reading Notation",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Create a reading notation"),
                tileColor: context.theme.appColors.secondaryBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateReadingNotationScreen()),
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