import Foundation

//INICIALIZADOR DE CLASS NORMAL REQUIRED CONVINENCI

//Normal
class Pessoa {
    var nome: String
    var idade: Int
    
    // Inicializador normal
    init(nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
    }
}

let pessoa = Pessoa(nome: "Ana", idade: 25)
