import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/injections/dependencies.dart';
import 'package:irroba/core/models/async_state.dart';
import 'package:irroba/core/repositories/products_repository.dart';
import 'package:irroba/core/utils/snack_bar_service.dart';
import 'package:irroba/interfaces/home/home_controller.dart';
import 'package:irroba/interfaces/home/home_screen.dart';
import 'package:irroba/interfaces/widgets/circular_progress_indicator.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> {
  late SnackBarService snackBarService;
  late HomeControllerImpl controller;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
    snackBarService = SnackBarServiceImpl();
    controller = HomeControllerImpl(productsRepository: Dependencies.instance.get<ProductsRepository>(), onSnackBarService: onSnackBarService);
    // Future.delayed(const Duration(seconds: 3), () {
    //   FlutterNativeSplash.remove();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png'),
        titleSpacing: 20,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.asyncState == AsyncState.loading) {
            return CustomCircularProgressIndicator.standard(color: theme?.primary ?? Colors.red);
          }

          if (controller.asyncState == AsyncState.success) {}
          return HomeScreen(
            controller: controller,
          );
        },
      ),
    );
  }

  void onSnackBarService(String message, Color color) {
    snackBarService.showMessage(context: context, message: message, color: Colors.red);
  }
}
