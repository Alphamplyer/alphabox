import 'package:alphabox/animes/presentation/screens/season_anime_list_screen.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Animes'),
              subtitle: const Text('List animes of the season'),
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
    );
  }  
}