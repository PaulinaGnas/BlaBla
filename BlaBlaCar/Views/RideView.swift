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
        VStack(alignment: .leading) {
            Text("\(cityOne.first?.name ?? "") - \(cityTwo.first?.name ?? "")")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 2)
            
            Text("\(date.formatted(date: .abbreviated , time: .omitted))   \(date.formatted(date: .omitted , time: .shortened))")
            HStack{
                Image(driver.first?.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                Text("\(driver.first?.name ?? "") \(driver.first?.surename ?? "")")
            }
        }
    }
}

//struct RideView_Previews: PreviewProvider {
//    static var previews: some View {
//        RideView()
//    }
//}
