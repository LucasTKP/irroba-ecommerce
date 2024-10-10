import 'package:dio/dio.dart';

class DioConfig {
  late Dio dio;

  DioConfig() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json; charset=utf-8',
      ),
    );
  }

  void dispose() {
    dio.close();
  }
}
