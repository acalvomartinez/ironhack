//: Playground - noun: a place where people can play
// REPL: Read Eval Print Loop

import Swift
import UIKit

var str = "Hello, Gallofa"

print(str)
print("Adios 😎")

var i = 11

var name: String = "Toni"

if i > 10 {
    print("i vale mayor 10")
} else {
    print("i es pequeñito")
}

for i in 1...10 {
    print ("i vale \( i*2 ) y el doble es \( i/2 )")
}

let 👍🏼 = true
let 👎🏼 = false

func sum(a: Int, b: Int) -> Int {
    return a + b
}

sum(40, b: 2)

func divide(n: Float, d: Float) -> (value: Float, hasError: Bool) {
    if d == 0 {
        return (0, 👎🏼)
    }
    return (n / d, 👍🏼)
}

divide(10.0, d: 2).value
divide(10.0, d: 2).hasError

class Coordinate {
    var latitude: Float?
    var longitude: Float?
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class Person {
    var name: String = "John Doe"
    var address: String = "C/ María Martillo"
    var homeCoordinate: Coordinate?
    
    init(name: String) {
        self.name = name
    }
}

let toni = Person(name: "Toni")

toni.name
toni.address

var s: String? = "Hola"
s = nil


toni.homeCoordinate = Coordinate(latitude: 10, longitude: 10)

toni.homeCoordinate?.longitude

/*
class Slave: Person {
    var master: Person
}
*/
