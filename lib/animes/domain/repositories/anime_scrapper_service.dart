
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';

abstract class AnimeScrapperService {
  Future<List<Anime>> getAnimesOfTheSeason(AnimeSeason season, int year);
}