import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/categories_repository.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/register_product/register_product_controller.dart';
import 'package:irroba/interfaces/register_product/register_product_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class RegisterProductPresenter extends StatefulWidget {
  const RegisterProductPresenter({super.key});

  @override
  State<RegisterProductPresenter> createState() => _RegisterProductPresenterState();
}

class _RegisterProductPresenterState extends State<RegisterProductPresenter> {
  late RegisterProductControllerImpl controller;
  late SnackBarService snackBarService;

  @override
  void initState() {
    super.initState();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    controller = RegisterProductControllerImpl(
      productsRepository: Dependencies.instance.get<ProductsRepository>(),
      categoriesRepository: Dependencies.instance.get<CategoriesRepository>(),
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
        title: const Text('Cadastrar produto'),
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
            return CustomCircularProgressIndicator.standard(color: theme?.primary ?? Colors.red);
          }
          return RegisterProductScreen(
            controller: controller,
          );
        },
      ),
    );
  }

  void onSnackBarService(String message, Color color) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
