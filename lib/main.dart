import 'package:flutter/material.dart';

import 'controles/controle_planeta.dart';
import 'modelos/planeta.dart';
import 'telas/tela_detalhes.dart';
import 'telas/tela_planeta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gerenciador de Planetas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Planeta> _planetas = [];

  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  @override
  void initState() {
    super.initState();
    _atualizarPlanetas();
  }

  Future<void> _atualizarPlanetas() async {
    final resultado = await _controlePlaneta.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

  void _telaPlaneta(BuildContext context, bool isAdd, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TelaPlaneta(
              planeta: planeta,
              isAdd: isAdd,
              onCompleted: () {
                _atualizarPlanetas();
              },
            ),
      ),
    );
  }

  void _excluirPlaneta(int id) async {
    await _controlePlaneta.excluirPlaneta(id);
    _atualizarPlanetas();
  }

  void _excluirPlanetaConfirmar(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Planeta'),
          content: const Text('Tem certeza que deseja excluir este planeta?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                _excluirPlaneta(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          final planeta = _planetas[index];
          final bool temApelido =
              planeta.apelido != null && planeta.apelido!.trim().isNotEmpty;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => DetalhesPlaneta(
                          planeta: planeta,
                          onPlanetaChanged: _atualizarPlanetas,
                        ),
                  ),
                );
              },
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  planeta.nome.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                planeta.nome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      temApelido
                          ? 16
                          : 22, // Título maior se não houver apelido
                ),
              ),
              subtitle: temApelido ? Text(planeta.apelido!) : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _telaPlaneta(context, false, planeta),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _excluirPlanetaConfirmar(planeta.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _telaPlaneta(context, true, Planeta.vazio()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
