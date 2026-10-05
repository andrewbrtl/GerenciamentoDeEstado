import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tarefas_provider.dart';

class ConcluidasPage extends StatelessWidget {
  const ConcluidasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TarefasProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas Concluídas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: provider.concluidas.isEmpty
          ? const Center(child: Text('Nenhuma tarefa concluída.'))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: provider.concluidas.length,
              itemBuilder: (context, index) {
                final tarefa = provider.concluidas[index];

                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.teal),
                  title: Text(tarefa.titulo),
                  subtitle: Text(tarefa.horario),
                  trailing: IconButton(
                    tooltip: 'Marcar como pendente',
                    icon: const Icon(Icons.undo),
                    onPressed: () => provider.alterarStatus(tarefa),
                  ),
                );
              },
            ),
    );
  }
}
