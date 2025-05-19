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

//CPF.init(digito: nil, validador: .zero, id: UUID(), bolinho: false)
// criar um inicializador q receba o cpf como string , não pode perder o inicializador default

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
 

//computed property

class Pessoa {
    
    var cpf: CPF?

}

class Trabalhador: Pessoa {
    
}


class Television{
    
    var marca: String
    var volume: Int
    
    init(marca: String, volume: Int){
        self.marca = marca
        self.volume = volume
    }
    
    // metodo - função dentro da class
    func aumentarVolume() {
        if volume < 10 {
            print("O volume da televisão de \(volume)")
            volume += 1
            print("foi aumentado para: \(volume).")
            return
        } else {
            print("⚠️ Volume já está no máximo.")
        }
    }
    
    func diminuirVolume() {
        if volume > 0 {
            print( "O volume da televisão de \(volume)")
            volume -= 1
            print( "foi diminuído para: \(volume).")
            return
        } else {
            print("⚠️ Volume já está no mínimo.")
        }
    }
}

// instância da tv
let minutoTv = Television(marca: "LG", volume: 2)
print("O volume da televisão da marca \(minutoTv.marca) é \(minutoTv.volume)volume")
minutoTv.aumentarVolume()
minutoTv.aumentarVolume()
minutoTv.aumentarVolume()
minutoTv.diminuirVolume()
minutoTv.diminuirVolume()
minutoTv.diminuirVolume()
minutoTv.diminuirVolume()
minutoTv.diminuirVolume()
minutoTv.diminuirVolume()


class Abajur {
    
    private var lampada: Bool
    private var click: Int
    
    init() {
        self.lampada = false
        self.click = 0
    }
    
    private func ligaDesligaLampada() {
        
        if self.click != 0 {
            self.lampada = true
        } else {
            self.lampada = false
        }
        
    }
    
    private func controleIntensidades() {
        
        //for _ in 1...4 {
            
            click += 1
            
            if click == 4 {
                click = 0
            }

        //}
    }
    
    func tocarBotao() -> String {
        
        return lampada ? "🟢 lampada ligada" : "🔴 lampada desligada"
        /*
        if self.lampada == true {
            return "🟢"
        } else {
            return "🔴"
        }
         */
    }
    
    
    func manipularAbajur() {
        
        self.controleIntensidades()
        self.ligaDesligaLampada()
        print(self.tocarBotao())
        
        // Exibe descrição da intensidade ou desligado
        switch click {
            case 1:
                print("💡 Intensidade fraca.")
            case 2:
                print("💡💡 Intensidade média.")
            case 3:
                print("💡💡💡 Intensidade forte.")
            case 0:
                print("🔌 Lâmpada desligada.")
            default:
                print("Erro inesperado.")
        }
        
        print("----------------------")
    }
        /*
        if self.click == 1 {
                print("Um toque, lâmpada acesa 🟢 com intensidade fraca.")
            } else if self.click == 2 {
                print("Dois toques, lâmpada acesa 🟢 com intensidade média.")
            } else if self.click == 3 {
                print("Três toques, lâmpada acesa 🟢 com intensidade forte.")
            } else if self.click == 4 {
                print("Quatro toques, lâmpada apagada 🔴.")
            } else {
                print("Lampada queimada ou sem energia")
            }
         
         }*/
    
}

var abajur = Abajur()
abajur.tocarBotao()
abajur.manipularAbajur()

for _ in 1...6 {
    abajur.manipularAbajur()
}


class Mouse {
    var _cor: String
    var qtd_botoes: Int
    
    var cor: String {
        get {
            return _cor
        }
        set {
            return _cor = newValue
        }
    }
    
    init (cor: String, qtd_botoes: Int) {
        self._cor = cor
        self.qtd_botoes = qtd_botoes
    }
}

var macbookPro = Mouse(cor: "Preto", qtd_botoes: 2)
print("Cor do mouse: \(macbookPro.cor)")
macbookPro.cor = "Azul"
print("Cor do mouse: \(macbookPro.cor)")

for _ in 1...3 {
    print("Cor do mouse: \(macbookPro.cor)")
}

