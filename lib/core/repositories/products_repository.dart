import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/services/products_service.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAll();
}

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsServiceImpl service;

  ProductsRepositoryImpl({required this.service});

  @override
  Future<List<ProductModel>> findAll() async {
    final response = await service.findAll();
    final products = (response.data as List<dynamic>).map((product) => ProductModel.fromJson(product)).toList();
    return products;
  }
}
