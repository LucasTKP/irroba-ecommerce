import 'package:dio/dio.dart';
import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/services/cart_service.dart';

abstract class CartRepository {
  Future<CartModel> findById(String idCart);
  Future<Response<dynamic>> delete(String idCart);
  Future<Response<dynamic>> update(CartModel cart, String idCart);
}

class CartRepositoryImpl implements CartRepository {
  final CartService service;
  final ProductsRepository productsRepository;

  CartRepositoryImpl({required this.service, required this.productsRepository});

  @override
  Future<CartModel> findById(String idCart) async {
    final response = await service.findById(idCart);
    final List<ProductModel> productsCartList = [];

    for (var product in response.data['products']) {
      final productResponse = await productsRepository.findById(product['productId'].toString());
      productsCartList.add(productResponse.copyWith(quantity: product['quantity']));
    }

    return CartModel.fromJson(response.data, productsCartList);
  }

  @override
  Future<Response<dynamic>> delete(String idCart) async {
    return await service.delete(idCart);
  }

  @override
  Future<Response<dynamic>> update(CartModel cart, String idCart) async {
    return await service.update(cart.toJson(), idCart);
  }
}
