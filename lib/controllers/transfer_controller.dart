import 'package:flutter/cupertino.dart';
import 'package:my_app/models/transfer.dart';

abstract class TransferController extends ChangeNotifier {
  TextEditingController numberAccount = TextEditingController();
  TextEditingController value = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<TransferModel> transfers = [];

  void add();
}

class TransferControllerImpl extends TransferController {
  @override
  void add() {
    if (!formKey.currentState!.validate()) return;
    transfers.add(TransferModel(numberAccount.text, double.parse(value.text)));
    numberAccount.clear();
    value.clear();
    notifyListeners();
  }
}
