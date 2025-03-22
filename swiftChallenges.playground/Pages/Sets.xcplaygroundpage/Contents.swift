import UIKit
//Sets - armazena valores distintos do mesmo tip em coleções não ordenadas de valores únicos - QDO PRECISA GARANTIR Q O ITEM APAREÇA UMA ÚNICA VEZ, usar set em vez de array qdo a ordem não importar

// Mesma forma Set<Tipo>

var set1: Set<Int> = []
set1.insert(1)
set1.insert(2)
set1.insert(1)

print(set1)

var letters = Set<Character>() // inicializa

letters.insert("a")
letters.insert("b")
letters.insert("a")

letters = ["a", "b", "c", "a"].reduce(into: Set<Character>()) { result, char in
    result.insert(char)
}

