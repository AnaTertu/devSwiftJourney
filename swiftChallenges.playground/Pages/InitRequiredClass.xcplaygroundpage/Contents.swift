import Foundation

// Required
class Animal {
    var nome: String
    
    // Inicializador required
    required init(nome: String) {
        self.nome = nome
    }
}

class Cachorro: Animal {
    var raça: String
    
    // A classe Cachorro precisa implementar o inicializador 'required'
    required init(nome: String) {
        self.raça = "Desconhecida"
        super.init(nome: nome)
    }
}

let cachorro = Cachorro(nome: "Rex")
