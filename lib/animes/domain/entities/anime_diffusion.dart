class AnimeDiffusion {
  static const int kEpisodeReleaseRateInDays = 7; 
  static const int kNumberOfEpisodeToEstimateOneWeekPause = 22;

  final DateTime? start;
  final DateTime? end;
  final int numberOfEpisodes;
  final bool isEndDateEstimated;

  bool get hasStartingDate => start != null;
  bool get hasEndingDate => end != null;
  bool get isOngoing => !hasEndingDate || end!.isAfter(DateTime.now());

  AnimeDiffusion({
    this.start,
    this.end,
    this.numberOfEpisodes = -1,
    this.isEndDateEstimated = false,
  });

  @override
  String toString() {
    return 'AnimeDiffusion(start: $start, end: $end)';
  }
}

class AnimeDiffusionBuilder {
  DateTime? start;
  DateTime? end;
  int numberOfEpisodes = -1;
  bool isEstimated = false;

  AnimeDiffusionBuilder();

  AnimeDiffusion build() {
    if (end == null && _canEndDateBeEstimated()) {
      end = _computeEstimatedEndDate();
      isEstimated = true;
    }

    return AnimeDiffusion(
      start: start,
      end: end,
      numberOfEpisodes: numberOfEpisodes,
      isEndDateEstimated: isEstimated,
    );
  }

  bool _canEndDateBeEstimated() {
    return start != null && numberOfEpisodes != -1;
  }

  DateTime? _computeEstimatedEndDate() {
    int daysToTheFinalDiffusionDate = numberOfEpisodes * AnimeDiffusion.kEpisodeReleaseRateInDays;

    // Generally, an anime that airs for more than one season has a break of 1 week in-between.
    if (numberOfEpisodes >= AnimeDiffusion.kNumberOfEpisodeToEstimateOneWeekPause) {
      daysToTheFinalDiffusionDate += AnimeDiffusion.kEpisodeReleaseRateInDays;
    }
    
    return start!.add(Duration(days: daysToTheFinalDiffusionDate));
  }

  AnimeDiffusionBuilder withStart(DateTime? start) {
    this.start = start;
    return this;
  }

  AnimeDiffusionBuilder withEnd(DateTime? end) {
    this.end = end;
    return this;
  }

  AnimeDiffusionBuilder withNumberOfEpisodes(int numberOfEpisodes) {
    this.numberOfEpisodes = numberOfEpisodes;
    return this;
  }

  @override
  String toString() => 'AnimeDiffusionBuilder(start: $start, end: $end, numberOfEpisodes: $numberOfEpisodes)';
}