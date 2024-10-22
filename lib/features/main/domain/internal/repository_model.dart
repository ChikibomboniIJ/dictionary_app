import 'package:dictionary_app/features/main/data/repository/main_data_repository.dart';
import 'package:dictionary_app/features/main/domain/internal/api_module.dart';

class RepositoryModule {
  static MainDataRepository mainRepository() {
    return MainDataRepository(ApiModule.apiUtil());
  }
}
