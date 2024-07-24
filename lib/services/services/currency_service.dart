import 'package:currency_converter/res/app_url.dart';
import 'package:currency_converter/services/api_service.dart';

class CurrencyService {
  final ApiService _apiService;

  CurrencyService() : _apiService = ApiService.dio();

  Future<dynamic> getCurrencyData() async {
    return _apiService.get(AppUrl.baseUrl);
  }
}
