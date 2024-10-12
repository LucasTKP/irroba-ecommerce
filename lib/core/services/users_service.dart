import 'package:dio/dio.dart';

abstract class UsersService {
  Future<Response<dynamic>> create(Map<String, dynamic> product);
}

class UsersServiceImpl extends UsersService {
  final Dio dio;
  UsersServiceImpl({required this.dio});

  @override
  Future<Response<dynamic>> create(Map<String, dynamic> product) async {
    return await dio.post('/users', data: product);
  }
}
