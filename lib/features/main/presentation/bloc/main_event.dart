part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

final class MainGetChaptersEvent extends MainEvent {}

final class MainGetTermsFromChapterEvent extends MainEvent {
  final int chapter;
  MainGetTermsFromChapterEvent({required this.chapter});
}

final class MainGetSimilarWordsEvent extends MainEvent {
  final String term;
  MainGetSimilarWordsEvent({required this.term});
}
