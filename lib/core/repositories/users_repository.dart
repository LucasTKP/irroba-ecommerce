import 'package:dio/dio.dart';
import 'package:irroba/core/models/user.dart';
import 'package:irroba/core/services/users_service.dart';
import 'package:irroba/interfaces/edit_user/edit_user_dto.dart';
import 'package:irroba/interfaces/register_user/register_user_dto.dart';

abstract class UsersRepository {
  Future <List<UserModel>> findAll();
  Future<Response<dynamic>> create(RegisterUserDto user);
  Future<Response<dynamic>> delete(String idUser);
  Future<Response<dynamic>> update(EditUserDto user, String idUser);
}

class UsersRepositoryImpl extends UsersRepository {
  final UsersServiceImpl service;

  UsersRepositoryImpl({required this.service});

  @override
  Future<List<UserModel>> findAll() async {
    final response = await service.findAll();
    final users = (response.data as List<dynamic>).map((user) => UserModel.fromJson(user)).toList();
    return users;
  }

  @override
  Future<Response<dynamic>> create(RegisterUserDto user) async {
    return await service.create(user.toJson());
  }

  @override
  Future<Response<dynamic>> delete(String idUser) async {
    return await service.delete(idUser);
  }

  @override
  Future<Response<dynamic>> update(EditUserDto user, String idUser) async {
    return await service.update(idUser, user.toJson());
  }
}


