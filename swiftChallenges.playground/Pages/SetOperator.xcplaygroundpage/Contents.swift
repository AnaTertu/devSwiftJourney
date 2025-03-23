import Foundation

// interSection - seleciona valores que são =s entre o conj A(1234) e B(3456) = A.interSection(B) (34)

let a: Set<Int> = [1, 2, 3, 4]
let b: Set<Int> = [3, 4, 5, 6]

print("Interseção: \(a.intersection(b).sorted())")

// symetricDifference() - seleciona os valores diferentes entre A(1234) e B(3456) = A.symetricDifference(B) (1256)

print("SymetricDifference: \(a.symmetricDifference(b).sorted())")

//uinin seleciona todos os valores de ambos os conj A(1234) e B(3456) = A.union(B) (123456)

print("União: \(a.union(b).sorted())")

//subtracting subtrai os valores que são =s entre o conj A(1234) e B(3456) e subtrai todos os de B = A.subtracting(B) (12)

print("Subtração: \(a.subtracting(b).sorted())")

// (A(B))C)
