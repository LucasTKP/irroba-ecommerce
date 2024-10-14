import 'package:dio/dio.dart';

abstract class UsersService {
  Future<Response<dynamic>> findAll();
  Future<Response<dynamic>> create(Map<String, dynamic> user);
  Future<Response<dynamic>> delete(String idUser);
  Future<Response<dynamic>> update(String idUser, Map<String, dynamic> user);
}

class UsersServiceImpl extends UsersService {
  final Dio dio;
  UsersServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> findAll() async {
    return await dio.get('/users');
  }

  @override
  Future<Response<dynamic>> create(Map<String, dynamic> user) async {
    return await dio.post('/users', data: user);
  }

  @override
  Future<Response<dynamic>> delete(idUser) async {
    return await dio.delete('/users/$idUser');
  }

  @override
  Future<Response<dynamic>> update(idUser, Map<String, dynamic> user) async {
    return await dio.put('/users/$idUser', data: user);
  }
}
