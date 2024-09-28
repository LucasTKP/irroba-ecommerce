import 'package:flutter/material.dart';
import 'package:my_app/controllers/contact_controller.dart';
import 'package:my_app/controllers/transfer_controller.dart';
import 'package:my_app/presenters/contact/contact_screen.dart';
import 'package:my_app/presenters/transfer/tranfers_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TransferControllerImpl transferController = TransferControllerImpl();
  final ContactControllerImpl contactController = ContactControllerImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TransferScreen(controller: transferController),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green, // Cor verde
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Transferências',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre as áreas

            // Área clicável de Contatos
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContactScreen(controller: contactController),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue, // Cor azul
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.contacts, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Contatos',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
