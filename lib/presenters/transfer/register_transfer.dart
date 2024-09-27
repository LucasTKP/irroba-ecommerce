import 'package:flutter/material.dart';
import 'package:my_app/controllers/transfer_controller.dart';
import 'package:my_app/widgets/inputs.dart';

class RegisterTransfer extends StatelessWidget {
  final TransferControllerImpl controller;
  const RegisterTransfer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Transferência'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Inputs.standard(
                theme: Colors.black,
                controller: controller.numberAccount,
                label: 'Número da conta',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o número da conta';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.account_balance),
              ),
              const SizedBox(height: 20),
              Inputs.standard(
                theme: Colors.black,
                controller: controller.value,
                label: 'Valor',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o valor';
                  }
                  // Valida se o valor pode ser convertido para double
                  final doubleValue = double.tryParse(value);
                  if (doubleValue == null) {
                    return 'Por favor, informe um valor válido';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.attach_money),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.add();
                    Navigator.pop(context); // Voltar para a tela anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Borda menos arredondada
                  ),
                ),
                child: const Text(
                  'Registrar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
