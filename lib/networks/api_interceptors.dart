import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/utils/logger.dart';
import 'package:get/get.dart' hide Response;

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;

    if (!options.path.contains("getchartindexdata")) {
      logger.log(
          "\n\n--------------------------------------------------------------------------------------------------------");
      if (method == 'GET') {
        logger.d(
            "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers}");
      } else {
        try {
          logger.d(
              "✈️ REQUEST[$method] => PATH: $uri \n DATA: ${jsonEncode(data)}");
        } catch (e) {
          logger.i("✈️ REQUEST[$method] => PATH: $uri \n DATA: $data");
        }
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = (response.data);
    if (!uri.toString().contains("getchartindexdata")) {
      logger.d("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    }

    //Handle section expired
    if (response.statusCode == 401) {
      final authService = Get.find<AuthService>();
      authService.signOut();
      Get.offAllNamed(RouteConfig.login);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.path;
    var data = "";
    try {
      data = jsonEncode(err.response?.data);
    } catch (e) {
      logger.e(e.toString());
    }
    logger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
    super.onError(err, handler);
  }
}
