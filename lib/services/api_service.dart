import 'package:currency_converter/services/api_provider.dart';
import 'package:currency_converter/services/dio_api_provider.dart';
import 'package:currency_converter/res/app_url.dart';

class ApiService implements ApiProvider {
  final ApiProvider provider;
  const ApiService(this.provider);

  factory ApiService.dio() => ApiService(DioApiProvider());

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) =>
      provider.get(AppUrl.baseUrl, params: params);
}
