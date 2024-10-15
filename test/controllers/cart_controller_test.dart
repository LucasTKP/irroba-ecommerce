import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:irroba/core/controllers/cart_controller.dart';
import 'package:irroba/core/models/cart_model.dart';

import 'mock/mock_cart_repository.dart';

void main() {
  late MockCartRepository cartRepository;
  late CartController controller;

  setUp(() {
    cartRepository = MockCartRepository();
    controller = CartControllerImpl(cartRepository: cartRepository);
  });

  test("getCart() sucess", () async {
    //Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onGetCartCalled = false;
    cartRepository.onFindById = (String idCart) async {
      onGetCartCalled = true;
      return CartModel(id: "5", userId: "5", date: "15/10/2024", products: []);
    };

    //Act
    await controller.getCart();

    //Assert
    expect(notifyListenerCalled, true);
    expect(onGetCartCalled, true);
    expect(controller.cart, isNotNull);
  });

  test("getCart() error", () async {
    //Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    bool onGetCartCalled = false;
    cartRepository.onFindById = (String idCart) async {
      onGetCartCalled = true;
      throw Error();
    };

    //Act
    await controller.getCart();

    //Assert
    expect(notifyListenerCalled, false);
    expect(onGetCartCalled, true);
    expect(controller.cart, isNull);
  });

  test("setCart() success", () {
    //Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });

    //Act
    controller.setCart(CartModel(id: "5", userId: "5", date: "15/10/2024", products: []));

    //Assert
    expect(notifyListenerCalled, true);
    expect(controller.cart, isNotNull);
  });

  test("setCart() error", () {
    //Arrange
    bool notifyListenerCalled = false;
    controller.addListener(() {
      notifyListenerCalled = true;
    });
    const car = null;
    //Act
    try{
      controller.setCart(car);
    } catch (e) {
      log(e.toString());
    }
    //Assert
    expect(notifyListenerCalled, false);
    expect(controller.cart, isNull);
  });
}
