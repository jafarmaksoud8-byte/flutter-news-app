import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_2/core/category_enum.dart';
import 'package:project_2/models/news_response_model.dart';

class NewsService {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  static const baseUrl = 'https://newsapi.org/v2/';
  static String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';

  Future<NewsResponseModel> fetchedArticles({
    required String country,
    required String category,
    required int page,
    required int pageSize,
  }) async {
    try {
      if (category == CategoryEnum.general.label) {
        return await fetchedGeneralNewsArticles(
          country: country,
          page: page,
          pageSize: pageSize,
        );
      } else {
        return await fetchedNewsByCatecory(
          country: country,
          category: category,
          page: page,
          pageSize: pageSize,
        );
      }
    } on DioException catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Error: ${e.message}');
    }
  }

  Future<NewsResponseModel> fetchedGeneralNewsArticles({
    required String country,
    required int page,
    required int pageSize,
    String? category,
  }) async {
    try {
      final response = await dio.get(
        'top-headlines',
        queryParameters: {
          'country': country,
          'apiKey': apiKey,
          'page': page,
          'pageSize': pageSize,
        },
      );
      if (response.statusCode == 200) {
        return NewsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  Future<NewsResponseModel> fetchedNewsByCatecory({
    required String country,
    required String category,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await dio.get(
        'top-headlines',
        queryParameters: {
          'country': country,
          'category': category,
          'apiKey': apiKey,
          'page': page,
          'pageSize': pageSize,
        },
      );
      if (response.statusCode == 200) {
        return NewsResponseModel.fromJson(response.data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error: ${e.message}');
      throw Exception('Error: ${e.message}');
    }
  }
}
