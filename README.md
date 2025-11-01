# flutter_youtube_bloc_pattern

Aplicativo Flutter com padrão BLoC para busca de vídeos no YouTube, reprodução e gestão de favoritos

## 🚀 Visão geral

Este projeto demonstra uma aplicação móvel em Flutter que se integra à API do YouTube, utilizando o padrão de arquitetura BLoC (Business Logic Component) para gerenciar o estado de forma reativa.
Principais funcionalidades:

Busca de vídeos por termo (via API YouTube)

Exibição dos resultados em lista

Reprodução de vídeo (embed ou player)

Marcação de vídeos como favoritos e visualização da lista de favoritos

Código organizado, modular e com foco em boas práticas

This project is a starting point for a Flutter application.

## 🧰 Principais tecnologias

Flutter (Dart)

Padrão BLoC para gerenciamento de estado

Integração com API YouTube

Persistência simples (ex: local, para favoritos)

Estrutura modular (separação de camadas: UI, BLoC, repository)

## 📂 Estrutura do projeto

/android/  
/ios/  
/lib/                         → código-fonte em Dart  
   /blocs/                    → lógica de negócios, eventos e estados
   /delegates/                → processo de busca
   /models/                   → modelos de dados  
   /screens/                  → telas do app  
   /widgets/                  → widgets
   /main/                     → main  
   /api/                      → acesso a api do youtube
/test/                        → testes  
/web/                         → suporte a Web (se habilitado)  
assets/                       → ícones, imagens, etc  
pubspec.yaml                  → definição de dependências  

## Dependências:

youtube_player_flutter permite abrir vídeos do youtube dentro do app;
shared_preferences permite armazenar a lista de favoritos de forma offline;
flutter_bloc ajuda na implementação do BLoC;
rxdart deixa o BLoC mais simplificado;
http

## Links:

"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"


