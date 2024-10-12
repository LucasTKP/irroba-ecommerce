import 'package:flutter/material.dart';
import 'package:irroba/interfaces/stock/stock_controller.dart';
import 'package:irroba/interfaces/widgets/box_products.dart';

class StockScreen extends StatelessWidget {
  final StockController controller;
  const StockScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confira os dados dos produtos cadastrados',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              controller.products.length,
              (index) {
                return BoxProducts.stock(product: controller.products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
