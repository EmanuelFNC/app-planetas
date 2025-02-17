import 'package:flutter/material.dart';
import '../controles/controle_planeta.dart';
import '../modelos/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isAdd;
  final Planeta planeta;
  final Function() onCompleted;

  const TelaPlaneta({
    super.key,
    required this.isAdd,
    required this.planeta,
    required this.onCompleted,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  late Planeta _planeta;

  @override
  void initState() {
    _planeta = widget.planeta;

    if (!widget.isAdd) {
      _nameController.text = _planeta.nome;
      _sizeController.text = _planeta.tamanho.toString();
      _distanceController.text = _planeta.distancia.toString();
      _nicknameController.text = _planeta.apelido ?? '';
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();
    _distanceController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _inserirPlaneta() async {
    await _controlePlaneta.inserirPlaneta(_planeta);
  }

  Future<void> _editarPlaneta() async {
    await _controlePlaneta.editarPlaneta(_planeta);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isAdd) {
        _inserirPlaneta();
      } else {
        _editarPlaneta();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Planeta ${widget.isAdd ? 'cadastrado' : 'editado'} com sucesso!',
          ),
        ),
      );

      Navigator.of(context).pop();
      widget.onCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.isAdd ? 'Cadastrar' : 'Editar'} Planeta'),
        backgroundColor: const Color.fromARGB(255, 93, 231, 255),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Cabeçalho visual
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text.substring(0, 1).toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.isAdd ? 'Novo Planeta' : 'Editar Planeta',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Formulário
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo Nome
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: const Icon(Icons.public),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'Insira o nome do planeta (3+ caracteres)';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _planeta.nome = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Campo Tamanho
                    TextFormField(
                      controller: _sizeController,
                      decoration: InputDecoration(
                        labelText: 'Tamanho (em km)',
                        prefixIcon: const Icon(Icons.aspect_ratio),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o tamanho do planeta';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Insira um valor numérico válido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _planeta.tamanho = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Campo Distância
                    TextFormField(
                      controller: _distanceController,
                      decoration: InputDecoration(
                        labelText: 'Distância (em km)',
                        prefixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira a distância do planeta';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) < 0) {
                          return 'Insira um valor numérico válido';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _planeta.distancia = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Campo Apelido (opcional)
                    TextFormField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        labelText: 'Apelido (opcional)',
                        prefixIcon: const Icon(Icons.tag),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) {
                        _planeta.apelido = value;
                      },
                    ),
                    const SizedBox(height: 30),
                    // Botões de ação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              190,
                              190,
                            ),
                          ),
                          icon: const Icon(Icons.close),
                          label: const Text('Cancelar'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.save),
                          label: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
