import 'package:dio/dio.dart';
import 'package:irroba/core/models/product.dart';
import 'package:irroba/core/services/products_service.dart';
import 'package:irroba/interfaces/register_product/register_product_dto.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAll({bool sort});
  Future<Response<dynamic>> create(RegisterProductDto product);
}

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsServiceImpl service;

  ProductsRepositoryImpl({required this.service});

  @override
  Future<List<ProductModel>> findAll({bool sort = false}) async {
    final response = await service.findAll();
    List<ProductModel> products = (response.data as List<dynamic>).map((product) => ProductModel.fromJson(product)).toList();
    if (sort) {
      products.sort((a, b) => a.title.compareTo(b.title));
    }
    return products;
  }

  @override
  Future<Response<dynamic>> create(RegisterProductDto product) async {
    return await service.create(product.toJson());
  }
}


