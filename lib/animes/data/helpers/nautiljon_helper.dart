
import 'package:alphabox/animes/domain/entities/anime_diffusion.dart';
import 'package:alphabox/animes/domain/enums/adaptation_type.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/enums/anime_type.dart';

class NautiljonHelper {
  static const String kNautiljonBaseUrl = 'https://www.nautiljon.com';
  static const String kNautiljonAnimeUrl = 'https://www.nautiljon.com/animes';
  static const String kNautiljonAnimeUrlFilters = 'format=0&y=0&tri=&public_averti=1&simulcast=';

  static String getNautiljonSeasonAnimeUrl(AnimeSeason season, int year) {
    String seasonName = getNautiljonSeasonUrlName(season);
    return '$kNautiljonAnimeUrl/$seasonName-$year.html?$kNautiljonAnimeUrlFilters';
  }

  static String getNautiljonSeasonUrlName(AnimeSeason season) {
    return switch (season) {
      AnimeSeason.winter => 'hiver',
      AnimeSeason.spring => 'printemps',
      AnimeSeason.summer => 'ete',
      AnimeSeason.fall => 'automne',
    };
  }

  static AnimeType getAnimeTypeFromNautiljonType(String type) {
    return switch (type) {
      'Série' => AnimeType.serie,
      'Film' => AnimeType.movie,
      'OAV' => AnimeType.ova,
      'ONA' => AnimeType.ona,
      'Spécial' => AnimeType.special,
      _ => AnimeType.other
    };
  }

  static AdaptationType getAdaptationTypeFromNautiljonType(String type) {
    return switch (type) {
      'Manga' => AdaptationType.manga,
      'Light Novel' => AdaptationType.lightNovel,
      'Jeu vidéo' => AdaptationType.videoGame,
      'Projet transmédia' => AdaptationType.transMediaProject,
      'Roman' => AdaptationType.novel,
      'Livre' => AdaptationType.book,
      'Œuvre originale' => AdaptationType.originalWork,
      'Visual Novel' => AdaptationType.visualNovel,
      _ => AdaptationType.other,
    };
  }

  static AnimeDiffusionBuilder parseNautiljonDiffussionDatesToAnimeDiffusionBuilder(String text, AnimeDiffusionBuilder animeDiffusionBuilder) {
    List<String> parts = text.split(' → ');
    
    if (parts.isEmpty) {
      return animeDiffusionBuilder;
    }

    DateTime? startDate = getDateTimeFromNautiljonText(parts[0]);
    animeDiffusionBuilder.withStart(startDate);
    
    if (parts.length == 1) {
      return animeDiffusionBuilder;
    }

    DateTime? endDate = getDateTimeFromNautiljonText(parts[1]);
    animeDiffusionBuilder.withEnd(endDate);
    return animeDiffusionBuilder;
  }

  static DateTime? getDateTimeFromNautiljonText(String dateStr) {
    if (dateStr.isEmpty) return null;
    if (dateStr == '?') return null;
    List<String> dateParts = dateStr.split('/');

    if (dateParts.length == 3) {
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      return DateTime(year, month, day);
    } else if (dateParts.length == 2) {
      int month = int.parse(dateParts[0]);
      int year = int.parse(dateParts[1]);
      return DateTime(year, month);
    } else if (dateParts.length == 1) {
      int year = int.parse(dateParts[0]);
      return DateTime(year);
    }
    return null;
  }
}