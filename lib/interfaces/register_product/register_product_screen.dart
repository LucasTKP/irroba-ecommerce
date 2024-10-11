import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/core/models/category.dart';
import 'package:irroba/interfaces/register_product/register_product_controller.dart';
import 'package:irroba/interfaces/widgets/inputs.dart';

class RegisterProductScreen extends StatelessWidget {
  final RegisterProductControllerImpl controller;
  const RegisterProductScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const Text(
              'Insira as informações do produto nos campos abaixo.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomInputs.standard(
              theme: Colors.black,
              controller: controller.titleController,
              label: 'Nome',
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.title),
            ),
            const SizedBox(height: 20),
            CustomInputs.standard(
              theme: Colors.black,
              controller: controller.descriptionController,
              label: 'Descrição',
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.description),
            ),
            const SizedBox(height: 20),
            CustomInputs.standard(
              theme: Colors.black,
              controller: controller.priceController,
              label: 'Valor de venda',
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              prefixIcon: const Icon(Icons.attach_money),
            ),
            const SizedBox(height: 20),
            CustomInputs.standard(
              theme: Colors.black,
              controller: controller.urlImageController,
              label: 'Link da imagem',
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.image),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<CategoryModel>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 12, right: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                prefixIcon: const Icon(Icons.category),
              ),
              isExpanded: true,
              hint: const Text(
                'Selecione uma categoria',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              value: controller.selectedCategory,
              items: controller.categories.map<DropdownMenuItem<CategoryModel>>(
                (CategoryModel category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  );
                },
              ).toList(),
              onChanged: (CategoryModel? category) {
                controller.setSelectedCategory(category);
              },
              validator: (CategoryModel? category) {
                if (category == null) {
                  return 'Selecione uma categoria';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.saveProduct();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme?.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Cadastrar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
