import Foundation

struct CPF {
    var digito: Int? = nil
    var validador: Int
    let id: UUID = UUID() // ID gerado automaticamente com UUID()
    let bolinho: Bool
    
    var descricao: String {
        guard let digito = digito else { return "-" }
        return "\(digito)\(validador)"
    }
}

extension CPF {
    // Inicializador customizado que recebe um CPF em String
    init(cpf: String, bolinho: Bool = true) {
        // Fazemos a conversão do CPF de String para Int
        self.digito = Int(String(cpf.prefix(1)))  // Pega o primeiro caractere para o 'digito'
        self.validador = Int(cpf.suffix(1)) ?? 0  // Pega o último caractere para o 'validador'
        self.bolinho = bolinho
    }
}

// Usando o inicializador customizado
let cpfExemplo = CPF(cpf: "123456789", bolinho: false)

// Usando o inicializador padrão
let cpfOutroExemplo = CPF(digito: nil, validador: 5, bolinho: true)

print("CPF - \(cpfExemplo.descricao) ")  // Exemplo de como acessar a descrição
print("CPF 2 - \(cpfOutroExemplo.descricao) ") // Exemplo de como acessar a descrição
