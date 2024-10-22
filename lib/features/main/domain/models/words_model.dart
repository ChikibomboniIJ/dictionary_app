import 'package:dictionary_app/features/main/domain/models/word_model.dart';

class WordsModel {
  final int totalElements;
  final int curPage;
  final List<WordModel> words;
  WordsModel(
      {required this.curPage,
      required this.totalElements,
      required this.words});
}
