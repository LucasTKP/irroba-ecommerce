class TransferModel {
  final String numberAccount;
  final double value;

  TransferModel(this.numberAccount, this.value);

  @override
  String toString() => 'TransferModel(numberAccount: $numberAccount, value: $value)';
}
