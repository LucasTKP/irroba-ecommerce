import 'package:dio/dio.dart';

abstract class ProductsService {
  Future<Response<dynamic>> findAll();
}

class ProductsServiceImpl implements ProductsService {
  final Dio dio;

  ProductsServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findAll() async {
    final response = await dio.get('/products');
    return response;
  }
}
