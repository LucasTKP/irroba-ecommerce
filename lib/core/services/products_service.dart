import 'package:dio/dio.dart';

abstract class ProductsService {
  Future<Response<dynamic>> findAll();
  Future<Response<dynamic>> create(Map<String, dynamic> product);
}

class ProductsServiceImpl implements ProductsService {
  final Dio dio;

  ProductsServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findAll() async {
    final response = await dio.get('/products');
    return response;
  }

  @override
  Future<Response<dynamic>> create(Map<String, dynamic> product) async {
    return await dio.post('/products', data: product);
  }
}
