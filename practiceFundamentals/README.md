# Restaurante Astro 🍽️🚀

**Projeto de estudo** para aprender e fixar fundamentos de Swift e SwiftUI, criado como parte do *Projeto Astro* (Ana).  
O app simula um pequeno restaurante para praticar: structs, classes, enums, protocols, generics, property wrappers, optionals, error handling, threads simples e SwiftUI.

---

## Objetivos de aprendizado
- Entender `let` vs `var`, `struct` vs `class`, `enum`, `protocol`.
- Trabalhar com `@State`, `@Binding`, `@ObservedObject`, `@StateObject`, `@EnvironmentObject`.
- Lidar com *Optionals* (`if let`, `guard let`, `?`, `??`), `throw/try/catch`.
- Construir interfaces com SwiftUI (Lists, Buttons, Text, Bindings).
- Praticar boas práticas de código: `Identifiable`, `MARK:` explicativos, arquitetura simples.

---

## Como rodar
1. Abra o Xcode (versão recomendada: 14+ ou 15+).  
2. Crie um novo projeto **App** com SwiftUI (ou abra o diretório do projeto já existente).  
3. Substitua o conteúdo de `ContentView.swift` pelo código deste repositório (arquivo `ContentView.swift`).  
4. Defina o `deployment target` para iOS 15/16+ (conforme sua versão do Xcode).  
5. Build & Run no simulador.

---

## Estrutura do projeto
- `ContentView.swift` – UI principal (Views e integração com estados).  
- `Models` (no mesmo arquivo, para simplicidade) – `Pedido`, `Prato`, `TipoPedido`.  
- `Menu` – `ObservableObject` com `@Published var pratos`.  
- `Cozinha` – `ObservableObject` (simula background + atualiza UI).  
- `BotaoPedido` – componente reutilizável com `@View`.

---

## Funcionalidades implementadas
- Listagem do cardápio via `Menu` (`@StateObject` / `@EnvironmentObject`).  
- Criar pedidos (armazenados em `@State var pedidos`).  
- Visualizar pedidos em `List` (cada `Pedido` é `Identifiable`).  
- Simulação de preparação na `Cozinha` (background -> atualiza via `@Published`).  
- Tratamento de erros ao pedir prato não existente (`do/try/catch`).  
- Exemplos práticos de Optionals: `if let`, `guard let`, `nil-coalescing` e `optional chaining`.

---

## Próximos passos sugeridos (para aprender)
- Aplicar MVVM: criar `ViewModel` para ContentView usando `@StateObject`.  
- Persistência local com `CoreData` ou `UserDefaults` (`@AppStorage`).  
- Integração com rede (simular chamadas com `URLSession`) e usar `async/await`.  
- Adicionar testes unitários (`XCTest`) para lógica de pedidos.

---

## Notas
- Este projeto é didático e intencionalmente simples para ajudar a fixar conceitos.  
- Se quiser, posso converter para vários arquivos (Models, Views, ViewModels) e preparar um PR pronto pra subir no GitHub.

---

**Autor:** Ana (Projeto Astro)  
**Assistente:** Astro (ChatGPT)

