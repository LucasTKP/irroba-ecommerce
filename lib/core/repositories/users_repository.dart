import 'package:dio/dio.dart';
import 'package:irroba/core/services/users_service.dart';
import 'package:irroba/interfaces/register_user/register_user_dto.dart';

abstract class UsersRepository {
  // Future<List<ProductModel>> findAll();
  Future<Response<dynamic>> create(RegisterUserDto user);
}

class UsersRepositoryImpl extends UsersRepository {
  final UsersServiceImpl service;

  UsersRepositoryImpl({required this.service});

  // @override
  // Future<List<ProductModel>> findAll() async {
  //   final response = await service.findAll();
  //   final products = (response.data as List<dynamic>).map((product) => ProductModel.fromJson(product)).toList();
  //   return products;
  // }

  @override
  Future<Response<dynamic>> create(RegisterUserDto user) async {
    return await service.create(user.toJson());
  }
}


