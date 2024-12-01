
import 'dart:async';

import 'package:alphabox/animes/data/repositories/nautiljon_scapper_service.dart';
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/domain/repositories/anime_scrapper_service.dart';
import 'package:alphabox/animes/presentation/configs/anime_sorting_methods.dart';
import 'package:alphabox/shared/enum/sorting_order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeasonAnimeListController extends ChangeNotifier {
  final AnimeScrapperService nautiljonScapperService = NautiljonScapperService();

  late AnimeSeason _selectedSeason;
  late int _selectedYear;
  late List<Anime> _animeList;

  bool _isLoading = true;
  AnimeSortingType _selectedSortingType = AnimeSortingType.name;
  SortingOrder _selectedSortingOrder = SortingOrder.asc;

  AnimeSeason get selectedSeason => _selectedSeason;
  int get selectedYear => _selectedYear;
  List<Anime> get animeList => _animeList;
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
    _animeList = await nautiljonScapperService.getAnimesOfTheSeason(_selectedSeason, _selectedYear);
    _isLoading = false;
    notifyListeners();
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
    _animeList.sort((a, b) => method.compare(a, b, _selectedSortingOrder));
  }
}