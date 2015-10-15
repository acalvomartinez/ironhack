/*:

# Switch in Swift

> Here your comments

* examples
* fun
* more fun
* wow, such fun, many code

[Visit GitHub!](https://www.github.com)

*/

var toni = Person(name: "Toni")

toni.name

let i = 10

// Has to cover all possibilities

switch i {
case 1:
    print("1")
case 2...4:
    print("2")
case 10:
    print("10")
default:
    print("others")
}


switch i {
case let x where x > 100 && x < 199:
    print("Equis \(x)")
case 2...4:
    print("2")
case 10:
    print("10")
default:
    print("others")
}


let name = "Diego Freniche"

switch name {
    case "Diego":
        print("Diego")
    case "":
        print("vacio")
default:
    break;
}

switch name {
case let x where x.hasSuffix("Freniche"):
    print("Diego")
case "":
    print("vacio")
default:
    break;
}

let schema = "https://"

switch schema {
case let x where x.hasPrefix("http"):
        print("HTTP")
default:
    print("\(schema) Unknown")
}

//: Enums

enum Schemas: String {
    case http = "http://"
    case https = "https://"
    case irc = "irc://"
    case ftp = "ftp://"
}

enum Days: String {
    case mon = "Monday"
    case tue = "Tuesday"
    case wed = "Wednesday"
    case thu = "Thursday"
    case fri = "Friday"
}

let day = Days.tue

switch day {
case .mon, .tue:
    print("Bad")
case .wed, .thu:
    print("middle bad")
case let name where day.rawValue.hasSuffix("day"):
    print("Yeah")
default:
    print("")
}


for i in 1...100 where i%2==0 {
    print("\(i)")
}

