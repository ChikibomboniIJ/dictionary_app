import 'package:dictionary_app/features/main/data/mapper/data_mapper.dart';
import 'package:dictionary_app/features/main/data/service/dictionary_service.dart';
import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/words_model.dart';
import 'package:either_dart/either.dart';

class ApiUtil {
  final DictionaryService _dictionaryService;
  ApiUtil(this._dictionaryService);

  Future<Either<int, WordsModel>> getTerms(int chapter) async {
    final result = await _dictionaryService.getTerms(chapter);
    if (result.isRight) {
      final ans = DataMapper.getWordsFromApiModel(result.right);
      return Right(ans);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<int, List<ChapterModel>>> getChapters() async {
    final result = await _dictionaryService.getChapters();
    if (result.isRight) {
      final ans = DataMapper.getChaptersFromApiModel(result.right);
      return Right(ans);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<int, WordsModel>> getSimilarTerms(String term) async {
    final result = await _dictionaryService.getSimilarTerms(term);
    if (result.isRight) {
      final ans = DataMapper.getWordsFromApiModel(result.right);
      return Right(ans);
    } else {
      return Left(result.left);
    }
  }
}
