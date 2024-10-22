import 'package:dictionary_app/features/main/data/api_util.dart';
import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/words_model.dart';
import 'package:dictionary_app/features/main/domain/repository/main_repository.dart';
import 'package:either_dart/either.dart';

class MainDataRepository extends MainRepository {
  final ApiUtil _apiUtil;
  MainDataRepository(this._apiUtil);

  @override
  Future<Either<int, WordsModel>> getTerms({required int chapter}) async {
    return await _apiUtil.getTerms(chapter);
  }

  @override
  Future<Either<int, List<ChapterModel>>> getChapters() async {
    return await _apiUtil.getChapters();
  }

  @override
  Future<Either<int, WordsModel>> getSimilarTerms(
      {required String term}) async {
    return await _apiUtil.getSimilarTerms(term);
  }
}
