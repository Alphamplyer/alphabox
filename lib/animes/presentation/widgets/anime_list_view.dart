
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/presentation/widgets/anime_list_item.dart';
import 'package:flutter/material.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({
    super.key, 
    this.sectionKey,
    required this.title,
    required this.animes, 
  });

  final Key? sectionKey;
  final String title;
  final List<Anime> animes;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(animes.length, (int index) {
      final anime = animes[index];
      return AnimeListItem(
        key: ValueKey(anime.title.hashCode),
        anime: anime
      );
    });

    return Column(
      key: sectionKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0, top: 32.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ]
    );
  }
}