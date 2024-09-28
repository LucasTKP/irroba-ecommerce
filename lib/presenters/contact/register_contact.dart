import 'package:flutter/material.dart';
import 'package:my_app/controllers/contact_controller.dart';
import 'package:my_app/widgets/inputs.dart';

class RegisterContact extends StatelessWidget {
  final ContactControllerImpl controller;
  const RegisterContact({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Contato'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Inputs.standard(
                theme: Colors.black,
                controller: controller.nameController,
                label: 'Nome',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),
              Inputs.standard(
                theme: Colors.black,
                controller: controller.addressController,
                label: 'Endereço',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o endereço';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.home),
              ),
              const SizedBox(height: 20),
              Inputs.standard(
                theme: Colors.black,
                controller: controller.phoneController,
                label: 'Telefone',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o telefone';
                  }
                  if (value.length != 15) {
                    return 'Formato inválido, (11) 12345-6789';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(height: 20),
              Inputs.standard(
                theme: Colors.black,
                controller: controller.emailController,
                label: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o e-mail';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, informe um e-mail válido';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              Inputs.standard(
                theme: Colors.black,
                controller: controller.cpfController,
                label: 'CPF',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o CPF';
                  }
                  if (value.length != 14) {
                    return 'Formato inválido, 123.456.789-10';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.document_scanner),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.add();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
