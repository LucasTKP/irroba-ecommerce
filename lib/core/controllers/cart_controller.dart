import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/repositories/cart_repository.dart';
import 'dart:developer' as developer;

abstract class CartController extends ChangeNotifier {
  CartModel? cart;

  Future<void> getCart();
  Future<Response<dynamic>> delete(String idCart);
  Future<Response<dynamic>> update(CartModel updateCart);
  void setCart(CartModel cart);
}

class CartControllerImpl extends CartController {
  final CartRepository cartRepository;

  CartControllerImpl({required this.cartRepository}){
    getCart();
  }
  @override
  Future<void> getCart() async {
    try {
      final response = await cartRepository.findById("5");
      setCart(response);
    } catch (error) {
      developer.log(error.toString());
    }
  }

  @override
  Future<Response<dynamic>> delete(String idCart) async {
    return await cartRepository.delete(idCart);
  }

  @override
  Future<Response<dynamic>> update(CartModel updateCart) async {
    return await cartRepository.update(updateCart, updateCart.id);
  }

  @override
  void setCart(CartModel cart) {
    this.cart = cart;
    notifyListeners();
  }
}
