import 'package:dictionary_app/features/main/data/repository/main_data_repository.dart';
import 'package:dictionary_app/features/main/domain/internal/repository_model.dart';
import 'package:dictionary_app/features/main/domain/models/category_model.dart';
import 'package:dictionary_app/features/main/domain/models/word_model.dart';
import 'package:dictionary_app/features/main/presentation/widgets/header.dart';
import 'package:dictionary_app/features/main/presentation/widgets/term.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

enum Operation { chapterWords, similarWods }

class _BodyState extends State<Body> {
  static const pageSize = 8;

  Operation? state;
  int i = 0;
  int? selectedChapter;

  String? similarTerm;

  late Future<void> getChapters;

  final PagingController<int, Term> pagingController =
      PagingController(firstPageKey: 1);

  final MainDataRepository _repositoryModule =
      RepositoryModule.mainRepository();

  DropListModel dropListModel = DropListModel([]);

  late OptionItem optionItemSelected;

  @override
  void initState() {
    getChapters = _fetchChapters();
    super.initState();
  }

  Future<void> _fetchChapters() async {
    final chapters = await _repositoryModule.getChapters();
    if (chapters.isRight) {
      for (ChapterModel chapterModel in chapters.right) {
        dropListModel.listOptionItems.add(OptionItem(
            id: chapterModel.chapterId.toString(),
            title:
                "${chapterModel.russian}\n${chapterModel.english}\n${chapterModel.china}"));
      }
      optionItemSelected = dropListModel.listOptionItems[0];
      selectedChapter = int.parse(dropListModel.listOptionItems[0].id!);
      pagingController.addPageRequestListener((pageKey) {
        fetchWordsFromChapter(pageKey);
      });
    }
  }

  Future<void> fetchWordsFromChapter(int pageKey) async {
    try {
      final Map<String, String> query = {
        "page": pageKey.toString(),
        "size": pageSize.toString()
      };
      final newWords = await _repositoryModule.getTerms(
          chapter: selectedChapter!, query: query);
      if (newWords.isRight) {
        final isLastPage = newWords.right.words.length < pageSize;
        List<Term> terms = [];

        for (WordModel wordModel in newWords.right.words) {
          late Color backgroundColor;
          if (i % 2 == 0) {
            backgroundColor = Colors.white;
          } else {
            backgroundColor = const Color.fromARGB(255, 233, 233, 233);
          }
          terms.add(Term(
              backgroudColor: backgroundColor,
              id: i + 1,
              russian: wordModel.ruWord,
              english: wordModel.enWord,
              china: wordModel.chWord,
              transcription: wordModel.transcription));
          i++;
        }
        if (isLastPage) {
          pagingController.appendLastPage(terms);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(terms, nextPageKey);
        }
      } else {
        throw pagingController.error = Exception();
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void changeChapter(OptionItem optionItem) {
    setState(() {
      optionItemSelected = optionItem;
    });
    i = 0;
    selectedChapter = int.parse(optionItem.id!);
    pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              SelectDropList(
                height: 100,
                itemSelected: optionItemSelected,
                dropListModel: dropListModel,
                showIcon: true,
                showArrowIcon: true,
                showBorder: true,
                paddingTop: 0,
                icon: const Icon(Icons.book, color: Colors.black),
                onOptionSelected: (optionItem) {
                  changeChapter(optionItem);
                },
              ),
              const Header(),
              Expanded(
                child: PagedListView<int, Term>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Term>(
                    itemBuilder: (context, item, index) => Term(
                      id: item.id,
                      backgroudColor: item.backgroudColor,
                      russian: item.russian,
                      english: item.english,
                      china: item.china,
                      transcription: item.transcription,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: getChapters,
    );
  }
}
