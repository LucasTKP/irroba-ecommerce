import 'package:flutter/material.dart';
import 'package:my_app/controllers/contact_controller.dart';
import 'package:my_app/presenters/contact/register_contact.dart';

class ContactScreen extends StatelessWidget {
  final ContactControllerImpl controller;

  const ContactScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.contacts.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum contato registrado.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.contact_phone, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Nome: ${contact.name}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Endereço: ${contact.address}'),
                      const SizedBox(height: 8),
                      Text('Telefone: ${contact.phone}'),
                      const SizedBox(height: 8),
                      Text('E-mail: ${contact.email}'),
                      const SizedBox(height: 8),
                      Text('CPF: ${contact.cpf}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RegisterContact(controller: controller);
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
