import 'package:dictionary_app/features/main/data/repository/main_data_repository.dart';
import 'package:dictionary_app/features/main/domain/internal/repository_model.dart';
import 'package:dictionary_app/features/main/domain/models/word_model.dart';
import 'package:dictionary_app/features/main/presentation/widgets/header.dart';
import 'package:dictionary_app/features/main/presentation/widgets/term.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  String term = "";
  String lang = "ru";
  int i = 0;
  static const pageSize = 10;
  final PagingController<int, Term> pagingController =
      PagingController(firstPageKey: 0);
  final MainDataRepository _repositoryModule =
      RepositoryModule.mainRepository();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchSimilarWords(pageKey);
    });
    super.initState();
  }

  Future<void> fetchSimilarWords(int pageKey) async {
    try {
      final Map<String, String> query = {
        "part": term,
        "lang": lang,
        "page": pageKey.toString(),
        "size": pageSize.toString(),
      };
      final newWords =
          await _repositoryModule.getSimilarTerms(term: term, query: query);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                  onSubmitted: (value) {
                    setState(() {});
                    term = value;
                    i = 0;
                    pagingController.refresh();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: DropdownButton(
                  value: lang,
                  items: const [
                    DropdownMenuItem(value: "ru", child: Text("Русский")),
                    DropdownMenuItem(value: "en", child: Text("English")),
                    DropdownMenuItem(value: "ch", child: Text("Chinese"))
                  ],
                  onChanged: (value) {
                    setState(() {
                      lang = value!;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Header(),
        ),
        if (term != "")
          Expanded(
            child: PagedListView<int, Term>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<Term>(
                itemBuilder: (context, item, index) => Term(
                  backgroudColor: item.backgroudColor,
                  id: item.id,
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
}
