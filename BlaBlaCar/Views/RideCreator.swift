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
    @State private var showErr = false
    
    //MARK: - FUNCTIONS
    
    func saveRide() {
        if startCity == endCity {
            showErr = true
            
        } else {
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
    }
    
    
    //MARK: - BODY
    
    var body: some View {
        ZStack{
            Form {
                Section{
                    Picker("Select starting point", selection: $startCity) {
                        ForEach(cities, id: \.self) {
                            Text($0.name)
                        }
                    }
                    
                    Picker("Selects destination", selection: $endCity) {
                        ForEach(cities, id: \.self) {
                            Text($0.name)
                        }
                    }
                    
                    DatePicker(selection: $date, displayedComponents: [.date, .hourAndMinute]) {
                        Text("Select a date")
                    }
                } header: {
                    Text("Ride settings")
                }
                
                Section{
                    Picker("Driver", selection: $driver) {
                        ForEach(drivers, id: \.self) {
                            Text($0.name)
                        }
                    }
                } header: {
                    Text("Select driver")
                }
                
                Section{
                    HStack{
                        Spacer()
                        Image(driver.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                        Spacer()
                    }
                } header: {
                    Text("Driver photo")
                }
            }
            .navigationTitle(Text("Create ride"))
            .onAppear {
                startCity = cities.first!
                endCity = cities.last!
                driver = drivers.first!
            }
            
            VStack{
                Spacer()
                Button {
                    saveRide()
                    if !showErr {
                        dismiss()
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .stroke(.blue, lineWidth: 2)
                            .frame(width: 100, height: 40)
                        HStack{
                            Text("Save")
                                .font(.system(size: 20))
                            Image(systemName: "chevron.forward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                        }
                    }
                }
                .padding()
                .disabled(showErr)
            }
        }
        .alert(isPresented: $showErr) {
            Alert(title: Text("Invalid data"), message: Text("Starting city is the same as the destination"), dismissButton: .cancel())
        }
    }
}


struct RideCreator_Previews: PreviewProvider {
    static var previews: some View {
        RideCreator()
    }
}
