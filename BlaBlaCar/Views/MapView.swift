//
//  MapView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI

struct MapView: View {
    
    var ride: Ride
    
    var body: some View {
        VStack {
            Text("\(ride.startCity!) - \(ride.endCity!)")
            MapMKMapView(ride: ride)
        }
    }
}
