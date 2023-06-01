//
//  RideView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 30/05/2023.
//

import SwiftUI

struct RideView: View {
    
    //MARK: - PROPERTIES
    
    @FetchRequest var cityOne: FetchedResults<CityData>
    @FetchRequest var cityTwo: FetchedResults<CityData>
    @FetchRequest var driver: FetchedResults<Driver>
    private var date: Date
    
    
    //MARK: - FUNCTIONS
    
    init(filterOne: String, filterTwo: String, filerThree: Ride) {
        _cityOne = FetchRequest<CityData>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filterOne))
        _cityTwo = FetchRequest<CityData>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filterTwo))
        _driver = FetchRequest<Driver>(sortDescriptors: [],predicate: NSPredicate(format: "driverRide == %@", filerThree))
        date = filerThree.date!
    }
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            Text("Starting location: \(cityOne.first?.name ?? "")")
            Text("Destination: \(cityTwo.first?.name ?? "")")
            Text("\(date.formatted(date: .complete, time: .shortened))")
            HStack{
                Image(driver.first?.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                Text("Driver: \(driver.first?.name ?? "") \(driver.first?.surename ?? "")")
            }
        }
    }
}

//struct RideView_Previews: PreviewProvider {
//    static var previews: some View {
//        RideView()
//    }
//}
