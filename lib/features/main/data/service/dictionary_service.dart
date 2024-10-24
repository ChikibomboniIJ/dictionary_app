import 'dart:convert';
import 'package:dictionary_app/features/main/data/base_config.dart';
import 'package:dictionary_app/features/main/data/model/api_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class DictionaryService {
  final BaseConfig _config = BaseConfig();
  final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();

  Future<Either<int, List<ApiChapterModel>>> getChapters() async {
    try {
      final url = Uri.http(_config.domain, _config.getChaptersUrl());
      print(url);
      final cache = await _defaultCacheManager.getFileFromCache(url.toString());
      if (cache != null) {
        print("CACHED");
        final cacheString = await cache.file.readAsString();
        return Right(ApiChapterModel.fromApi(jsonDecode(cacheString)));
      } else {
        print("NOT CACHED");
        final response = await http.get(url);
        print("RESPONSE ${response.body}");
        if (response.statusCode == 200) {
          print("RESPOSE == 200");
          await _defaultCacheManager.putFile(
            url.toString(),
            response.bodyBytes,
            fileExtension: 'json',
          );
          List<ApiChapterModel> apiChapterModel = ApiChapterModel.fromApi(
              jsonDecode(base64Encode(response.bodyBytes)));
          return Right(apiChapterModel);
        } else {
          print(response.statusCode);
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      print(e);
      return const Left(400);
    }
  }

  Future<Either<int, ApiWordsModel>> getTerms(
      int chapter, Map<String, String> query) async {
    try {
      final url = Uri.http(
          _config.domain, _config.getWordsFromChapterUrl(chapter), query);
      print(url.toString());
      final cache = await _defaultCacheManager.getFileFromCache(url.toString());
      print(url.toString());
      if (cache != null) {
        final cacheString = await cache.file.readAsString();
        return Right(ApiWordsModel.fromApiTermPage(jsonDecode(cacheString)));
      } else {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          await _defaultCacheManager.putFile(
            url.toString(),
            response.bodyBytes,
            fileExtension: 'json',
          );
          return Right(ApiWordsModel.fromApiTermPage(
              jsonDecode(base64Encode(response.bodyBytes))));
        } else {
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      print(e);
      return const Left(400);
    }
  }

  Future<Either<int, ApiWordsModel>> getSimilarTerms(
      String term, Map<String, String> query) async {
    try {
      final url =
          Uri.http(_config.domain, _config.getSimilarTermsUrl(term), query);
      print(url.toString());
      final cache = await _defaultCacheManager.getFileFromCache(url.toString());
      if (cache != null) {
        final cacheString = await cache.file.readAsString();
        return Right(ApiWordsModel.fromApi(jsonDecode(cacheString)));
      } else {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          await _defaultCacheManager.putFile(
            url.toString(),
            response.bodyBytes,
            fileExtension: 'json',
          );

          return Right(ApiWordsModel.fromApi(
              jsonDecode(base64Encode(response.bodyBytes))));
        } else {
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      return const Left(400);
    }
  }
}
