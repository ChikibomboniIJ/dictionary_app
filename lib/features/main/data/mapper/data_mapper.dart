import 'dart:convert';

import 'package:dictionary_app/features/main/data/model/api_model.dart';
import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/word_model.dart';
import 'package:dictionary_app/features/main/domain/models/words_model.dart';

class DataMapper {
  static WordsModel getWordsFromApiModel(ApiWordsModel model) {
    List<WordModel> words = [];
    for (ApiWordModel apiWordModel in model.apiWordModelList ?? []) {
      const utf8Decoder = Utf8Decoder(allowMalformed: true);

      print(utf8Decoder.convert(utf8.encode(apiWordModel.russian ?? "")));
      words.add(WordModel(
          ruWord: (apiWordModel.russian ?? ""),
          enWord: apiWordModel.english ?? "",
          chWord: apiWordModel.china ?? "",
          transcription: apiWordModel.transcription ?? ""));
    }
    return WordsModel(
        curPage: model.curPage ?? 0,
        totalElements: model.totalElements ?? 0,
        words: words);
  }

  static List<ChapterModel> getChaptersFromApiModel(
      List<ApiChapterModel> list) {
    List<ChapterModel> chapters = [];
    for (ApiChapterModel apiChapterModel in list) {
      chapters.add(ChapterModel(
          russian: apiChapterModel.russian ?? "",
          english: apiChapterModel.english ?? "",
          china: apiChapterModel.china ?? "",
          chapterId: apiChapterModel.id ?? 0,
          transcription: apiChapterModel.transcription ?? ""));
    }
    return chapters;
  }
}
