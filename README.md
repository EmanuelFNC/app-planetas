# Gerenciador de Planetas 🚀🌌

Este é um projeto **CRUD** desenvolvido em **Flutter** para gerenciar informações de planetas.  
Feito como parte do curso **Talento Tech - Paraná**.

## 📋 Descrição

O **Gerenciador de Planetas** permite:
- **Criar:** Cadastrar novos planetas, informando nome, tamanho (em km), distância do sol (em UA) e, opcionalmente, um apelido.
- **Ler:** Exibir uma lista de planetas cadastrados e visualizar detalhes completos de cada um.
- **Atualizar:** Editar os dados dos planetas.
- **Excluir:** Remover planetas da base de dados com confirmação prévia.

Os dados são armazenados localmente utilizando o banco de dados **SQLite** para Android, garantindo a persistência das informações.

## 💻 Tecnologias Utilizadas

- **Linguagem:** Dart
- **Framework:** Flutter
- **Banco de Dados:** SQLite
- **Plataforma:** Android

## 🎥 Demonstração

### Vídeo do Aplicativo
[Clique aqui para assistir ao vídeo](https://i.imgur.com/BXR5LqL.mp4)  
Ou visualize abaixo (caso o visualizador suporte):

[![Vídeo usando o aplicativo](https://i.imgur.com/BXR5LqL.mp4)](https://i.imgur.com/BXR5LqL.mp4)

### Screenshots

#### Tela Inicial
![Tela Inicial](https://i.imgur.com/NzfoSm1.jpeg)

#### Tela de Cadastro
![Tela de Cadastro](https://i.imgur.com/z5R2mnU.jpeg)

#### Selecionar Ícone no Cadastro
![Selecionar Ícone](https://i.imgur.com/MPRSxYE.jpeg)

#### Tela de Detalhes do Planeta
![Tela de Detalhes](https://i.imgur.com/5vzxq39.jpeg)

#### Confirmação para Excluir o Planeta
![Confirmação para Excluir](https://i.imgur.com/AaMy79B.jpeg)

#### Editando Planeta
![Editando Planeta](https://i.imgur.com/5sr7FvH.jpeg)

## 🚀 Como Executar o Projeto

### Pré-requisitos
- [Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio ou outra IDE com suporte a Flutter e um dispositivo/emulador Android.
- (Opcional) Ambiente online com a IDE [Project IDX](https://projectidx.com/) para desenvolvimento e testes.

### Passos para Executar

1. **Clone o Repositório:**

   ```bash
   git clone https://github.com/EmanuelFNC/app-planetas.git
   cd app-planetas
   ```

2. **Instale as Dependências:**

   ```bash
   flutter pub get
   ```

3. **Execute o Projeto:**

   ```bash
   flutter run
   ```

## 📁 Estrutura do Projeto

```
app-planetas/
├── lib/
│   ├── controles/
│   │   └── controle_planeta.dart
│   ├── modelos/
│   │   └── planeta.dart
│   ├── telas/
│   │   ├── tela_detalhes.dart
│   │   └── tela_planeta.dart
│   ├── utils/
│   │   └── icon_helper.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## 🤝 Contribuições

Contribuições são super bem-vindas!  
Se você encontrar algum bug ou tiver sugestões de melhorias, por favor, abra uma _issue_ ou envie um _pull request_.

## 📄 Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

---

Feito com ❤️ por [Emanuel de Tarso] para o curso **Talento Tech - Paraná**.
