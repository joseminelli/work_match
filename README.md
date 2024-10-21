# WorkMatch App

O **WorkMatch** é um aplicativo Flutter desenvolvido para ajudar mulheres a encontrar vagas de emprego e acessar conteúdos de qualificação. O aplicativo possui uma interface amigável e é dividido em várias telas que permitem navegar facilmente entre as funcionalidades.

## Estrutura do Projeto

A estrutura do projeto é organizada da seguinte forma:

[Veja a pasta lib aqui](https://github.com/joseminelli/work_match/tree/main/lib)
```
WorkMatch/
│
assets/
├── data/
│     ├── jobs.json      
│     └── videos.json  
│
lib/
│
├── main.dart
├── app_state.dart
├── models/
│   ├── jobs.dart        
│   └── videos.dart         
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── job_list_screen.dart
│   ├── content_screen.dart
│   └── profile_screen.dart
└── widgets/
    ├── job_card.dart   
    └── video_card.dart 
```
## Funcionalidades
- **Tela de Login**: Permite que os usuários se autentiquem.
- **Tela Principal**: Exibe uma lista de vagas de emprego disponíveis.
- **Conteúdos**: Acesso a vídeos de qualificação diretamente na aplicação.

## Arquivos e Dados
- **jobs.json**: Contém um array de objetos representando as vagas de emprego. Cada objeto possui as seguintes propriedades:

  - title: Título da vaga
  - company: Nome da empresa
  - type: Tipo de trabalho (ex: remoto, presencial)
  - description: Descrição da vaga
  - logo: URL do logo da empresa


- **videos.json**: Contém um array de objetos representando vídeos de qualificação. Cada objeto possui as seguintes propriedades:

  - title: Título do vídeo
  - url: URL do vídeo no YouTube

## Tecnologias Utilizadas
- **Flutter**: Framework para desenvolvimento de aplicativos móveis.
- **Dart**: Linguagem de programação utilizada no Flutter.
- **Provider**: Biblioteca para gerenciamento de estado no Flutter.
- **Youtube Player Flutter**: Biblioteca para integrar vídeos do YouTube.


## Como executar

- Instale o [Flutter](https://flutter.dev/)
- Com o projeto aberto, execute ``` flutter pub get``` para baixar as dependências
- Para emular/testar o aplicativo, execute ``` flutter run``` no terminal
