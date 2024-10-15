import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/interfaces/cart/cart_screen_controller.dart';
import 'package:irroba/interfaces/cart/widgets/box_product_cart.dart';
import 'package:irroba/interfaces/cart/widgets/clear_confirmation_dialog.dart';
import 'package:irroba/interfaces/cart/widgets/remove_product_confirm_dialog.dart';

class CartScreen extends StatelessWidget {
  final CartScreenController controller;
  final Function({required String message, required Color color}) onSnackBarService;
  const CartScreen({super.key, required this.controller, required this.onSnackBarService});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sacola',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  showClearConfirmationDialog(context, controller);
                },
                style: ElevatedButton.styleFrom(backgroundColor: theme?.secondary ?? Colors.grey, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), minimumSize: const Size(0, 0)),
                child: const Text('Limpar', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: List.generate(
                controller.products.length,
                (index) {
                  final product = controller.products[index];
                  return BoxProductCart(
                    product: product,
                    quantity: controller.products[index].quantity,
                    onAddQuatity: () => controller.addQuatity(index),
                    onRemoveQuantity: () {
                      if (controller.products[index].quantity == 1) {
                        return showRemoveProductConfirmDialog(context, controller, product);
                      }
                      controller.removeQuantity(index);
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total: ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                controller.getTotal(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSnackBarService(message: 'Compra realizada com sucesso', color: Colors.green);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme?.primary ?? Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Continuar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
