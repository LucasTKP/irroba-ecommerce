import 'package:flutter/material.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/category.dart';
import 'package:irroba/core/repositories/categories_repository.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/identify_error.dart';
import 'package:irroba/interfaces/register_product/dto/register_product_dto.dart';

abstract class RegisterProductController extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AsyncState asyncState = AsyncState.initial;
  List<CategoryModel> categories = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController urlImageController = TextEditingController();
  CategoryModel? selectedCategory;

  Future<void> getAllCategories();
  Future<void> saveProduct();
  void clearFields();

  void setSelectedCategory(CategoryModel? category);
  void setState(AsyncState state);
}

class RegisterProductControllerImpl extends RegisterProductController {
  final ProductsRepository productsRepository;
  final CategoriesRepository categoriesRepository;
  final Function(String message, Color color) onSnackBarService;

  RegisterProductControllerImpl({
    required this.productsRepository,
    required this.categoriesRepository,
    required this.onSnackBarService,
  }) {
    getAllCategories();
  }

  @override
  Future<void> getAllCategories() async {
    try {
      setState(AsyncState.loading);
      final response = await categoriesRepository.findAll();
      categories = response;
      setState(AsyncState.success);
    } catch (error) {
      onSnackBarService(identifyError(error: error, message: 'Erro ao buscar categorias'), Colors.red);
      setState(AsyncState.error);
    }
  }

  @override
  Future<void> saveProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(AsyncState.loading);
        final product = RegisterProductDto(
          title: titleController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          image: urlImageController.text,
          category: selectedCategory!,
        );
        final response = await productsRepository.create(product);
        if (response.statusCode == 200) {
          onSnackBarService('Produto registrado com sucesso', Colors.green);
          clearFields();
        }
      } catch (error) {
        onSnackBarService(identifyError(error: error, message: 'Erro ao registrar o produto'), Colors.red);
      }
      setState(AsyncState.initial);
    }
  }

  @override
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    urlImageController.clear();
    setSelectedCategory(null);
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }

  @override
  void setSelectedCategory(CategoryModel? category) {
    selectedCategory = category;
    notifyListeners();
  }
}
