import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/users_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/users/users_controller.dart';
import 'package:irroba/interfaces/users/users_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class UsersPresenter extends StatefulWidget {
  const UsersPresenter({super.key});

  @override
  State<UsersPresenter> createState() => _UsersPresenterState();
}

class _UsersPresenterState extends State<UsersPresenter> {
  late SnackBarService snackBarService;
  late UsersRepository usersRepository;
  late UsersController controller;

  @override
  void initState() {
    super.initState();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    usersRepository = Dependencies.instance.get<UsersRepository>();
    controller = UsersControllerImpl(onSnackBarService: onSnackBarService, usersRepository: usersRepository);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        titleSpacing: 20,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.asyncState == AsyncState.loading) {
            return CustomCircularProgressIndicator.standard(color: theme.primary);
          }
          return UsersScreen(controller: controller);
        },
      ),
    );
  }

  void onSnackBarService({required String message, required Color color}) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
