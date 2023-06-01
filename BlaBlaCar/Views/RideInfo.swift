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
                     
            Text("Ride info")
            Text("\(ride.startCity ?? "") - \(ride.endCity ?? "")" )
       
            Button {
                showDriver = true
            } label: {
                Text("pokaz kierowce")
            }
            Button {
                isPresented = true
            } label: {
                Text("pokaz mape")
            }
        }
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
