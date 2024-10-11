import 'package:dio/dio.dart';

abstract class CategoriesService {
  Future<Response<dynamic>> findAll();
}

class CategoriesServiceImpl implements CategoriesService {
  final Dio dio;

  CategoriesServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findAll() async {
    return await dio.get('/products/categories');
  }
}