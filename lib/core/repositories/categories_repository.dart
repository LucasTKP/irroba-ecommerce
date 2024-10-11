import 'package:irroba/core/models/category.dart';
import 'package:irroba/core/services/categories_service.dart';

abstract class CategoriesRepository {
  Future<List<CategoryModel>> findAll();
}

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesService service;

  CategoriesRepositoryImpl({required this.service});

  @override
  Future<List<CategoryModel>> findAll() async {
    final response = await service.findAll();
    final categories = (response.data as List<dynamic>).map((category) => CategoryModel.fromJson(category)).toList();
    return categories;
  }
}
