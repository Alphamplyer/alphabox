import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/presentation/configs/anime_sorting_methods.dart';
import 'package:alphabox/animes/presentation/controllers/season_anime_list_controller.dart';
import 'package:alphabox/shared/enum/sorting_order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SeasonAnimeListScreen extends StatefulWidget {
  const SeasonAnimeListScreen({super.key});

  @override
  State<SeasonAnimeListScreen> createState() => _SeasonAnimeListScreenState();
}

class _SeasonAnimeListScreenState extends State<SeasonAnimeListScreen> {
  final SeasonAnimeListController _controller = SeasonAnimeListController();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _controller.previousSeason,
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, widget) {
                          return DropdownButton<AnimeSeason>(
                            value: _controller.selectedSeason,
                            onChanged: (value) => _controller.setSelectedSeason(value ?? _controller.selectedSeason),
                            items: AnimeSeason.values
                              .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                              .toList(),
                          );
                        }
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, widget) {
                          return DropdownButton<int>(
                            value: _controller.selectedYear,
                            onChanged: (value) => _controller.setSelectedYear(value ?? _controller.selectedYear),
                            items: List.generate(5, (index) => index + DateTime.now().year - 3)
                              .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                              .toList(),
                          );
                        }
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _controller.nextSeason,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[900],
                    
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Sort by: "),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, widget) {
                          return DropdownButton<AnimeSortingType>(
                            value: _controller.selectedSortingType,
                            onChanged: (value) => _controller.selectSortingType(value ?? _controller.selectedSortingType),
                            items: AnimeSortingType.values
                              .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                              .toList(),
                          );
                        }
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, widget) {
                          return DropdownButton<SortingOrder>(
                            value: _controller.selectedSortingOrder,
                            onChanged: (value) => _controller.selectSortingOrder(value ?? _controller.selectedSortingOrder),
                            items: SortingOrder.values
                              .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                              .toList(),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, widget) {
                  if (_controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(_controller.animeList.length, (int index) {
                        final anime = _controller.animeList[index];
                        return ListTile(
                          key: ValueKey(anime.title),
                          title: Text(anime.title),
                          subtitle: Text(anime.description),
                          leading: CachedNetworkImage(imageUrl: anime.imageUrl, width: 165, height: 250),
                        );
                      }),
                    )
                  );
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}