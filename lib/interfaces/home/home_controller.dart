import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/identify_error.dart';

abstract class HomeController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<ProductModel> products = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getAllProducts();

  void setProducts(List<ProductModel> products);
  void setState(AsyncState state);
}

class HomeControllerImpl extends HomeController {
  final ProductsRepository productsRepository;
  final Function(String message, Color color) onSnackBarService;
  HomeControllerImpl({required this.productsRepository, required this.onSnackBarService}) {
    getAllProducts();
  }

  @override
  Future<void> getAllProducts() async {
    try {
      setState(AsyncState.loading);
      final response = await productsRepository.findAll();
      setProducts(response);
      setState(AsyncState.initial);
    } catch (error) {
      log(error.toString());
      onSnackBarService(identifyError(error: error, message: 'Erro ao buscar produtos'), Colors.red);
      setState(AsyncState.error);
    }
  }

  @override
  void setProducts(List<ProductModel> products) {
    this.products = products;
    notifyListeners();
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }
}
