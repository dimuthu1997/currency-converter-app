import 'package:currency_converter/res/app_url.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'api_provider.dart';

class DioApiProvider implements ApiProvider {
  final Dio _dio;

  final Logger _logger = Logger();

  DioApiProvider({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: AppUrl.baseUrl));

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic e) {
    if (e is DioException) {
      _logger.e('DioError: ${e.message}');
      if (e.response != null) {
        _logger.e('Request URL: ${e.requestOptions.uri}');
        _logger.e('Request Method: ${e.requestOptions.method}');
        _logger.e('Request Headers: ${e.requestOptions.headers}');
        _logger.e('Request Body: ${e.requestOptions.data}');
        _logger.e('Status code: ${e.response?.statusCode}');
        _logger.e('Response Data: ${e.response?.data}');
      } else {
        _logger.e('Error sending request: ${e.message}');
        _logger.e('Request URL: ${e.requestOptions.uri}');
        _logger.e('Request Method: ${e.requestOptions.method}');
        _logger.e('Request Headers: ${e.requestOptions.headers}');
        _logger.e('Request Body: ${e.requestOptions.data}');
      }
    } else {
      _logger.e('Unexpected error: $e');
    }
    throw e;
  }
}
