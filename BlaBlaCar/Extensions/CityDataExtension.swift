//
//  CityDataExtension.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 21/06/2023.
//

import Foundation
import MapKit

extension CityData {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
