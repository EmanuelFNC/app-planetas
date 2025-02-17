class Planeta {
  int? id;
  String nome;
  double tamanho;
  double distancia;
  String? apelido;
  int? icone; // Novo campo para armazenar o codePoint do ícone

  // Construtor da classe Planeta
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
    this.icone,
  });

  // Construtor alternativo
  Planeta.vazio()
      : nome = '',
        tamanho = 0.0,
        distancia = 0.0,
        apelido = '',
        icone = null;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
      'icone': icone,
    };
  }

  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distancia: map['distancia'],
      apelido: map['apelido'],
      icone: map['icone'],
    );
  }
}
