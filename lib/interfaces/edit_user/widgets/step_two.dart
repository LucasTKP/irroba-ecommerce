import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/interfaces/edit_user/edit_user_controller.dart';
import 'package:irroba/interfaces/widgets/inputs.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StepTwo extends StatelessWidget {
  final EditUserController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return Form(
      key: controller.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.street,
            label: 'Rua',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.location_on),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.number,
            label: 'Número',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.format_list_numbered),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.city,
            label: 'Cidade',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.location_city),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.zipcode,
            label: 'CEP',
            keyboardType: TextInputType.text,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '#####-###',
                filter: {"#": RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.local_post_office),
          ),
          const SizedBox(height: 10),
          const Text('Pegar latitude e longitude atual:'),
          IconButton(
            onPressed: () {
              controller.getLocation();
            },
            padding: EdgeInsets.zero,
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme?.primary,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Buscar', style: TextStyle(color: Colors.white)),
                  Icon(Icons.location_on, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.latitude,
            label: 'Latitude',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.map),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.longitude,
            label: 'Longitude',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.map_outlined),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (controller.formKey2.currentState!.validate()) {
                  controller.saveUser();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme?.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
