import 'package:flutter/material.dart';
import 'package:irroba/interfaces/home/home_presenter.dart';
import 'package:irroba/interfaces/register_product/register_product_presenter.dart';
import 'package:irroba/interfaces/widgets/box_option_menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Opções', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            boxOptionMenu(
              context: context,
              onPressedButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterProductPresenter()));
              },
              icon: Icons.add_circle_outline,
              label: 'Cadastrar Produto',
            ),
            const SizedBox(height: 16),
            boxOptionMenu(
              context: context,
              onPressedButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePresenter()));
              },
              icon: Icons.inventory,
              label: 'Consultar estoque',
            ),
            const SizedBox(height: 16),
            boxOptionMenu(
              context: context,
              onPressedButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePresenter()));
              },
              icon: Icons.person_add,
              label: 'Criar usuário',
            ),
            const SizedBox(height: 16),
            boxOptionMenu(
              context: context,
              onPressedButton: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePresenter()));
              },
              icon: Icons.group,
              label: 'Consultar usuários',
            ),
          ],
        ),
      ),
    );
  }
}
