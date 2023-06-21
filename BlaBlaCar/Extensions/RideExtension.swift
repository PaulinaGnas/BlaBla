//
//  RideExtension.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 20/06/2023.
//

import Foundation

extension Ride {
    public var cityArray: [CityData] {
        let set = rideCity as? Set<CityData> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }
}
