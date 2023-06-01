//
//  RideCreator.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI

struct RideCreator: View {
    
    //MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    let cities: [City] = Bundle.main.decode("Cities.json")
    
    @State private var startCity = City(name: "", latitude: 0, longitude: 0)
    @State private var endCity = City(name: "", latitude: 0, longitude: 0)
    
    @State private var driver = Drivers(name: "", surename: "", phoneNumber: "", email: "", car: "", image: "")
    @State private var date = Date.now
    
    
    //MARK: - FUNCTIONS
    
    func saveRide() {
        
        let newRide = Ride(context: moc)
        newRide.id = UUID()
        newRide.startCity = startCity.name
        newRide.endCity = endCity.name
        newRide.date = date
        
        newRide.rideDriver = Driver(context: moc)
        newRide.rideDriver?.name = driver.name
        newRide.rideDriver?.surename = driver.surename
        newRide.rideDriver?.email = driver.email
        newRide.rideDriver?.phoneNumber = driver.phoneNumber
        newRide.rideDriver?.car = driver.car
        newRide.rideDriver?.image = driver.image
        newRide.rideDriver?.id = UUID()
        
        let cityOne = CityData(context: moc)
        cityOne.name = startCity.name
        cityOne.longitude = startCity.longitude
        cityOne.latitude = startCity.latitude
        cityOne.cityRide = newRide
        cityOne.id = UUID()
        
        let cityTwo = CityData(context: moc)
        cityTwo.name = endCity.name
        cityTwo.longitude = endCity.longitude
        cityTwo.latitude = endCity.latitude
        cityTwo.cityRide = newRide
        cityTwo.id = UUID()
        
        do {
            try moc.save()
            print("yep")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            Picker("Select starting point", selection: $startCity) {
                ForEach(cities, id: \.self) {
                    Text($0.name)
                }
            }
            Text("\(startCity.name)")
            
            Picker("Selects destination", selection: $endCity) {
                ForEach(cities, id: \.self) {
                    Text($0.name)
                }
            }
            Text("\(endCity.name)")
            
            DatePicker(selection: $date, displayedComponents: [.date, .hourAndMinute]) {
                Text("Select a date")
            }
            
            Text("Date is \(date.formatted(date: .long, time: .complete))")
            
            Picker("Driver", selection: $driver) {
                ForEach(drivers, id: \.self) {
                    Text($0.name)
                }
            }
            Text("\(driver.name)")
            
            Image(driver.image)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Button {
                saveRide()
                dismiss()
            } label: {
                Text("Save")
            }
        }
        .onAppear {
            startCity = cities.first!
            endCity = cities.last!
            driver = drivers.first!
        }
    }
}


struct RideCreator_Previews: PreviewProvider {
    static var previews: some View {
        RideCreator()
    }
}
