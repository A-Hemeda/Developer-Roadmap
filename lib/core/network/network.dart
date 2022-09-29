import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  static Dio? _dio;

  DioHelper._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: baseApiUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
  }) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-language": lang,
      "token": token
    };
    return _dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required var data,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
  }) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-language": lang,
      "token": token
    };
    return _dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
  }) {
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-language": lang,
      "Authorization": token
    };
    return _dio!.delete(url, queryParameters: query, data: data);
  }
}
