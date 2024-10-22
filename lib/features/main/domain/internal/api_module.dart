import 'package:dictionary_app/features/main/data/api_util.dart';
import 'package:dictionary_app/features/main/data/service/dictionary_service.dart';

class ApiModule {
  static ApiUtil apiUtil() {
    return ApiUtil(DictionaryService());
  }
}
