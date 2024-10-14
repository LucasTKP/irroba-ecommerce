import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/models/user.dart';
import 'package:irroba/core/repositories/users_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/edit_user/edit_user_controller.dart';
import 'package:irroba/interfaces/edit_user/edit_user_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class EditUserPresenter extends StatefulWidget {
  final UserModel user;
  const EditUserPresenter({super.key, required this.user});

  @override
  State<EditUserPresenter> createState() => _EditUserPresenterState();
}

class _EditUserPresenterState extends State<EditUserPresenter> {
  late EditUserController controller;
  late SnackBarService snackBarService;

  @override
  void initState() {
    super.initState();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    controller = EditUserImpl(
      usersRepository: Dependencies.instance.get<UsersRepository>(),
      onSnackBarService: onSnackBarService,
      user: widget.user,
      sucessSave: sucessSave,
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
        title: const Text('Editar Usuário'),
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
          if (controller.asyncState == AsyncState.loading) {
            return CustomCircularProgressIndicator.standard(color: theme?.primary ?? Colors.red);
          }

          return PopScope(
            canPop: controller.step == 1,
            onPopInvokedWithResult: (popDisposition, result) async {
              if (controller.step == 2) {
                controller.setStep(1);
              }
            },
            child: EditUserScreen(
              controller: controller,
            ),
          );
        },
      ),
    );
  }

  void sucessSave() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void onSnackBarService(String message, Color color) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
