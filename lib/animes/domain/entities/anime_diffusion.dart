class AnimeDiffusion {
  final DateTime? start;
  final DateTime? end;

  bool get hasStartingDate => start != null;
  bool get hasEndingDate => end != null;
  bool get isOngoing => !hasEndingDate || end!.isAfter(DateTime.now());

  DateTime? computeEstimatedEndDate(int? numberOfEpisodes) {
    if (hasEndingDate) return end;
    if (!hasStartingDate) return null;
    if (numberOfEpisodes == null) return null;

    int daysPerEpisode = 7;
    int totalDays = numberOfEpisodes * daysPerEpisode;
    // Generally, an anime that airs for more than one season has a break of 1 week in-between.
    if (numberOfEpisodes >= 22) {
      totalDays += daysPerEpisode;
    }
    return start!.add(Duration(days: totalDays));
  }

  AnimeDiffusion({
    this.start,
    this.end,
  });

  @override
  String toString() {
    return 'AnimeDiffusion(start: $start, end: $end)';
  }

  factory AnimeDiffusion.defaultDiffusion() {
    return AnimeDiffusion(start: null, end: null);
  }
}