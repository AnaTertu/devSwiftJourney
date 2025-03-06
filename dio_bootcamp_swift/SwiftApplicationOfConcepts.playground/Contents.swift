import UIKit

let greeting = "Hello, playground"

var congratulation = "Sra. Ana"

var fruits = ["Banana", "Apple", "Orange", "Mango"]

fruits.append("Pineapple")

fruits[1] = "Strawberry"

fruits

var occupations = [
    "Japan" : "Capitan",
    "Brazilian": "Teacher"
]


let emptyArray: [String] = []
let emptyDictionary: [String : Float] = [:]

//Optional Changes

class Residence {
    var numberOfRooms = 1
}

class Person {
    var residence: Residence? // resincia opcional - inicializa como nill
}

let john = Person()

//john.residence?.numberOfRooms // nill // evite este forçar, pois se for nill app fecha

if let roomCount = john.residence?.numberOfRooms {
    print ("Number rooms \(roomCount)")
} else {
    print("Not rooms")
}

john.residence = Residence() // passa a conter

if let roomCount = john.residence?.numberOfRooms {
     roomCount
} else {
    print("Not rooms")
}

// Controle de fluxo
// if | switch CONDICIONAIS
// for-in | while | repeat LOOPS

let numScoresArray: [Int] = [75, 45, 109, 11]

var teamScoreVar: Int = 0

for individualScoreVar in numScoresArray {
    if individualScoreVar > 50 {
        teamScoreVar += 3
    } else {
        teamScoreVar += 1
    }
}

let nickName: String? = nil

let fullName: String = "Sandres"

let info = nickName ?? fullName

let numbersDictionary = [
    "Primo": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Quadrado": [1, 4, 9, 16,25]
]

var largest = 0

for (_, numbers) in numbersDictionary {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}

print("O maior número é: \(largest)")
