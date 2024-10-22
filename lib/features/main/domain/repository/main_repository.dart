import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/words_model.dart';
import 'package:either_dart/either.dart';

abstract class MainRepository {
  Future<Either<int, WordsModel>> getTerms({required int chapter});
  Future<Either<int, List<ChapterModel>>> getChapters();
  Future<Either<int, WordsModel>> getSimilarTerms({required String term});
}
