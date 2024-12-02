
import 'package:alphabox/animes/domain/entities/anime.dart';
import 'package:alphabox/shared/presentation/data_models/sorting_method.dart';

enum AnimeSortingType {
  name,
  score,
  startDate,
  endDate,
}

class AnimeSorting {
  static final SortingMethod<Anime, Anime> _nameSortingAlgorithm = SortingMethod(
    name: "sorting_method.by_name",
    compareFunction: (Anime a, Anime b) => a.title.compareTo(b.title),
  );

  static final SortingMethod<Anime, Anime> _scoreSortingAlgorithm = SortingMethod(
    name: "sorting_method.by_score",
    compareFunction: (Anime a, Anime b) => a.rating.average.compareTo(b.rating.average),
  );

  static final SortingMethod<Anime, Anime> _startDateSortingAlgorithm = SortingMethod(
    name: "sorting_method.by_start_date",
    compareFunction: (Anime a, Anime b) {
      if (a.animeDiffusion.start == null && b.animeDiffusion.start == null) {
        return 0;
      } else if (a.animeDiffusion.start == null) {
        return 1;
      } else if (b.animeDiffusion.start == null) {
        return -1;
      } else {
        return a.animeDiffusion.start!.compareTo(b.animeDiffusion.start!);
      }
    },
  );

  static final SortingMethod<Anime, Anime> _endDateSortingAlgorithm = SortingMethod(
    name: "sorting_method.by_end_date",
    compareFunction: (Anime a, Anime b) {
      if (a.animeDiffusion.end == null && b.animeDiffusion.end == null) {
        return 0;
      } else if (a.animeDiffusion.end == null) {
        return 1;
      } else if (b.animeDiffusion.end == null) {
        return -1;
      } else {
        return a.animeDiffusion.end!.compareTo(b.animeDiffusion.end!);
      }
    },
  );

  static final Map<AnimeSortingType, SortingMethod<Anime, Anime>> allSortingMethods = {
    AnimeSortingType.name: _nameSortingAlgorithm,
    AnimeSortingType.score: _scoreSortingAlgorithm,
    AnimeSortingType.startDate: _startDateSortingAlgorithm,
    AnimeSortingType.endDate: _endDateSortingAlgorithm,
  };
}