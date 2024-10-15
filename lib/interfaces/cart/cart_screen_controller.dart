import 'package:flutter/material.dart';
import 'package:irroba/core/controllers/cart_controller.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/cart_model.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'dart:developer' as developer;

abstract class CartScreenController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<ProductModel> products = [];

  String getTotal();
  Future<void> deleteCart();
  void addQuatity(int indexProduct);
  void removeQuantity(int indexProduct);
  Future<void> removeProductCart(ProductModel productRemove);

  Future<void> updateCart(CartModel cartUpdate);

  void setProducts(List<ProductModel> products);
  void setAsyncState(AsyncState asyncState);
}

class CartScreenControllerImpl extends CartScreenController {
  final ProductsRepository productsRepository;
  final CartController cartController;
  final Function({required String message, required Color color}) onSnackBarService;

  CartScreenControllerImpl({
    required this.productsRepository,
    required this.cartController,
    required this.onSnackBarService,
  }) {
    products = List.from(cartController.cart!.products);
  }

  @override
  Future<void> updateCart(CartModel cartUpdate) async {
    try {
      setAsyncState(AsyncState.loading);
      final response = await cartController.update(cartUpdate);
      if (response.statusCode == 200) {
        onSnackBarService(message: 'Produto removido com sucesso', color: Colors.green);
      }
    } catch (error) {
      developer.log(error.toString());
      onSnackBarService(message: 'Erro ao atualizar carrinho', color: Colors.red);
    } finally {
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  Future<void> deleteCart() async {
    try {
      setAsyncState(AsyncState.loading);
      final response = await cartController.delete("5");
      if (response.statusCode == 200) {
        onSnackBarService(message: 'Carrinho deletado com sucesso', color: Colors.green);
        setAsyncState(AsyncState.successDeleteCart);
      }
    } catch (error) {
      developer.log(error.toString());
      onSnackBarService(message: 'Erro ao deletar carrinho', color: Colors.red);
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  void addQuatity(int indexProduct) {
    products[indexProduct] = products[indexProduct].copyWith(quantity: products[indexProduct].quantity + 1);
    setProducts(products);
  }

  @override
  void removeQuantity(int indexProduct) {
    products[indexProduct] = products[indexProduct].copyWith(quantity: products[indexProduct].quantity - 1);
    setProducts(products);
  }

  @override
  Future<void> removeProductCart(ProductModel productRemove) async {
    try {
      setAsyncState(AsyncState.loading);
      products.remove(productRemove);
      setProducts(products);
      CartModel? cartUpdate = cartController.cart;
      await cartController.update(CartModel.fromCartModel(cartUpdate!, products));
    } catch (error) {
      developer.log(error.toString());
      onSnackBarService(message: 'Erro ao atualizar carrinho', color: Colors.red);
    } finally {
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  String getTotal() {
    double total = 0;
    for (final productCart in products) {
      total += productCart.price * productCart.quantity;
    }
    return "R\$  ${total.toStringAsFixed(2).replaceAll('.', ',')}";
  }

  @override
  void setProducts(List<ProductModel> products) {
    this.products = products;
    notifyListeners();
  }

  @override
  void setAsyncState(AsyncState asyncState) {
    this.asyncState = asyncState;
    notifyListeners();
  }
}
