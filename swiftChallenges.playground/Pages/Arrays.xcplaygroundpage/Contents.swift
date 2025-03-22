//: Arrays - coleções ordenadas de valores

let abreviadoArray: [String] = []
var mutableArray: Array<String> = []

mutableArray.append("A")
mutableArray.append("B")
mutableArray.append("C")

mutableArray.remove(at: 1)
mutableArray.count
mutableArray.isEmpty
mutableArray.first
mutableArray.last
mutableArray.dropFirst()
mutableArray.dropLast()
mutableArray.prefix(2)
mutableArray.suffix(2)
mutableArray.joined()


var someInts: [Int] = []

someInts.append(contentsOf: [1, 2, 3])

var threeDoubles = Array(repeating: 0.0, count: 3)
var threeDouble = Array(repeating: 2.5, count: 3)
var sixDouble = threeDouble + threeDouble

var shoppingList: [String] = ["Bananas", "Apples", "Oranges"]
shoppingList.append("Avocado")
shoppingList.append(contentsOf: ["Milk", "Eggs"])
shoppingList.insert("Granola bars", at: 0)
shoppingList.remove(at: 1)
shoppingList.removeLast()
shoppingList.count
shoppingList.isEmpty

shoppingList.sorted()
shoppingList.reversed()

shoppingList += ["Bread", "Cheese"]
shoppingList.joined(separator: ", ")

shoppingList[0] = "Banana matura"
shoppingList[5...6] = ["Brad", "Chease"]

shoppingList

for intem in shoppingList {
    print(intem)
}

for (index, item) in shoppingList.enumerated() {
    print("Item \(index + 1): \(item)")
}

