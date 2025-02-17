import 'package:flutter/material.dart';
import '../controles/controle_planeta.dart';
import '../modelos/planeta.dart';
import 'tela_planeta.dart';

class DetalhesPlaneta extends StatelessWidget {
  final Planeta planeta;
  final Function onPlanetaChanged;

  const DetalhesPlaneta({
    super.key,
    required this.planeta,
    required this.onPlanetaChanged,
  });

  Future<void> _excluirPlaneta(BuildContext context) async {
    final controle = ControlePlaneta();
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Planeta'),
            content: const Text('Tem certeza que deseja excluir este planeta?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await controle.excluirPlaneta(planeta.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Planeta excluído com sucesso!')),
      );
      onPlanetaChanged();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool temApelido =
        planeta.apelido != null && planeta.apelido!.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Planeta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com CircleAvatar e nome
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  planeta.nome.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                planeta.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Se houver apelido, mostra o card com o apelido
            if (temApelido)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.label),
                  title: const Text('Apelido'),
                  subtitle: Text(planeta.apelido!),
                ),
              ),
            // Card com o tamanho do planeta
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.aspect_ratio),
                title: const Text('Tamanho'),
                subtitle: Text('${planeta.tamanho} km'),
              ),
            ),
            // Card com a distância do planeta
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Distância'),
                subtitle: Text('${planeta.distancia} km'),
              ),
            ),
            const Spacer(),
            // Botões para editar e excluir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navega para a tela de edição
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TelaPlaneta(
                              isAdd: false,
                              planeta: planeta,
                              onCompleted: () {
                                onPlanetaChanged();
                                Navigator.of(context).pop();
                              },
                            ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 150, 143)),
                  onPressed: () => _excluirPlaneta(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
