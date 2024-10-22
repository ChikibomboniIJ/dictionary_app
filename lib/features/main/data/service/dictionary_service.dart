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
      final cache = await _defaultCacheManager.getFileFromCache(url.toString());
      if (cache != null) {
        final cacheString = await cache.file.readAsString();
        return Right(ApiChapterModel.fromApi(jsonDecode(cacheString)));
      } else {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          await _defaultCacheManager.putFile(
            url.toString(),
            response.bodyBytes,
            fileExtension: 'json',
          );
          List<ApiChapterModel> apiChapterModel =
              ApiChapterModel.fromApi(jsonDecode(response.body));
          return Right(apiChapterModel);
        } else {
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      return const Left(400);
    }
  }

  Future<Either<int, ApiWordsModel>> getTerms(int chapter) async {
    try {
      final url =
          Uri.http(_config.domain, _config.getWordsFromChapterUrl(chapter));
      final cache = await _defaultCacheManager.getFileFromCache(url.toString());
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
          return Right(
              ApiWordsModel.fromApiTermPage(jsonDecode(response.body)));
        } else {
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      return const Left(400);
    }
  }

  Future<Either<int, ApiWordsModel>> getSimilarTerms(String term) async {
    try {
      final url = Uri.http(_config.domain, _config.getSimilarTermsUrl(term));
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
          return Right(ApiWordsModel.fromApi(jsonDecode(response.body)));
        } else {
          return Left(response.statusCode);
        }
      }
    } catch (e) {
      return const Left(400);
    }
  }
}
