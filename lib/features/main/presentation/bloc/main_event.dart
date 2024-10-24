part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

final class MainGetChaptersEvent extends MainEvent {}

final class MainGetTermsFromChapterEvent extends MainEvent {
  final int chapter;
  final int page;
  final int size = 15;
  MainGetTermsFromChapterEvent({required this.chapter, required this.page});
}

final class MainGetSimilarWordsEvent extends MainEvent {
  final String term;
  MainGetSimilarWordsEvent({required this.term});
}
