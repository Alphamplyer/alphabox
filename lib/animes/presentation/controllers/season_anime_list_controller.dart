
import 'dart:async';
import 'dart:io';

import 'package:alphabox/animes/data/repositories/nautiljon_scapper_service.dart';
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/repositories/anime_scrapper_service.dart';
import 'package:alphabox/animes/presentation/configs/anime_sorting_methods.dart';
import 'package:alphabox/shared/enum/sorting_order.dart';
import 'package:alphabox/shared/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class SeasonAnimeListController extends ChangeNotifier {
  final AnimeScrapperService nautiljonScapperService = NautiljonScapperService();

  late AnimeSeason _selectedSeason;
  late int _selectedYear;
  final List<Anime> _newAnimes = [];
  final List<Anime> _continuingAnimes = [];

  bool _isLoading = true;
  AnimeSortingType _selectedSortingType = AnimeSortingType.name;
  SortingOrder _selectedSortingOrder = SortingOrder.ascending;

  AnimeSeason get selectedSeason => _selectedSeason;
  int get selectedYear => _selectedYear;
  List<Anime> get newAnimes => _newAnimes;
  List<Anime> get continuingAnimes => _continuingAnimes;
  bool get isLoading => _isLoading;
  AnimeSortingType get selectedSortingType => _selectedSortingType;
  SortingOrder get selectedSortingOrder => _selectedSortingOrder;

  SeasonAnimeListController();

  Future<void> init() async {
    DateTime now = DateTime.now();
    _selectedSeason = AnimeSeason.fromDate(now);
    _selectedYear = now.year;
    await _loadTheSeasonsAnime();    
  }

  Future<void> setSelectedSeason(AnimeSeason season) async {
    _selectedSeason = season;
    await _loadTheSeasonsAnime();
  }

  Future<void> nextSeason() async {
    _selectedSeason = _selectedSeason.next;
    if (_selectedSeason == AnimeSeason.winter) {
      _selectedYear++;
    }
    await _loadTheSeasonsAnime();
  }

  Future<void> previousSeason() async {
    _selectedSeason = _selectedSeason.previous;
    if (_selectedSeason == AnimeSeason.fall) {
      _selectedYear--;
    }
    await _loadTheSeasonsAnime();
  }

  Future<void> setSelectedYear(int year) async {
    _selectedYear = year;
    await _loadTheSeasonsAnime();
  }

  Future<void> _loadTheSeasonsAnime() async {
    _isLoading = true;
    notifyListeners();
    List<Anime> animeList = await nautiljonScapperService.getAnimesOfTheSeason(_selectedSeason, _selectedYear);
    _splitAnimesBetweenNewAndContinuing(animeList);
    _sort();
    _isLoading = false;
    notifyListeners();
  }

  void _splitAnimesBetweenNewAndContinuing(List<Anime> animeList) {
    _newAnimes.clear();
    _continuingAnimes.clear();
    for (final anime in animeList) {
      if (anime.isInThisSeason(_selectedSeason, _selectedYear)) {
        _newAnimes.add(anime);
      } else {
        _continuingAnimes.add(anime);
      }
    }
  }

  void selectSortingType(AnimeSortingType type) {
    _selectedSortingType = type;
    _isLoading = true;
    notifyListeners();
    _sort();
    _isLoading = false;
    notifyListeners();
  }

  void selectSortingOrder(SortingOrder order) {
    _isLoading = true;
    _selectedSortingOrder = order;
    notifyListeners();
    _sort();
    _isLoading = false;
    notifyListeners();
  }

  void _sort() {
    final method = AnimeSorting.allSortingMethods[_selectedSortingType];
    if (method == null) {
      throw Exception("Sorting method not found");
    }
    _newAnimes.sort((a, b) => method.compare(a, b, _selectedSortingOrder));
    _continuingAnimes.sort((a, b) => method.compare(a, b, _selectedSortingOrder));
  }

  Future<void> exportFinalDateOrderedAnimes(Locale locale, AppLocalizations appLocalization) async {
    final method = AnimeSorting.allSortingMethods[AnimeSortingType.endDate];
    List<Anime> sortedAnimesByEndDate = List.from(_newAnimes.where((anime) => anime.animeDiffusion.hasEndingDate))..toList();
    sortedAnimesByEndDate.sort((a, b) => method!.compare(a, b, SortingOrder.ascending));

    IOSink writeStream = File("${Directory.current.path}/animes.txt").openWrite();

    Anime? previousAnime;
    for (final anime in sortedAnimesByEndDate) {
      if (previousAnime == null || previousAnime.animeDiffusion.end != anime.animeDiffusion.end) {
        writeStream.write(
          "${Platform.lineTerminator}**${DateFormat.MMMMEEEEd(locale.countryCode).format(anime.animeDiffusion.end!).capitalize()} :**${Platform.lineTerminator}",
        );
      }
      String formattedAnime = await formatAnime(anime, locale, appLocalization);
      writeStream.write(formattedAnime);
      previousAnime = anime;
    }

    await writeStream.flush();
    await writeStream.close();

    writeStream.done.catchError((e) {
      print('Error writing file: $e');
    });
  }

  Future<String> formatAnime(Anime anime, Locale locale, AppLocalizations appLocalization) async {
    return "[${appLocalization.animeType(anime.type.name)}] [${anime.title}](${anime.nautiljonUrl}) ${Platform.lineTerminator}";
    // AnimeDiffuserUrls diffusionUrl = await NautiljonHelper.getExternalUrlFromNautiljonUrl(anime.nautiljonUrl);
    // if (diffusionUrl.hasAtLeastOneUrl) {
    //   return "- [${diffusionUrl.formatToMarkdownLinks()}] [${appLocalization.animeType(anime.type.name)}] ${anime.title} ${Platform.lineTerminator}";
    // }

    // return "- [${appLocalization.animeType(anime.type.name)}] ${anime.title} ${Platform.lineTerminator}";
  }
}