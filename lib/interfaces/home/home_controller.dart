import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/category.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/repositories/categories_repository.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/identify_error.dart';

abstract class HomeController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  TextEditingController searchController = TextEditingController();
  CategoryModel? selectedCategory;

  void init();
  Future<void> getAllProducts();
  Future<void> getAllCategories();
  List<ProductModel> filterProducts();
  void onTapSearch();

  void setProducts(List<ProductModel> products);
  void setCategories(List<CategoryModel> categories);
  void setState(AsyncState state);
  void setSelectedCategory(CategoryModel? category);
}

class HomeControllerImpl extends HomeController {
  final ProductsRepository productsRepository;
  final CategoriesRepository categoriesRepository;
  final Function(String message, Color color) onSnackBarService;
  HomeControllerImpl({required this.productsRepository, required this.onSnackBarService, required this.categoriesRepository}) {
    init();
  }

  @override
  void init() async {
    setState(AsyncState.loading);
    await getAllProducts();
    await getAllCategories();
    setState(AsyncState.initial);
  }

  @override
  Future<void> getAllProducts() async {
    try {
      final response = await productsRepository.findAll();
      setProducts(response);
    } catch (error) {
      log(error.toString());
      onSnackBarService(identifyError(error: error, message: 'Erro ao buscar produtos'), Colors.red);
    }
  }

  @override
  Future<void> getAllCategories() async {
    try {
      final response = await categoriesRepository.findAll();
      response.insert(0, CategoryModel(name: 'Todos'));
      selectedCategory = response.first;
      setCategories(response);
    } catch (error) {
      log(error.toString());
      onSnackBarService(identifyError(error: error, message: 'Erro ao buscar categorias'), Colors.red);
    }
  }

  @override
  List<ProductModel> filterProducts() {
    List<ProductModel> productsFiltered = products;
    if (searchController.text.isNotEmpty) {
      productsFiltered = products.where((product) => product.title.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }

    if (selectedCategory != null && selectedCategory?.name != 'Todos') {
      productsFiltered = productsFiltered.where((product) => product.category == selectedCategory?.name).toList();
    }

    return productsFiltered;
  }

  @override
  void onTapSearch() {
    notifyListeners();
  }

  @override
  void setProducts(List<ProductModel> products) {
    this.products = products;
    notifyListeners();
  }

  @override
  void setCategories(List<CategoryModel> categories) {
    this.categories = categories;
    notifyListeners();
  }

  @override
  void setSelectedCategory(CategoryModel? category) {
    selectedCategory = category;
    notifyListeners();
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }
}
