import 'package:flutter_diprovet_cliente/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatCurrency usa separador de miles y dos decimales', () {
    final formatted = formatCurrency(12500.5);

    expect(formatted, contains('12.500'));
    expect(formatted, contains('50'));
  });
}
