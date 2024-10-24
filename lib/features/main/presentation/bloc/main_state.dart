part of 'main_bloc.dart';

class MainState {
  final PagingController<int, Term> pagingController =
      PagingController(firstPageKey: 0);
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "Jatin Sharma"),
    OptionItem(id: "2", title: "Puneet Chand"),
    OptionItem(id: "3", title: "Vikas Bhardwaj"),
    OptionItem(id: "4", title: "Rakesh Kumar"),
    OptionItem(id: "5", title: "Nitish Kumar")
  ]);
}
