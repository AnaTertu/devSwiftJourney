import Foundation

var greeting = "Hello, World! Hello, playground"

var implicitInterger = 42

let constantImplicitInterger = 4

let constantExplicitFloat: Float = 3.14

let constantExplicitDouble: Double = 3.14159

let constantExplicitString: String = "Hello, World! "

let constantExplicitBool: Bool = true

var mutableExplicitString: String = "Hello, World! "

mutableExplicitString += " Hellow, playground!"

print(mutableExplicitString)

let explicitArray: [Int] = [1, 2, 3]

let whdthLabel = mutableExplicitString + String(constantExplicitFloat)

let fuitsSummary = """
There are \(explicitArray.count) fruits in total and apples
 \(implicitInterger + constantImplicitInterger / 2) are eaten.
"""

var implicitFruitsArray = ["Bananas", "Apple", "Oranges", "Morangos", "uvas"]
implicitFruitsArray[3] = "Strawberries"
implicitFruitsArray.remove(at: 4)
implicitFruitsArray.append("Pineapple")

var explicitFruitsArray: [String] = ["Bananas", "Apple", "Oranges", "Morangos", "uvas"]
explicitFruitsArray[3] = "Strawberries"
explicitFruitsArray.remove(at: 4)
explicitFruitsArray.append("Pineapple")

var explicitFruitsDictionary: [String: Int] = ["Bananas": 1, "Apple": 2, "Oranges": 3, "Morangos": 4, "uvas": 5]
explicitFruitsDictionary["Strawberries"] = 6
explicitFruitsDictionary.removeValue(forKey: "uvas")

var initVoidExplicitFruitsArray: [String] = []
var initVoidExplicitFruitsDictionary: [String: Int] = [:]

implicitFruitsArray = []
explicitFruitsDictionary = [:]





