import 'package:dio/src/response.dart';
import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/repositories/cart_repository.dart';

class MockCartRepository extends CartRepository {
  @override
  Future<Response> delete(String idCart) => onDelete(idCart);
  Future<Response> Function(String idCart) onDelete = (idCart) => throw UnimplementedError();

  @override
  Future<CartModel> findById(String idCart) => onFindById(idCart);
  Future<CartModel> Function(String idCart) onFindById = (idCart) => throw UnimplementedError();

  @override
  Future<Response> update(CartModel cart, String idCart) => onUpdate(cart, idCart);
  Future<Response> Function(CartModel cart, String idCart) onUpdate = (cart, idCart) => throw UnimplementedError();
}
