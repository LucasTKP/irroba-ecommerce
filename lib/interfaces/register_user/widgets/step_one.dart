import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';
import 'package:irroba/interfaces/register_user/register_user_controller.dart';
import 'package:irroba/interfaces/widgets/inputs.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StepOne extends StatelessWidget {
  final RegisterUserController controller;
  const StepOne({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return Form(
      key: controller.formKey1,
      child: Column(
        children: [
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.username,
            label: 'Nome de usuário',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.email,
            label: 'E-mail',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Email inválido';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.email),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.firstName,
            label: 'Primeiro nome',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.account_circle),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.lastName,
            label: 'Sobrenome',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.badge),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.phone,
            label: 'Celular',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '(##) #####-####',
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
            prefixIcon: const Icon(Icons.phone),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.password,
            label: 'Senha',
            obscureText: controller.obscurePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }

              if (value != controller.confirmPassword.text) {
                return 'As senhas devem ser iguais';
              }

              if (value.length < 8) {
                return 'A senha deve ter pelo menos 8 caracteres';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                controller.setObsecurePassword(!controller.obscurePassword);
              },
              icon: controller.obscurePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
            ),
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(Icons.password),
          ),
          const SizedBox(height: 20),
          CustomInputs.standard(
            theme: Colors.black,
            controller: controller.confirmPassword,
            label: 'Confirmar senha',
            obscureText: controller.obscurePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              if (value != controller.password.text) {
                return 'As senhas devem ser iguais';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                controller.setObsecurePassword(!controller.obscurePassword);
              },
              icon: controller.obscurePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
            ),
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(Icons.password),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (controller.formKey1.currentState!.validate()) {
                controller.setStep(2);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme?.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            ),
            child: const Text(
              'Próximo',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
