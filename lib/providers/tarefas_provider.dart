import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class TarefasProvider extends ChangeNotifier {
  final List<Tarefa> _tarefas = [
    Tarefa(titulo: 'Estudar Flutter', horario: '09:00'),
    Tarefa(titulo: 'Fazer atividade da faculdade', horario: '14:00'),
    Tarefa(titulo: 'Organizar o quarto', horario: '18:00', concluida: true),
  ];

  List<Tarefa> get tarefas => _tarefas;

  List<Tarefa> get concluidas {
    return _tarefas.where((tarefa) => tarefa.concluida).toList();
  }

  void adicionarTarefa(String titulo, String horario) {
    _tarefas.add(Tarefa(titulo: titulo, horario: horario));
    notifyListeners();
  }

  void alterarStatus(Tarefa tarefa) {
    tarefa.concluida = !tarefa.concluida;
    notifyListeners();
  }

  void excluirTarefa(Tarefa tarefa) {
    _tarefas.remove(tarefa);
    notifyListeners();
  }
}
