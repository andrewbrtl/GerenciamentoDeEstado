class Tarefa {
  Tarefa({required this.titulo, required this.horario, this.concluida = false});

  final String titulo;
  final String horario;
  bool concluida;
}
