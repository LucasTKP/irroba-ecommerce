import 'package:flutter/material.dart';
import 'package:irroba/core/controllers/cart_controller.dart';
import 'package:irroba/core/libs/dio_config.dart';
import 'package:irroba/core/repositories/cart_repository.dart';
import 'package:irroba/core/repositories/categories_repository.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/repositories/users_repository.dart';
import 'package:irroba/core/services/cart_service.dart';
import 'package:irroba/core/services/categories_service.dart';
import 'package:irroba/core/services/products_service.dart';
import 'package:irroba/core/services/users_service.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';

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
  Dependencies.instance.add<SnackBarService>(SnackBarServiceImpl());

  final dioConfig = DioConfig();
  Dependencies.instance.add<DioConfig>(dioConfig);

  final productsService = ProductsServiceImpl(dio: dioConfig.dio);
  Dependencies.instance.add<ProductsService>(productsService);

  Dependencies.instance.add<ProductsRepository>(ProductsRepositoryImpl(service: productsService));

  final categoriesService = CategoriesServiceImpl(dio: dioConfig.dio);
  Dependencies.instance.add<CategoriesService>(categoriesService);

  Dependencies.instance.add<CategoriesRepository>(CategoriesRepositoryImpl(service: categoriesService));

  final userService = UsersServiceImpl(dio: dioConfig.dio);
  Dependencies.instance.add<UsersService>(userService);

  Dependencies.instance.add<UsersRepository>(UsersRepositoryImpl(service: userService));

  final cartService = CartServiceImpl(dio: dioConfig.dio);
  final cartRepository = CartRepositoryImpl(service: cartService, productsRepository: Dependencies.instance.get<ProductsRepository>());
  final cartController = CartControllerImpl(cartRepository: cartRepository);
  Dependencies.instance.add<CartController>(cartController);

  return true;
}
