//
//  RideView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 30/05/2023.
//

import SwiftUI

struct RideView: View {
    
    private var date: Date
    private var startCity: CityData
    private var destination: CityData
    private var driver: Driver
    
    init(_ ride: Ride) {
        startCity = ride.cityArray.first(where: { $0.name == ride.startCity })!
        destination = ride.cityArray.first(where: { $0.name == ride.endCity })!
        driver = ride.rideDriver!
        date = ride.date!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(startCity.name ?? "") - \(destination.name ?? "")")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 2)
            
            Text("\(date.formatted(date: .abbreviated , time: .omitted))   \(date.formatted(date: .omitted , time: .shortened))")
            HStack{
                Image(driver.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                Text("\(driver.name ?? "") \(driver.surename ?? "")")
            }
        }
    }
}
