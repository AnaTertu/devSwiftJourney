import Foundation

var greeting = "Hello, World! Hello, playground"

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
