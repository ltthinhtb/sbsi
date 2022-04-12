import 'package:dio/dio.dart';
import 'package:sbsi/configs/app_configs.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio(BaseOptions(
          baseUrl: AppConfigs.baseUrl,
          receiveTimeout: 2 * 60 * 1000,
          connectTimeout: 2 * 60 * 1000,
          contentType: "application/json"));
      dio!.options.connectTimeout = 60000;
      dio!.interceptors.add(ApiInterceptors());
    }
    return dio!;
  }

  static ApiClient getApiClient() {
    final apiClient = ApiClient(getDio(), baseUrl: AppConfigs.baseUrl);
    return apiClient;
  }
}
