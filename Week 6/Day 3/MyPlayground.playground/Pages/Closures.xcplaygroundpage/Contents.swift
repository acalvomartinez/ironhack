//: [Previous](@previous)

import Foundation

let tesla = Person(name: "Nikola Tesla")
tesla.address = "Madrid"
let einstein = Person(name: "Einstein")
einstein.address = "A Coruña"
let bohr = Person(name: "Niels Börh")
bohr.address = "Madrid"
let schrodinger = Person(name: "Schrodinger")
schrodinger.address = "Málaga"

let people = [tesla, einstein, bohr, schrodinger]

for p in people where p.address == "Madrid" {
    print("\(p.name) vive en \(p.address)")
}

// trailing closure

people.map {
    print("\($0.name) vive en \($0.address)")
}

people.map {
    $0.address = "Sevilla"
    print("\($0.name) vive en \($0.address)")
}

func operation(a: Int, b: Int) -> () -> Int {
    let f1 = { () -> Int in
        return a+b
    }
    let f2 = { () -> Int in
        return a*b
    }
    
    if a == 2 {
        return f1
    }
    
    return f2
}

operation(10, b: 20)()
operation(2, b: 20)()



//: [Next](@next)
