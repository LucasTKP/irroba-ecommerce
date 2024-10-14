import 'package:flutter/material.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/user.dart';
import 'dart:developer' as developer;

import 'package:irroba/core/repositories/users_repository.dart';

abstract class UsersController extends ChangeNotifier {
  AsyncState asyncState = AsyncState.initial;
  List<UserModel> users = [];

  void getAllUsers();
  void deleteUser(String idUser);

  void setUsers(List<UserModel> users);
  void setState(AsyncState state);
}

class UsersControllerImpl extends UsersController {
  final UsersRepository usersRepository;
  final Function({required String message, required Color color}) onSnackBarService;

  UsersControllerImpl({required this.usersRepository, required this.onSnackBarService}) {
    getAllUsers();
  }

  @override
  Future<void> getAllUsers() async {
    try {
      setState(AsyncState.loading);
      final response = await usersRepository.findAll();
      setUsers(response);
    } catch (error) {
      onSnackBarService(message: 'Erro ao buscar usuários', color: Colors.red);
      developer.log(error.toString());
    } finally {
      setState(AsyncState.initial);
    }
  }

  @override
  Future<void> deleteUser(String idUser) async {
    try {
      setState(AsyncState.loading);
      await usersRepository.delete(idUser);
      onSnackBarService(message: 'Usuário deletado com sucesso', color: Colors.green);
    } catch (error) {
      onSnackBarService(message: 'Erro ao deletar usuário', color: Colors.red);
      developer.log(error.toString());
    } finally {
      setState(AsyncState.initial);
    }
  }

  @override
  void setUsers(List<UserModel> users) {
    this.users = users;
    notifyListeners();
  }

  @override
  void setState(AsyncState state) {
    asyncState = state;
    notifyListeners();
  }
}
