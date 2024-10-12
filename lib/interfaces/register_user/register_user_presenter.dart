import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/users_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/register_user/register_user_controller.dart';
import 'package:irroba/interfaces/register_user/register_user_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class RegisterUserPresenter extends StatefulWidget {
  const RegisterUserPresenter({super.key});

  @override
  State<RegisterUserPresenter> createState() => _RegisterUserPresenterState();
}

class _RegisterUserPresenterState extends State<RegisterUserPresenter> {
  late RegisterUserController controller;
  late SnackBarService snackBarService;

  @override
  void initState() {
    super.initState();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    controller = RegisterUserImpl(
      usersRepository: Dependencies.instance.get<UsersRepository>(),
      onSnackBarService: onSnackBarService,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
        titleSpacing: 20,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (controller.step == 2) {
              controller.setStep(1);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return PopScope(
            canPop: controller.step == 1,
            onPopInvokedWithResult: (popDisposition, result) async {
              if (controller.step == 2) {
                controller.setStep(1);
              }
            },
            child: controller.asyncState == AsyncState.loading
                ? CustomCircularProgressIndicator.standard(
                    color: theme?.primary ?? Colors.red,
                  )
                : RegisterUserScreen(
                    controller: controller,
                  ),
          );
        },
      ),
    );
  }

  void onSnackBarService(String message, Color color) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
