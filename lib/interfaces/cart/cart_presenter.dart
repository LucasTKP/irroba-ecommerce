import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/controllers/cart_controller.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/cart/cart_screen.dart';
import 'package:irroba/interfaces/cart/cart_screen_controller.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class CartPresenter extends StatefulWidget {
  const CartPresenter({super.key});

  @override
  State<CartPresenter> createState() => _CartPresenterState();
}

class _CartPresenterState extends State<CartPresenter> {
  late ProductsRepository productsRepository;
  late CartController cartController;
  late SnackBarService snackBarService;
  late CartScreenController controller;

  @override
  void initState() {
    super.initState();
    productsRepository = Dependencies.instance.get<ProductsRepository>();
    cartController = Dependencies.instance.get<CartController>();
    snackBarService = Dependencies.instance.get<SnackBarService>();
    controller = CartScreenControllerImpl(
      productsRepository: productsRepository,
      cartController: cartController,
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
        title: const Text('Carrinho'),
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
        builder: (context, index) {
          if (controller.asyncState == AsyncState.loading) {
            return CustomCircularProgressIndicator.standard(color: theme?.primary ?? Colors.red);
          }

          if (controller.products.isEmpty) {
            return const Center(
              child: Text('Carrinho vazio'),
            );
          }

          if (controller.asyncState == AsyncState.successDeleteCart) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.of(context).pop();
              }
            });
          }

          return CartScreen(controller: controller, onSnackBarService: onSnackBarService);
        },
      ),
    );
  }

  void onSnackBarService({required String message, required Color color}) {
    snackBarService.showMessage(context: context, message: message, color: color);
  }
}
