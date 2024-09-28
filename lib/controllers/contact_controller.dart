import 'package:flutter/material.dart';
import 'package:my_app/models/contact.dart';

abstract class ContactController extends ChangeNotifier {
  List<ContactModel> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void add();
}

class ContactControllerImpl extends ContactController {
  @override
  void add() {
    if (!formKey.currentState!.validate()) return;
    contacts.add(
      ContactModel(
        name: nameController.text,
        address: addressController.text,
        phone: phoneController.text,
        email: emailController.text,
        cpf: cpfController.text,
      ),
    );
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    emailController.clear();
    cpfController.clear();

    notifyListeners();
  }
}
