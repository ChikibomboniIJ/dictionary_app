class BaseConfig {
  final String domain = "localhost:8082";

  String getChaptersUrl() {
    const String url = "/chapters";
    return url;
  }

  String getWordsFromChapterUrl(int chapter) {
    final String url = "/chapters/$chapter/terms";
    return url;
  }

  String getSimilarTermsUrl(String term) {
    const String url = "";
    return url;
  }
}
