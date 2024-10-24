class ApiWordsModel {
  int? totalElements;
  int? curPage;
  List<ApiWordModel>? apiWordModelList;
  ApiWordsModel(this.apiWordModelList, this.curPage, this.totalElements);

  static ApiWordsModel fromApi(Map<String, dynamic> json) {
    List<ApiWordModel>? apiWords = ApiWordModel.fromApi(json["terms"]);
    int? curPage = json["pageable"]["pageNumber"];
    int? totalElements = json["totalElements"];
    return ApiWordsModel(apiWords, curPage, totalElements);
  }

  static ApiWordsModel fromApiTermPage(Map<String, dynamic> json) {
    List<ApiWordModel>? apiWords =
        ApiWordModel.fromApi(json["termPage"]["terms"]);
    int? curPage = json["termPage"]["pageable"]["pageNumber"];
    int? totalElements = json["termPage"]["totalElements"];
    return ApiWordsModel(apiWords, curPage, totalElements);
  }
}

class ApiChapterModel {
  int? id;
  String? china;
  String? english;
  String? russian;
  String? transcription;
  ApiChapterModel(
      this.id, this.china, this.english, this.russian, this.transcription);

  ApiChapterModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        china = json['china'],
        english = json["english"],
        russian = json["russian"],
        transcription = json["transcription"];

  static List<ApiChapterModel> fromApi(List<dynamic> json) {
    List<ApiChapterModel> list =
        (json).map((i) => ApiChapterModel.fromJson(i)).toList();
    return list;
  }
}

class ApiWordModel {
  int? id;
  String? china;
  String? english;
  String? russian;
  String? transcription;
  int? chapterId;

  ApiWordModel(this.id, this.china, this.english, this.russian,
      this.transcription, this.chapterId);

  ApiWordModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        china = json['china'],
        english = json["english"],
        russian = json["russian"],
        transcription = json["transcription"],
        chapterId = json["chapterId"];

  static List<ApiWordModel> fromApi(List<dynamic> json) {
    List<ApiWordModel> list =
        (json).map((i) => ApiWordModel.fromJson(i)).toList();
    return list;
  }
}
