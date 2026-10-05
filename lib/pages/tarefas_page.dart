import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tarefas_provider.dart';
import 'concluidas_page.dart';

class TarefasPage extends StatelessWidget {
  const TarefasPage({super.key});

  void _abrirFormulario(BuildContext context) {
    final tituloController = TextEditingController();
    final horarioController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: 'Tarefa'),
              ),
              TextField(
                controller: horarioController,
                decoration: const InputDecoration(labelText: 'Horário'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final titulo = tituloController.text.trim();
                final horario = horarioController.text.trim();

                if (titulo.isNotEmpty && horario.isNotEmpty) {
                  context.read<TarefasProvider>().adicionarTarefa(
                    titulo,
                    horario,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TarefasProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: 'Tarefas concluídas',
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConcluidasPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Tarefas de hoje',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = provider.tarefas[index];

                return ListTile(
                  leading: Checkbox(
                    value: tarefa.concluida,
                    onChanged: (value) => provider.alterarStatus(tarefa),
                  ),
                  title: Text(
                    tarefa.titulo,
                    style: TextStyle(
                      decoration: tarefa.concluida
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 6),
                      Text(tarefa.horario),
                    ],
                  ),
                  trailing: IconButton(
                    tooltip: 'Excluir tarefa',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => provider.excluirTarefa(tarefa),
                  ),
                  onTap: () => provider.alterarStatus(tarefa),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
