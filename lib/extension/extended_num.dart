import 'package:intl/intl.dart';

extension ExtendedNum on num {
  String addCurrency() {
    if (this == null) return null;

    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      name: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(this);
  }
}
