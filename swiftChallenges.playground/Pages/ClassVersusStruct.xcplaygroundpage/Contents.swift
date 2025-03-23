import Foundation

struct CPF {
    var digito: Int? = nil
    var validador: Int
    let id: UUID = UUID()
    let bolinho: Bool
    // var/let nome_da_variavel: tipo = inicializador ex. var id: UUID = UUID()
    // var/let nome_da_variavel: tipo? **implicita(= nil) >>> ex. = var id: UUID?
    // var/let nome_da_variavel = inicializador >>> ex. var id = UUID()
    
    var descricao: String {
        guard let digito else { return "-" }
        return "\(digito)\(validador)"
    }
    
    /*
         teste("", param1: "", diferente: "")
         teste("", param1: "", diferente: "", param4: "")
     */
    func teste(_ param: String, param1: String, diferente param3: String, param4: String = "") {
        print(param3)
        // alias_externo? parametro: tipo (= valor default)?
        
    }
}

CPF.init(digito: nil, validador: .zero, id: UUID(), bolinho: false)
// criar um inicializador q receba o cpf como string , não pode perder o inicializador default
/*
 init(digito: Int? = nil, validador: Int, id: UUID = UUID(), bolinho: Bool){
        self.digito = digito
        self.validador = validador
        self.id = UUID()
        self.bolinho = Bool
 }
 
 init(digito: Int? = nil, validador: Int){
     self.digito = digito
     self.validador = validador
}
 */

//computed property

class Pessoa {
    
    var cpf: CPF?

}

class Trabalhador: Pessoa {
    
}
