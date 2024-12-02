
import 'package:alphabox/animes/domain/entities/anime_genre.dart';
import 'package:alphabox/shared/extensions/app_theme_extension.dart';
import 'package:alphabox/shared/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AnimeGenresView extends StatelessWidget {
  const AnimeGenresView({super.key, required this.genres});

  final AnimeGenre genres;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Text(
              context.appLocalizations.genresLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(genres.values.length, (index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: context.theme.appColors.primaryBackgroundColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          genres.values.elementAt(index).toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ],
    );
  }
}