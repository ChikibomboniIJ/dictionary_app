import 'package:bloc/bloc.dart';
import 'package:dictionary_app/features/main/data/repository/main_data_repository.dart';
import 'package:dictionary_app/features/main/domain/internal/repository_model.dart';
import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/words_model.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainDataRepository _repositoryModule =
      RepositoryModule.mainRepository();

  MainBloc() : super(MainState()) {
    on<MainGetChaptersEvent>(_onGetChapters);
    on<MainGetTermsFromChapterEvent>(_onGetCategoryWords);
    on<MainGetSimilarWordsEvent>(_onGetSimilarTerms);
  }

  Future<void> _onGetSimilarTerms(
      MainGetSimilarWordsEvent event, Emitter<MainState> emit) async {
    Either<int, WordsModel> response =
        await _repositoryModule.getSimilarTerms(term: event.term);
    if (response.isRight) {}
  }

  Future<void> _onGetChapters(
      MainGetChaptersEvent event, Emitter<MainState> emit) async {
    Either<int, List<ChapterModel>> response =
        await _repositoryModule.getChapters();
    if (response.isRight) {}
  }

  Future<void> _onGetCategoryWords(
      MainGetTermsFromChapterEvent event, Emitter<MainState> emit) async {
    Either<int, WordsModel> response =
        await _repositoryModule.getTerms(chapter: event.chapter);
    if (response.isRight) {}
  }
}
