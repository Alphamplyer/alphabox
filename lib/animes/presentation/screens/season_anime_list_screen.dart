import 'package:alphabox/animes/domain/enums/anime_season.dart';
import 'package:alphabox/animes/presentation/configs/anime_sorting_methods.dart';
import 'package:alphabox/animes/presentation/controllers/season_anime_list_controller.dart';
import 'package:alphabox/animes/presentation/widgets/anime_list_view.dart';
import 'package:alphabox/shared/enum/sorting_order.dart';
import 'package:alphabox/shared/extensions/app_theme_extension.dart';
import 'package:alphabox/shared/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class SeasonAnimeListScreen extends StatefulWidget {
  const SeasonAnimeListScreen({super.key});

  @override
  State<SeasonAnimeListScreen> createState() => _SeasonAnimeListScreenState();
}

class _SeasonAnimeListScreenState extends State<SeasonAnimeListScreen> {
  final SeasonAnimeListController _controller = SeasonAnimeListController();
  final GlobalKey _newAnimesKey = GlobalKey();
  final GlobalKey _continuingAnimesKey = GlobalKey();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalizations.animeOfTheSeasonToolTitle),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.list),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            }
          ),
        ],
      ),
      endDrawer: Builder(
        builder: (context) {
          return Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text(context.appLocalizations.newAnimesSectionTitle),
                  onTap: () {
                    Scrollable.ensureVisible(_newAnimesKey.currentContext!);
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
                ListTile(
                  title: Text(context.appLocalizations.continuingAnimesSectionTitle),
                  onTap: () {
                    Scrollable.ensureVisible(_continuingAnimesKey.currentContext!);
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
              ],
            ),
          );
        }
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 16),
                  decoration: BoxDecoration(
                    color: context.theme.appColors.tertiaryBackgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                ),
                                onPressed: _controller.previousSeason,
                              ),
                              const Text(
                                "previous season",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "${context.appLocalizations.season(_controller.selectedSeason.name)} ${_controller.selectedYear}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "next season",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                                onPressed: _controller.nextSeason,
                              ),
                            ]
                          ),
                        ],
                      ),
                      
                      Divider(
                        color: context.theme.appColors.primaryColor,
                      ),
                      
                      Text(
                        "${context.appLocalizations.seasonLabel} ",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(animation: _controller, builder: (context, widget) {
                        return SegmentedButton(
                          emptySelectionAllowed: false,
                          multiSelectionEnabled: false,
                          selected: {_controller.selectedSeason},
                          onSelectionChanged: (value) => _controller.setSelectedSeason(value.first),
                          segments: List.generate(AnimeSeason.values.length, (index) {
                            return ButtonSegment(
                              value: AnimeSeason.values[index],
                              label: Text(context.appLocalizations.season(AnimeSeason.values[index].name)),
                              enabled: _controller.selectedSeason != AnimeSeason.values[index],
                            );
                          }),
                        );
                      }),
                      
                      const SizedBox(height: 8),
                      Text(
                        "${context.appLocalizations.yearLabel} ",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(animation: _controller, builder: (context, widget) {
                        return SegmentedButton(
                          emptySelectionAllowed: false,
                          multiSelectionEnabled: false,
                          selected: {_controller.selectedYear},
                          onSelectionChanged: (value) => _controller.setSelectedYear(value.first),
                          segments: List.generate(5, (index) => index + DateTime.now().year - 3)
                            .map((year) => ButtonSegment(
                              value: year,
                              label: Text(year.toString()),
                              enabled: _controller.selectedYear != year,
                            ))
                            .toList(),
                        );
                      }),
                      const SizedBox(height: 8),
                      
                      Divider(
                        color: context.theme.appColors.primaryColor,
                      ),

                      const SizedBox(height: 8),
                      Text (
                        "${context.appLocalizations.sortBy} ",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(animation: _controller, builder: (context, widget) {
                        return SegmentedButton(
                          emptySelectionAllowed: false,
                          multiSelectionEnabled: false,
                          selected: {_controller.selectedSortingType},
                          onSelectionChanged: (value) => _controller.selectSortingType(value.first),
                          segments: List.generate(AnimeSortingType.values.length, (index) {
                            return ButtonSegment(
                              value: AnimeSortingType.values[index],
                              label: Text(context.appLocalizations.sortingType(AnimeSortingType.values[index].name)),
                              enabled: _controller.selectedSortingType != AnimeSortingType.values[index],
                            );
                          }),
                        );
                      }),
                      
                      const SizedBox(height: 8),
                      Text (
                        "${context.appLocalizations.sortingOrderLabel} ",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(animation: _controller, builder: (context, widget) {
                        return SegmentedButton(
                          emptySelectionAllowed: false,
                          multiSelectionEnabled: false,
                          selected: {_controller.selectedSortingOrder},
                          onSelectionChanged: (value) => _controller.selectSortingOrder(value.first),
                          segments: List.generate(SortingOrder.values.length, (index) {
                            return ButtonSegment(
                              value: SortingOrder.values[index],
                              label: Text(context.appLocalizations.sortingOrder(SortingOrder.values[index].name)),
                              enabled: _controller.selectedSortingOrder != SortingOrder.values[index],
                            );
                          }),
                        );
                      }),
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
                      children: [
                        AnimeListView(
                          sectionKey: _newAnimesKey,
                          title: context.appLocalizations.newAnimesSectionTitle,
                          animes: _controller.newAnimes,
                        ),
                        AnimeListView(
                          sectionKey: _continuingAnimesKey,
                          title: context.appLocalizations.continuingAnimesSectionTitle,
                          animes: _controller.continuingAnimes,
                        ),
                        const SizedBox(height: 16),
                      ],
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