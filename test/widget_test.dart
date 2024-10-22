import 'dart:io';

import 'package:dictionary_app/features/main/data/repository/main_data_repository.dart';
import 'package:dictionary_app/features/main/domain/internal/repository_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => HttpOverrides.global = null);
  test("get_diary_test", () async {
    MainDataRepository mainRepository = RepositoryModule.mainRepository();
    final response = await mainRepository.getChapters();

    expect(true, response.isRight);
  });
}
