import Foundation

public class Coordinate {
    public var latitude: Float?
    public var longitude: Float?
    
    public init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public class Person {
    public var name: String = "John Doe"
    public var address: String = "C/ María Martillo"
    public var homeCoordinate: Coordinate?
    
    public init(name: String) {
        self.name = name
    }
}