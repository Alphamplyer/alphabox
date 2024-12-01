
enum AnimeSeason {
  winter,
  spring,
  summer,
  fall;

  String get translateKey {
    switch (this) {
      case AnimeSeason.winter:
        return 'Winter';
      case AnimeSeason.spring:
        return 'Spring';
      case AnimeSeason.summer:
        return 'Summer';
      case AnimeSeason.fall:
        return 'Fall';
    }
  }

  AnimeSeason get next {
    switch (this) {
      case AnimeSeason.winter:
        return AnimeSeason.spring;
      case AnimeSeason.spring:
        return AnimeSeason.summer;
      case AnimeSeason.summer:
        return AnimeSeason.fall;
      case AnimeSeason.fall:
        return AnimeSeason.winter;
    }
  }

  AnimeSeason get previous {
    switch (this) {
      case AnimeSeason.winter:
        return AnimeSeason.fall;
      case AnimeSeason.spring:
        return AnimeSeason.winter;
      case AnimeSeason.summer:
        return AnimeSeason.spring;
      case AnimeSeason.fall:
        return AnimeSeason.summer;
    }
  }

  static AnimeSeason fromDate(DateTime date) {
    switch (date.month) {
      case 1:
      case 2:
      case 3:
        return AnimeSeason.winter;
      case 4:
      case 5:
      case 6:
        return AnimeSeason.spring;
      case 7:
      case 8:
      case 9:
        return AnimeSeason.summer;
      case 10:
      case 11:
      case 12:
        return AnimeSeason.fall;
      default:
        return AnimeSeason.winter;
    }
  }
}
