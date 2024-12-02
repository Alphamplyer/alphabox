
import 'package:alphabox/animes/domain/entities/animation_studio.dart';
import 'package:alphabox/animes/domain/entities/anime_diffusion.dart';
import 'package:alphabox/animes/domain/entities/anime_genre.dart';
import 'package:alphabox/animes/domain/entities/anime_rating.dart';
import 'package:alphabox/animes/domain/enums/adaptation_type.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/enums/anime_type.dart';

class Anime {
  final String title;
  final String alternativeTitle;
  final String imageUrl;
  final String description;
  final int numberOfEpisodes;
  final AnimeDiffusion animeDiffusion;
  final AnimeType type;
  final AdaptationType adaptedFrom;
  final AnimeGenre genres;
  final AnimationStudio studio;
  final AnimeRating rating;

  Anime({
    required this.title,
    required this.alternativeTitle,
    required this.imageUrl,
    required this.description,
    required this.numberOfEpisodes,
    required this.animeDiffusion,
    required this.type,
    required this.adaptedFrom,
    required this.genres,
    required this.studio,
    required this.rating,
  });

  /// Returns true if the anime is in the current season, false otherwise.
  /// A anime without a start date is considered to be in the current season.
  bool isInThisSeason(AnimeSeason currentSeason, int currentYear) {
    if (animeDiffusion.start == null) {
      return true;
    }
    if (animeDiffusion.start!.year != currentYear) {
      return false;
    }
    if (numberOfEpisodes == -1) {
      return true;
    }

    if (currentSeason.isInThisSeason(animeDiffusion.start!)) {
      return true;
    } else {
      const int thresholdDayToBeConsideredInSeason = 15;
      return currentSeason.isInThisSeason(animeDiffusion.start!.add(const Duration(days: thresholdDayToBeConsideredInSeason)));
    }
  }

  @override
  @override
  String toString() {
    return 'Anime(title: $title, alternativeTitle: $alternativeTitle, imageUrl: $imageUrl, description: $description, numberOfEpisodes: $numberOfEpisodes, animeDiffusion: ${animeDiffusion.toString()}, type: $type, adaptedFrom: ${adaptedFrom.toString()}, genres: [${genres.toString()}], studio: ${studio.toString()}, rating: ${rating.toString()})';
  }
}