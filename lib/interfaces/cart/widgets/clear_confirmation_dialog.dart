import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/interfaces/cart/cart_screen_controller.dart';

void showClearConfirmationDialog(BuildContext context, CartScreenController controller) {
  final theme = Theme.of(context).extension<CustomTheme>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Limpar Sacola', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        content: const Text('Você tem certeza que deseja remover todos os pedidos da sacola?', style: TextStyle(fontSize: 18)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        actions: <Widget>[
          Column(
            children: [
              SizedBox(
                width: double.infinity, 
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await controller.deleteCart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme?.primary ?? Colors.red,
                  ),
                  child: const Text('Limpar', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme?.secondary ?? Colors.grey,
                  ),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
