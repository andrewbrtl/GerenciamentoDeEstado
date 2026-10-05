import 'package:agenda_tarefas/main.dart';
import 'package:agenda_tarefas/providers/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('mostra a lista de tarefas', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TarefasProvider(),
        child: const MeuAplicativo(),
      ),
    );

    expect(find.text('Minha Agenda'), findsOneWidget);
    expect(find.text('Tarefas de hoje'), findsOneWidget);
    expect(find.text('Estudar Flutter'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pump();

    expect(find.text('Estudar Flutter'), findsNothing);
  });
}
