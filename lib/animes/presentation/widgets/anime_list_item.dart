
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/presentation/widgets/anime_genres_view.dart';
import 'package:alphabox/shared/extensions/app_theme_extension.dart';
import 'package:alphabox/shared/extensions/build_context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimeListItem extends StatelessWidget {
  const AnimeListItem({super.key, required this.anime});

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.appColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
        color: context.theme.appColors.primaryBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: context.theme.appColors.secondaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  anime.alternativeTitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: context.theme.appColors.tertiaryBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${context.appLocalizations.animeTypeLabel} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(context.appLocalizations.animeType(anime.type.name)),
                          const SizedBox(width: 8),
                          Text(
                            "${context.appLocalizations.episodeCountLabel} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            anime.numberOfEpisodes == -1 
                              ? context.appLocalizations.unknown
                              : context.appLocalizations.episodeCount(anime.numberOfEpisodes),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            "${context.appLocalizations.adaptedFrom} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(context.appLocalizations.adaptationType(anime.adaptedFrom.name)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AnimeGenresView(genres: anime.genres),
              ],
            )
          ),
          SizedBox(
            height: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 165, 
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: context.theme.appColors.primaryColor)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: anime.imageUrl, 
                    width: 165, 
                    height: 250,
                    fit: BoxFit.cover,
                  )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            anime.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: context.theme.appColors.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${context.appLocalizations.releaseDate} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      anime.animeDiffusion.start == null 
                        ? '?'
                        : DateFormat.yMd().format(anime.animeDiffusion.start!),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${context.appLocalizations.finalDate} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      anime.animeDiffusion.end == null 
                        ? '?' 
                        : DateFormat.yMd().format(anime.animeDiffusion.end!),
                    ),
                  ]
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      "${context.appLocalizations.score} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(anime.rating.average == -1 ? 'N/A' : anime.rating.average.toString()),
                  ],
                )
              ],
            )
          ),
        ],
      )
    );
  }
}