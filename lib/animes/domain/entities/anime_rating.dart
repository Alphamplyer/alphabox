import 'package:alphabox/animes/domain/enums/anime_rating_category.dart';

class AnimeRating {
  final Map<AnimeRatingCategory, double> ratings;

  AnimeRating({
    required this.ratings,
  });

  factory AnimeRating.defaultRating() {
    return AnimeRating(ratings: {});
  }

  double get average {
    return ratings.isEmpty ? -1 : ratings.values.reduce((a, b) => a + b) / ratings.length;
  }

  @override
  String toString() {
    return 'Total: ${average == -1 ? 'N/A' : average} (Animation: ${ratings[AnimeRatingCategory.animation] ?? 'N/A'}, Plot: ${ratings[AnimeRatingCategory.plot] ?? 'N/A'}, Soundtrack: ${ratings[AnimeRatingCategory.soundtrack] ?? 'N/A'}, Artistic Direction: ${ratings[AnimeRatingCategory.artisticDirection] ?? 'N/A'}, Character Writing: ${ratings[AnimeRatingCategory.characterWriting] ?? 'N/A'}, Opening: ${ratings[AnimeRatingCategory.opening] ?? 'N/A'}, Ending: ${ratings[AnimeRatingCategory.ending] ?? 'N/A'})';
  }
}