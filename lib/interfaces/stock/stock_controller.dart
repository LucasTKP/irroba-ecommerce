import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/identify_error.dart';

abstract class StockController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<ProductModel> products = [];

  void getAllProducts();
  void setState(AsyncState state);
}

class StockControllerImpl extends StockController {
  final ProductsRepository productsRepository;
  final Function(String message, Color color) onSnackBarService;
  StockControllerImpl({required this.productsRepository, required this.onSnackBarService}) {
    getAllProducts();
  }

  @override
  void getAllProducts() async {
    try {
      setState(AsyncState.loading);
      final response = await productsRepository.findAll();
      products = response;
    } catch (error) {
      log(error.toString());
      onSnackBarService(identifyError(error: error, message: 'Erro ao buscar os produtos'), Colors.red);
    } finally {
      setState(AsyncState.initial);
    }
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }
}
