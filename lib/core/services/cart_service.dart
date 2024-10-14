import 'package:dio/dio.dart';

abstract class CartService {
  Future<Response<dynamic>> findById(String idCart);
}

class CartServiceImpl extends CartService {
  final Dio dio;

  CartServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findById(String idCart) async {
    return await dio.get('/carts/$idCart');
  }
}