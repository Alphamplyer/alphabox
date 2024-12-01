class AnimeGenre {
  final List<String> values;

  AnimeGenre({
    required this.values,
  });

  @override
  String toString() {
    return values.join(', ');
  }

  factory AnimeGenre.defaultAnimeGenre() {
    return AnimeGenre(values: []);
  }
}
