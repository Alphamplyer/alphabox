
class AnimeDiffuserUrls {
  String? crunchyroll;
  String? adn;
  String? netflix;

  bool get hasAtLeastOneUrl => crunchyroll != null || adn != null || netflix != null;

  AnimeDiffuserUrls({
    this.crunchyroll,
    this.adn,
    this.netflix,
  });

  @override
  String toString() {
    return 'AnimeDiffuserUrls(crunchyroll: $crunchyroll, adn: $adn, netflix: $netflix)';
  }

  String formatToMarkdownLinks() {
    String crunchyrollLink = crunchyroll != null ? '[Crunchyroll]($crunchyroll) ' : '';
    String adnLink = adn != null ? '[ADN]($adn) ' : '';
    String netflixLink = netflix != null ? '[Netflix]($netflix) ' : '';

    return '$crunchyrollLink$adnLink$netflixLink'.trim();
  }
}