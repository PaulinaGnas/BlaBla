import Foundation

struct Drivers: Hashable{
    let name: String
    let surename: String
    let phoneNumber: String
    let email: String
    let car: String
    let image: String
}

let drivers: [Drivers] = [
    Drivers(name: "Adam", surename: "Kowalski", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam"),
    Drivers(name: "Adam1", surename: "Kowalski1", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam"),
    Drivers(name: "Adam2", surename: "Kowalski2", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam"),
    Drivers(name: "Adam3", surename: "Kowalski3", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam"),
    Drivers(name: "Adam4", surename: "Kowalski4", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam"),
    Drivers(name: "Adam5", surename: "Kowalski5", phoneNumber: "123456789", email: "poczta@poczta.com", car: "opel",image: "Adam")
]

