import Foundation

// usa-se optional? em sitações q o valor pode estar ausente (pode ou não existir)

// Há um valor pode (desencapsular) o optional para acessar esse valor
// não há valor (nil) = ausencia de valor

// var algumaVar: Tipo?

// desencapsula - significa q vou retirar o valor que era optional e vou tranforma-lo em um valor de fato, ou seja não mais uma possibilidade, mas sim teremos um valor declarado

// algumaVar!  -- ! força o desencapsulamento // se não houver valor declarado a aplicação irá quebrar -- não use se não tiver a certeza de que há algum valor

var algumaVar: String? = "Hello, World!"
//var algumaVar: String?

if algumaVar != nil {
    algumaVar! // podemos ou não usar o force !, pois o app não quebra por conta do if
} else {
    algumaVar? = "Hello, World! New Value"
}

//forma mais ideal de desencapsulamento Optional Binding

if let temosAlgumaVar = algumaVar { // verifica se algumaVar tem ou não valor - se é nil ou preenchida
    print(temosAlgumaVar)
} else {
    algumaVar = "Hello, World! New Value"
}

//cria uma constante algumaVar é= let algumaVar =algumaVar
if let algumaVar { // verifica se algumaVar tem ou não valor - se é nil ou preenchida
    print(algumaVar)
} else {
    algumaVar = "Hello, World! New Value"
}

//cria uma variável algumaVar é= var algumaVar =algumaVar
if var algumaVar { // verifica se algumaVar tem ou não valor - se é nil ou preenchida
    print(algumaVar)
} else {
    algumaVar = "Hello, World! New Value"
}
///
/// IF encadeado
/// possibilidade de transformar Int para String
///         Int                 Int? optional
if let firstNumber1 = Int("4") {
    if let secondNumber2 = Int("42") {
        if firstNumber1 < secondNumber2 && secondNumber2 < 100 {
            print("\(firstNumber1) < \(secondNumber2) < 100")
        }
    }
} else {
    print( "Não foi possível converter a string para Int e firstNumber1 e secondNumber2 não pode ser declarada fora do if")
}

/// IF na mesma linha
///             Int          Int?
if let firstNumber1 = Int("4"), let secondNumber2 = Int("42"), firstNumber1 < secondNumber2 && secondNumber2 < 100 {
            print("o número \(firstNumber1) é < que \(secondNumber2) e < que 100")
}

/// O guarda valida a condição se for verdadeiro executa, se não entra no else
/// guard < <# CONDIÇÃO #> > else {
/// < <#return/break/continue/throw #> >
/// }
///
/// A diferença entre if e guard
/// no if a optional é desencapsulada somente dentro do bloco if, nos demais escopos segue sendo optional e a let criada em if existe somente dentro de if.
/// no guard após o desencapsulamento a let? ou var? deixa de ser optional e pode ser usada fora do guard como let ou var

func entrada(idade: Int, firstNumber1: Int? = nil, secondNumber2: Int? = nil) {
    
    guard idade >= 18 else {
        print("Idade: \(idade). Entrada proibida, você tem menos de 18 anos.")
        return
    }
    
    print("Você tem \(idade) anos. Entrada permitida.")
    
    guard let firstNumber1 = Int("4"), let secondNumber2 = Int("42"), firstNumber1 < secondNumber2 && secondNumber2 < 100 else {
        
        return
    }

    print("o valor \(firstNumber1) é menor que \(secondNumber2) e é menor que 100")
}

entrada(idade: 18)
entrada(idade: 17)

func encode(_ string: String) -> String {
    guard !string.isEmpty else {
        return "nil"
    }
    
    return string
}

///
///

var greeting = "Hello, World! Hello, playground!"

class Residence {
    var numbersOfBedrooms: Int = 3
}

class Person {
    var residence: Residence?
}

let joan: Person = Person()

/* // joan.residence!.numbersOfBedrooms // retorna erro pois força o desemcapsulamento de um var nil  o app fecha // force unrape ! */
joan.residence?.numbersOfBedrooms // Optional Chaining return nill pois não há valor declarado

if let roomCount = joan.residence?.numbersOfBedrooms {
    print("A residencia de Joan possui \(roomCount) quartos")
    
    print("Agora a residencia de Joan possui \(roomCount) quartos")
} else {
    print("Sem valor declarado")
}

joan.residence = Residence()

if let roomCount = joan.residence?.numbersOfBedrooms {
    print("A residencia de Joan possui \(roomCount) quartos")
    
} else {
    print("Sem valor declarado")
}
