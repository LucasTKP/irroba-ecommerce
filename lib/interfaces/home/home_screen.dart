import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/models/category.dart';
import 'package:irroba/interfaces/home/home_controller.dart';
import 'package:irroba/interfaces/menu/menu.dart';
import 'package:irroba/interfaces/widgets/box_products.dart';
import 'package:irroba/interfaces/widgets/inputs.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    final products = controller.filterProducts();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: theme?.primary ?? Colors.red,
            padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: CustomInputs.search(
                  prefixIcon: IconButton(
                    onPressed: () {
                      controller.onTapSearch();
                    },
                    icon: const Icon(Icons.search),
                  ),
                  label: 'Pesquisar Produto',
                  controller: controller.searchController,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Day2Day',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<CategoryModel>(
                  isExpanded: true,
                  hint: const Text('Selecione uma categoria'),
                  value: controller.selectedCategory,
                  items: controller.categories.map<DropdownMenuItem<CategoryModel>>((CategoryModel category) {
                    return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (CategoryModel? category) {
                    controller.setSelectedCategory(category);
                  },
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 330,
                  ),
                  padding: EdgeInsets.zero,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return BoxProducts.standard(
                      imageUrl: product.image,
                      title: product.title,
                      price: product.price,
                      onAdd: () {},
                      backgroundButton: theme?.primary ?? Colors.red,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
