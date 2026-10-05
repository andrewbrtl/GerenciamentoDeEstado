import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/tarefas_page.dart';
import 'providers/tarefas_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TarefasProvider(),
      child: const MeuAplicativo(),
    ),
  );
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Agenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        fontFamily: 'RobotoLocal',
        useMaterial3: true,
      ),
      home: const TarefasPage(),
    );
  }
}
