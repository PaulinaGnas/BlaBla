//
//  RideCreator.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI

struct RideCreator: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var cities: FetchedResults<CityData>
    @FetchRequest(sortDescriptors: []) private var drivers: FetchedResults<Driver>
    
    @State private var date = Date.now
    @State private var showErr = false
    @State private var startCity = CityData()
    @State private var endCity = CityData()
    @State private var selectedDriver = Driver()
    @State private var image: Image?
    
    func saveRide() {
        if startCity == endCity {
            showErr = true
            
        } else {
            let newRide = Ride(context: moc)
            newRide.id = UUID()
            newRide.date = date
            newRide.startCity = startCity.name
            newRide.endCity = endCity.name
            newRide.addToRideCity(startCity) // dodawanie miasta do relacji
            newRide.addToRideCity(endCity)
            newRide.date = date
            newRide.rideDriver = selectedDriver
            
            do {
                try moc.save()
            } catch {
                print("Cannot save ride.")
            }
        }
    }
    
    var body: some View {
        ZStack{
            if cities.count != 0 && drivers.count != 0 {
                Form {
                    Section{
                        Picker("Select starting point", selection: $startCity) {
                            if cities.count != 0 {
                                ForEach(cities) { city in
                                    Text(city.name ?? "").tag(city)
                                }
                            } else {
                                Text("Add city")
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Picker("Select destination", selection: $endCity) {
                            if cities.count != 0 {
                                ForEach(cities) { city in
                                    Text(city.name ?? "").tag(city)
                                }
                            } else {
                                Text("Add city")
                            }
                        }
                        .pickerStyle(.menu)
                        
                        DatePicker(selection: $date, displayedComponents: [.date, .hourAndMinute]) {
                            Text("Select a date")
                        }
                    } header: {
                        Text("Ride settings")
                    }
                    
                    Section {
                        Picker("Driver", selection: $selectedDriver) {
                            if drivers.count != 0 {
                                ForEach(drivers) { driver in
                                    Text("\(driver.name!) \(driver.surename!)").tag(driver)
                                }
                            } else {
                                Text("No drivers available")
                            }
                        }
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                        
                    } header: {
                        Text("Select driver")
                    }
                    .onChange(of: selectedDriver) { _ in
                        image = Image(selectedDriver.image!)
                    }
                }
                .navigationTitle(Text("Create ride"))
                .onAppear {
                    if cities.count != 0 {
                        startCity = cities.first!
                        endCity = cities.last!
                    }
                    if drivers.count != 0 {
                        selectedDriver = drivers.first!
                        image = Image(drivers.first!.image!)
                    }
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
            } else {
                Text("No cities or drivers available.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddCityView()) {
                    Text("Add city")
                }
            }
        }
        .alert(isPresented: $showErr) {
            Alert(title: Text("Invalid data"), message: Text("The start and end of the route cannot be the same."), dismissButton: .default(Text("Got it!")))
        }
    }
}


struct RideCreator_Previews: PreviewProvider {
    static var previews: some View {
        RideCreator()
    }
}
