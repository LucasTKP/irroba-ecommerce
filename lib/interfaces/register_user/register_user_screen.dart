import 'package:flutter/material.dart';
import 'package:irroba/interfaces/register_user/register_user_controller.dart';
import 'package:irroba/interfaces/register_user/widgets/step_one.dart';
import 'package:irroba/interfaces/register_user/widgets/step_two.dart';

class RegisterUserScreen extends StatelessWidget {
  final RegisterUserController controller;
  const RegisterUserScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Insira as informações do usuário nos campos abaixo',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if(controller.step == 1)
          StepOne(controller: controller),
          if(controller.step == 2)
          StepTwo(controller: controller),
        ],
      ),
    );
  }
}
