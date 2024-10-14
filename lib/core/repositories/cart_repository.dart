import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/services/cart_service.dart';

abstract class CartRepository {
  Future<CartModel> findById(String idCart);
}

class CartRepositoryImpl implements CartRepository {
  final CartService service;

  CartRepositoryImpl({required this.service});

  @override
  Future<CartModel> findById(String idCart) async {
    final response = await service.findById(idCart);
    return CartModel.fromJson(response.data);
  }
}
