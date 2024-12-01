
import 'package:alphabox/animes/domain/entities/animation_studio.dart';
import 'package:alphabox/animes/domain/entities/anime_diffusion.dart';
import 'package:alphabox/animes/domain/entities/anime_genre.dart';
import 'package:alphabox/animes/domain/entities/anime_rating.dart';
import 'package:alphabox/animes/domain/enums/adaptation_type.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/enums/anime_type.dart';

class Anime {
  final String title;
  final String imageUrl;
  final String description;
  final int numberOfEpisodes;
  final AnimeDiffusion animeDiffusion;
  final AnimeSeason season;
  final int year;
  final AnimeType type;
  final AdaptationType adaptedFrom;
  final AnimeGenre genres;
  final AnimationStudio studio;
  final AnimeRating rating;

  Anime({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.numberOfEpisodes,
    required this.animeDiffusion,
    required this.season,
    required this.year,
    required this.type,
    required this.adaptedFrom,
    required this.genres,
    required this.studio,
    required this.rating,
  });

  @override
  @override
  String toString() {
    return 'Anime(title: $title, imageUrl: $imageUrl, description: $description, numberOfEpisodes: $numberOfEpisodes, animeDiffusion: ${animeDiffusion.toString()}, season: $season, year: $year, type: $type, adaptedFrom: ${adaptedFrom.toString()}, genres: [${genres.toString()}], studio: ${studio.toString()}, rating: ${rating.toString()})';
  }
}