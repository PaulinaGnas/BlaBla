//
//  RideInfo.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 29/05/2023.
//

import SwiftUI

struct RideInfo: View {
    
    //MARK: - PROPERTIES
    
    let ride: Ride
    @State private var isPresented = false
    @State private var showDriver = false
    @State private var showChangeDriver = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Text("\(ride.startCity ?? "") - \(ride.endCity ?? "")" ).font(.title).fontWeight(.bold).padding(.bottom)
            Text("\(ride.date!.formatted(date: .abbreviated , time: .omitted))   \(ride.date!.formatted(date: .omitted , time: .shortened))").font(.title2).padding(.bottom)
            HStack {
                Spacer()
                Button {
                    showDriver = true
                } label: {
                    HStack{
                        Text("Driver")
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding(10)
                    .overlay(Capsule().stroke(.blue,lineWidth: 2))
                }
                Spacer()
                Button {
                    isPresented = true
                } label: {
                    HStack{
                        Text("Map")
                        Image(systemName: "map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding(10)
                    .overlay(Capsule().stroke(.blue,lineWidth: 2))
                }
                Spacer()
            }
        }
        .navigationTitle(  Text("Ride info"))
        .sheet(isPresented: $isPresented) {
            MapView(ride: ride)
        }
        .sheet(isPresented: $showDriver) {
            DriverView(driver: ride.rideDriver!)
        }
    }
}

//struct RideInfo_Previews: PreviewProvider {
//    static var previews: some View {
//       /RideInfo()
//    }
//}
