
import 'package:alphabox/animes/data/helpers/nautiljon_helper.dart';
import 'package:alphabox/animes/domain/entities/animation_studio.dart';
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/domain/entities/anime_diffusion.dart';
import 'package:alphabox/animes/domain/entities/anime_genre.dart';
import 'package:alphabox/animes/domain/entities/anime_rating.dart';
import 'package:alphabox/animes/domain/enums/adaptation_type.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/enums/anime_type.dart';
import 'package:alphabox/animes/domain/repositories/anime_scrapper_service.dart';
import 'package:alphabox/shared/services/scrapper_service.dart';
import 'package:universal_html/html.dart';


class NautiljonScapperService implements AnimeScrapperService {
  final ScrapperService _scrapperService = ScrapperService();
  List<Anime> _animes = [];

  @override
  Future<List<Anime>> getAnimesOfTheSeason(AnimeSeason season, int year) async {
    await _scrapperService.load(NautiljonHelper.getNautiljonSeasonAnimeUrl(season, year));
    List<Element> animeElements = _scrapperService.querySelectorAll('.elt');
    _animes = animeElements.map((elt) {
      Anime anime = _parseAnime(elt);
      return anime;
    }).toList();
    print("Animes count: ${_animes.length}");
    return _animes;
  }

  Anime _parseAnime(Element element) {
    final String title = _parseTitle(element);
    final String alternativeTitle = _parseAlternativeTitle(element);
    final String imageUrl = _parseImageUrl(element);
    final String description = _parseDescription(element);
    final _NautiljonAnimeTopInfo topInfo = _parseTopInfo(element);
    final String? nautiljonUrl = _parseNautiljonUrl(element);
    final AnimeDiffusionBuilder animeDiffusionBuilder = _parseAnimeDiffusion(element);
    animeDiffusionBuilder.withNumberOfEpisodes(topInfo.numberOfEpisodes);

    return Anime(
      title: title,
      alternativeTitle: alternativeTitle,
      imageUrl: imageUrl,
      description: description,
      animeDiffusion: animeDiffusionBuilder.build(),
      type: topInfo.type,
      adaptedFrom: topInfo.adaptedFrom,
      genres: topInfo.genres,
      studio: topInfo.studio,
      rating: AnimeRating.defaultRating(),
      nautiljonUrl: nautiljonUrl,
    );
  }

  String _parseTitle(Element element) {
    Element? titleElement = element.querySelector('div.title > h2 > a');
    return titleElement?.innerHtml?.trim() ?? 'No title'; 
  }

  String _parseAlternativeTitle(Element element) {
    Element? alternativeTitleElement = element.querySelector('div.title > p');
    return alternativeTitleElement?.innerHtml?.trim() ?? 'No alternative title';
  }

  String _parseImageUrl(Element element) {
    Element? imageElement = element.querySelector('a > div');
    if (imageElement == null) {
      return '';
    }
    String style = imageElement.getAttribute('style') ?? '';
    return _extractBagroundImageUrlFromStyle(style);
  }

  
  String _extractBagroundImageUrlFromStyle(String style) {
    if (style.isEmpty) {
      return '';
    }
    RegExp regExp = RegExp(r'background-image:url\((.*?)\)');
    return regExp.firstMatch(style)!.group(1)!;
  }

  String _parseDescription(Element element) {
    Element? descriptionElement = element.querySelector('div.texte');
    return descriptionElement?.innerHtml?.trim() ?? 'No description';
  }

  _NautiljonAnimeTopInfo _parseTopInfo(Element element) {
    Element topInfoElement = element.querySelector('div.infos_top')!;

    final AnimeType type = _parseType(topInfoElement);
    final int numberOfEpisodes = _parseNumberOfEpisodes(topInfoElement);
    final AnimationStudio studio = _parseStudio(topInfoElement);
    final AdaptationType adaptedFrom = _parseAdaptedFrom(topInfoElement);
    final AnimeGenre genres = _parseGenres(topInfoElement);

    return _NautiljonAnimeTopInfo(
      type: type,
      numberOfEpisodes: numberOfEpisodes,
      studio: studio,
      adaptedFrom: adaptedFrom,
      genres: genres,
    );
  }

