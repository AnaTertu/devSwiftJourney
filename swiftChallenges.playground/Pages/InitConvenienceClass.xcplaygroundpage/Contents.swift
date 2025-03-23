import Foundation

// Convenience
class Carro {
    var modelo: String
    var ano: Int
    var cor: String
    
    // Inicializador designado (normal)
    init(modelo: String, ano: Int, cor: String) {
        self.modelo = modelo
        self.ano = ano
        self.cor = cor
    }
    
    // Inicializador convenience
    convenience init(modelo: String, cor: String) {
        // Chamando o inicializador designado para completar a inicialização
        self.init(modelo: modelo, ano: 2020, cor: cor)
    }
}

let carro1 = Carro(modelo: "Fusca", ano: 1965, cor: "Azul")  // Usando o inicializador designado
let carro2 = Carro(modelo: "Fusca", cor: "Vermelho")  // Usando o inicializador convenience
