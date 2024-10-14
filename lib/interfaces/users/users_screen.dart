import 'package:flutter/material.dart';
import 'package:irroba/core/models/user.dart';
import 'package:irroba/interfaces/edit_user/edit_user_presenter.dart';
import 'package:irroba/interfaces/users/users_controller.dart';
import 'package:irroba/interfaces/widgets/box_user.dart';

class UsersScreen extends StatelessWidget {
  final UsersController controller;
  const UsersScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confira os dados dos usuários cadastrados',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              controller.users.length,
              (index) {
                return BoxUser.standard(
                  user: controller.users[index],
                  onDeleteUser: (UserModel user) {
                    showDeleteConfirmationDialog(context, user);
                  },
                  onEditUser: (UserModel user) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditUserPresenter(user: user),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content: Text('Tem certeza de que deseja excluir o usuário ${user.username}?', style: const TextStyle(fontSize: 18)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                controller.deleteUser(user.id);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text('Excluir', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
