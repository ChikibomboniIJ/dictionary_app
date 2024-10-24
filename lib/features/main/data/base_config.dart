import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseConfig {
  final String domain = dotenv.env["DOMAIN"] ?? "";

  String getChaptersUrl() {
    const String url = "/chapters";
    return url;
  }

  String getWordsFromChapterUrl(int chapter) {
    final String url = '/chapters/$chapter/terms';
    return url;
  }

  String getSimilarTermsUrl(String term) {
    const String url = "/terms/find";
    return url;
  }
}
