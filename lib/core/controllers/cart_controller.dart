import 'package:flutter/material.dart';
import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/repositories/cart_repository.dart';
import 'dart:developer' as developer;

abstract class CartController extends ChangeNotifier {
  CartModel? cart;

  void getCart();

  void setCart(CartModel cart);
}

class CartControllerImpl extends CartController {
  final CartRepositoryImpl cartRepository;

  CartControllerImpl({required this.cartRepository}) {
    getCart();
  }

  @override
  void getCart() async {
    try {
      final response = await cartRepository.findById("5");
      setCart(response);
    } catch (error) {
      developer.log(error.toString());
    }
  }

  @override
  void setCart(CartModel cart) {
    this.cart = cart;
  }
}
