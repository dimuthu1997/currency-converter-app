abstract class ApiProvider {
  Future<dynamic> get(String url, {Map<String, dynamic>? params});
}
