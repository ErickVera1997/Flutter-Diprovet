import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BtnDiprovet ejecuta onTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BtnDiprovet(
            text: 'Enviar',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Enviar'));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
