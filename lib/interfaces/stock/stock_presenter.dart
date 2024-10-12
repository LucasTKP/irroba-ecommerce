import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/stock/stock_controller.dart';
import 'package:irroba/interfaces/stock/stock_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class StockPresenter extends StatefulWidget {
  const StockPresenter({super.key});

  @override
  State<StockPresenter> createState() => _StockPresenterState();
}

class _StockPresenterState extends State<StockPresenter> {
  late StockController controller;
  late SnackBarService snackBarService;

  @override
  void initState() {
    super.initState();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    controller = StockControllerImpl(onSnackBarService: onSnackBarService, productsRepository: Dependencies.instance.get<ProductsRepository>());
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
        title: const Text('Estoque'),
        titleSpacing: 20,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.asyncState == AsyncState.loading) {
            return CustomCircularProgressIndicator.standard(
              color: theme?.primary ?? Colors.red,
            );
          }
          return StockScreen(controller: controller);
        },
      ),
    );
  }

  void onSnackBarService(String message, Color color) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
