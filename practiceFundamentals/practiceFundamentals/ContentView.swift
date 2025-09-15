import SwiftUI

// MARK: - Struct (dado simples)
struct Pedido: Identifiable {
    let id = UUID()
    var tipo: TipoPedido
    var prato: Prato
}

struct Garcon: Atendente {
    var nomeAtendente: String
    var mesa: Int
    
    func registrarPedido(_ pedido: Pedido) {
        print("Atendente \(nomeAtendente) registou o pedido: \(pedido) da mesa \(mesa): \(Date()) \(pedido.prato) por R$\(pedido.prato.preco))")
    }
}

//MARK: - Enum garante consistência (opções limitadas).
enum TipoPedido {
    case comerAqui
    case viagem
}

enum Prato: ItemDoCardapio {
    case hamburguer
    case salada
    case pizza
    case bebida(String)
    
    var nome: String {
        switch self {
        case .hamburguer: return "Hambúrguer"
        case .salada: return "Salada"
        case .pizza: return "Pizza"
        case .bebida(let tipo): return "Bebida \(tipo)"
        }
    }
    
    var preco: Double {
        switch self {
        case .hamburguer: return 25.0
        case .salada: return 15.0
        case .pizza: return 30.0
        case .bebida: return 5.0
        }
    }
    
    func descricao() -> String {
        return "\(nome) - R$ \(preco)"
    }
}

// MARK: - Protocol (contrato) garante flexibilidade (vários tipos diferentes podem estar no mesmo array se adotarem o mesmo protocolo).
protocol ItemDoCardapio {
    var nome: String { get }
    var preco: Double { get }
    func descricao() -> String
}

protocol Atendente {
    var nomeAtendente: String { get }
    var mesa: Int { get set }
    
    func registrarPedido(_ pedido: Pedido)
}

// MARK: - Class (referência)
class Menu: ObservableObject {
    @Published var pratos: [Prato] = [
        .hamburguer, .salada, .pizza, .bebida("Suco")
    ]
}

class Cliente {
    var name: String
    var pedido: Pedido?
    
    init(name: String) {
        self.name = name
    }
    
    func fazerPedido(_ pedido: Pedido) {
        self.pedido = pedido
        print("\(name) pediu \(pedido.prato) para \(pedido.tipo)")
    }
}

// MARK: - Estilo do Botão
struct BotaoPedido: View {
    var titulo: String
    var acao: () -> Void
    
    var body: some View {
        Button(titulo, action: acao)
            .buttonStyle(.borderedProminent)
            .tint(.green)
    }
}

// MARK: - SwiftUI
struct ContentView: View {
    
    @State var contador = 0
    @State private var pedidos: [Pedido] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("🍽️ Restaurante Astro")
                .font(.title)
                .bold()
            
            Divider()
            
            Button("Fazer Pedido") {
                let cliente = Cliente(name: "Paula")
                let pedido = Pedido(tipo: .comerAqui, prato: .pizza)
                cliente.fazerPedido(pedido)
                
                
                let garcom = Garcon(nomeAtendente: "Pedro", mesa: 5)
                let pedido2 = Pedido(tipo: .comerAqui, prato: .pizza)
                garcom.registrarPedido(pedido2)
            }
            
            Button("Somar") {
                 contador += 1 //❌ será erro sem declarar @State pois << struct é imutável >>
            }
            
            Text("Total de pedidos: \(pedidos.count)")
            
            Text("Contador: \(contador)")
            
            Divider()
            
            BotaoPedido(titulo: "🍔 Pedir Hambúrguer") {
                pedidos.append(Pedido(tipo: .viagem, prato: .hamburguer))
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            BotaoPedido(titulo: "🥗 Pedir Salada (para viagem)") {
                pedidos.append(Pedido(tipo: .comerAqui, prato: .salada))
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            BotaoPedido(titulo: "🍕 Pedir Pizza") {
                pedidos.append(Pedido(tipo: .comerAqui, prato: .pizza))
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
           
            Divider()
            
            List(pedidos) { pedido in
                HStack {
                    Text(pedido.prato.nome)
                        .font(.headline)
                    Spacer()
                    Text("R$ \(pedido.prato.preco, specifier: "%.2f")")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(height: 200)
            
            Spacer()
                    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
