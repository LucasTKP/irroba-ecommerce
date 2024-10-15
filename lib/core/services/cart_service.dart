import 'package:dio/dio.dart';

abstract class CartService {
  Future<Response<dynamic>> findById(String idCart);
  Future<Response<dynamic>> delete(String idCart);
  Future<Response<dynamic>> update(Map<String, dynamic> cart, String idCart);
}

class CartServiceImpl extends CartService {
  final Dio dio;

  CartServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findById(String idCart) async {
    return await dio.get('/carts/$idCart');
  }

  @override
  Future<Response<dynamic>> delete(String idCart) async {
    return await dio.delete('/carts/$idCart');
  }

  @override
  Future<Response<dynamic>> update(Map<String, dynamic> cart, String idCart) async {
    return await dio.put('/carts/$idCart', data: cart);
  }
}