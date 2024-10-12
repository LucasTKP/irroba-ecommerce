extension MoneyFormatter on double {
  String formatToCurrency() {
    if (this == 0) return "R\$ 0,00";
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
