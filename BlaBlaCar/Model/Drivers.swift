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
    Drivers(name: "Adam", surename: "Kowalski", phoneNumber: "672851882", email: "adam@poczta.com", car: "Opel Astra",image: "Adam"),
    Drivers(name: "Mateusz", surename: "Nowak", phoneNumber: "662211001", email: "mateusz01@poczta.com", car: "Nissan Micra",image: "Mateusz"),
    Drivers(name: "Włodzimierz", surename: "Lewandowski", phoneNumber: "421127885", email: "wlodek75@poczta.com", car: "Volkswagen Passat",image: "Włodzimierz"),
    Drivers(name: "Jakub", surename: "Nowakowski", phoneNumber: "452888020", email: "jacob@poczta.com", car: "Toyota Yaris",image: "Jakub"),
    Drivers(name: "Beata", surename: "Adamczyk", phoneNumber: "322990678", email: "beata@poczta.com", car: "Citroen Picasso",image: "Beata"),
    Drivers(name: "Krystyna", surename: "Kowalik", phoneNumber: "233783521", email: "krystyna1123@poczta.com", car: "Renault Megane",image: "Krystyna")
]

