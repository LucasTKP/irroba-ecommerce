import 'package:flutter/material.dart';
import 'package:irroba/core/libs/dio_config.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/services/products_service.dart';

class Dependencies {
  static Dependencies? _instance;

  static Dependencies get instance => _instance ??= Dependencies._();

  Dependencies._();

  final Map<Type, dynamic> _objects = {};

  bool contains<T>() => _objects.containsKey(T);

  void add<T>(T instance) => contains<T>() ? throw Exception('Class ${T.runtimeType} already registered!') : _objects[T] = instance;

  T get<T>() => contains<T>() ? _objects[T] : throw Exception('Class ${T.runtimeType} not registered!');

  void remove<T>() => _objects.remove(T);

  void clear() => _objects.clear();
}

Future<bool> setupDependencies(BuildContext context) async {
  final dioConfig = DioConfig();
  Dependencies.instance.add<DioConfig>(dioConfig);

  final productsService = ProductsServiceImpl(dio: dioConfig.dio);
  Dependencies.instance.add<ProductsService>(productsService);

  Dependencies.instance.add<ProductsRepository>(ProductsRepositoryImpl(service: productsService));

  return true;
}