  String? _parseNautiljonUrl(Element element) {
    Element? animePageUrlElement = element.querySelector("div.title > h2 > a");
    if (animePageUrlElement == null) {
      return null;
    }

    String? animePageUrlElementHref = animePageUrlElement.attributes['href'];
    if (animePageUrlElementHref == null) {
      return null;
    }

    return '${NautiljonHelper.kNautiljonBaseUrl}/$animePageUrlElementHref';
  }

  AnimeType _parseType(Element element) {
    Element? typeElement = element.querySelector('div.infos > span:nth-child(1)');
    String typeText = typeElement?.innerHtml?.trim() ?? '';
    return NautiljonHelper.getAnimeTypeFromNautiljonType(typeText);
  }

  int _parseNumberOfEpisodes(Element element) {
    Element? numberOfEpisodesElement = element.querySelector('div.infos > span:nth-child(3)');
    if (numberOfEpisodesElement == null) {
      return -1;
    }
    String numberOfEpisodesText = numberOfEpisodesElement.innerHtml?.trim() ?? '-1';
    return _parseEpisodeNumber(numberOfEpisodesText);
  }

  int _parseEpisodeNumber(String text) {
    if (text.isEmpty) {
      return -1;
    }
    if (text == '? eps') {
      return -1;
    }
    return int.parse(text.substring(0, text.indexOf(' ')));
  }

  AnimationStudio _parseStudio(Element element) {
    Element? studioElement = element.querySelector('div.infos > span:nth-child(5) > a');
    String? studioText = studioElement?.innerHtml?.trim();
    if (studioText == null) {
      return AnimationStudio.defaultStudio();
    }
    String studioUrl = '${NautiljonHelper.kNautiljonBaseUrl}/${studioElement!.attributes['href']!}';
    return AnimationStudio(name: studioText, url: studioUrl);
  }

  AdaptationType _parseAdaptedFrom(Element element) {
    Element? adaptedFromElement = element.querySelector('div.infos > span:nth-child(7)');
    if (adaptedFromElement == null) {
      return AdaptationType.unknown;
    }
    String adaptedFromText = adaptedFromElement.innerHtml?.trim() ?? '';
    return NautiljonHelper.getAdaptationTypeFromNautiljonType(adaptedFromText);
  }

  AnimeGenre _parseGenres(Element element) {
    List<Element> genresElements = element.querySelectorAll('div.infos_top > div.genres.tagsList > a');
    if (genresElements.isEmpty) {
      return AnimeGenre.defaultAnimeGenre();
    }
    List<String> genres = [];
    for (var genreElement in genresElements) {
      var genre = genreElement.innerHtml?.trim();
      if (genre != null) {
        genres.add(genre);
      }
    }
    return AnimeGenre(values: genres);
  }

  AnimeDiffusionBuilder _parseAnimeDiffusion(Element element) {
    Element? diffusionElement = element.querySelector('div.infos2 > span:nth-child(1)');
    AnimeDiffusionBuilder builder = AnimeDiffusionBuilder();
    if (diffusionElement == null) {
      return builder;
    }
    String diffusionText = diffusionElement.innerHtml?.trim() ?? '';
    return NautiljonHelper.parseNautiljonDiffussionDatesToAnimeDiffusionBuilder(diffusionText, builder);
  }
}

class _NautiljonAnimeTopInfo {
  final int numberOfEpisodes;
  final AnimeType type;
  final AdaptationType adaptedFrom;
  final AnimeGenre genres;
  final AnimationStudio studio;

  _NautiljonAnimeTopInfo({
    required this.numberOfEpisodes,
    required this.type,
    required this.adaptedFrom,
    required this.genres,
    required this.studio,
  });
}