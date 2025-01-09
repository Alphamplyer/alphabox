
import 'package:alphabox/animes/domain/entities/anime_diffuser_urls.dart';
import 'package:alphabox/animes/domain/entities/anime_diffusion.dart';
import 'package:alphabox/animes/domain/enums/adaptation_type.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/enums/anime_type.dart';
import 'package:alphabox/shared/services/scrapper_service.dart';
import 'package:universal_html/html.dart';

class NautiljonHelper {
  static const String kNautiljonBaseUrl = 'https://www.nautiljon.com';
  static const String kNautiljonAnimeUrl = 'https://www.nautiljon.com/animes';
  static const String kCrunchyrollBaseUrl = 'https://www.crunchyroll.com';
  static const String kADNBaseUrl = 'https://animationdigitalnetwork.com';
  static const String kADNAnimeUrl = 'https://animationdigitalnetwork.com/video/';
  static const String kNetflixBaseUrl = 'https://www.netflix.com';
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

  static Future<AnimeDiffuserUrls> getExternalUrlFromNautiljonUrl(String? nautiljonUrl) async {
    AnimeDiffuserUrls animeDiffuserUrls = AnimeDiffuserUrls();
    if (nautiljonUrl == null || nautiljonUrl.isEmpty) {
      return animeDiffuserUrls;
    }

    ScrapperService scrapperService = ScrapperService();
    await scrapperService.load(nautiljonUrl);

    Element? firstCrunchyrollSimulcastElement = scrapperService.querySelector('#crunchyroll_ep > table > tbody > tr:nth-child(1) > td.aleft > a');
    Element? firstAdnSimulcastElement = scrapperService.querySelector('#adn_ep > table > tbody > tr:nth-child(1) > td.aleft > a');
    Element? firstNetflixSimulcastElement = scrapperService.querySelector('#netflix_ep > table > tbody > tr:nth-child(1) > td.aleft > a');

    if (firstCrunchyrollSimulcastElement != null) {
      String? href = firstCrunchyrollSimulcastElement.attributes['href'];
      if (href != null) {
        animeDiffuserUrls.crunchyroll = await getSeriesUrlFromCrunchyrollEpisode(href);
      } else {
        print("0x1 Crunchyroll href is null");
      }
    }

    if (firstAdnSimulcastElement != null) {
      String? href = firstAdnSimulcastElement.attributes['href'];
      if (href != null) {
        animeDiffuserUrls.adn = getSeriesUrlFromADNEpisode(href);
      }
    }

    if (firstNetflixSimulcastElement != null) {
      String? href = firstNetflixSimulcastElement.attributes['href'];
      if (href != null) {
        animeDiffuserUrls.netflix = href;
      }
    }

    return animeDiffuserUrls;
  }

  static Future<String?> getSeriesUrlFromCrunchyrollEpisode(String url) async {
    ScrapperService scrapperService = ScrapperService();
    print('Crunchyroll episode url: $url');
    await scrapperService.load(url);
    Element? seriesLinkElement = scrapperService.querySelector('#content > div > div > div.app-body-wrapper > div > div > div.content-wrapper--MF5LS > div > div.current-media-wrapper > div > div.current-media-header > div.current-media-parent-ref > a');
    if (seriesLinkElement == null) {
      print("0x2 Series link element is null");
      return null;
    }
    String? href = seriesLinkElement.attributes['href'];
    if (href == null) {
      print("0x3 Series link href is null");
      return null;
    }
    return kCrunchyrollBaseUrl + href;
  }

  static String? getSeriesUrlFromADNEpisode(String url) {
    String secondHalf = url.substring(kADNAnimeUrl.length);
    List<String> parts = secondHalf.split('/');
    if (parts.isNotEmpty) {
      return '$kADNAnimeUrl${parts.first}';
    }
    return null;
  }
}