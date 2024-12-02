
enum AnimeSeason {
  winter,
  spring,
  summer,
  fall;

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

  bool isInThisSeason(DateTime date) {
    final season = fromDate(date);
    return season == AnimeSeason.fromDate(DateTime.now());
  }

  static int getSeasonStartMonth(AnimeSeason season) {
    switch (season) {
      case AnimeSeason.winter:
        return 1;
      case AnimeSeason.spring:
        return 4;
      case AnimeSeason.summer:
        return 7;
      case AnimeSeason.fall:
        return 10;
    }
  }

  int get startMonth => getSeasonStartMonth(this);
}
