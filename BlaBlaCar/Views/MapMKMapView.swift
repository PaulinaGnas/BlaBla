//
//  MapMKMapView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 30/05/2023.
//

import MapKit
import SwiftUI
import CoreData

struct MapMKMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    private var moc = PersistenceController.shared.container.viewContext
    var cities: [CityData] = []
    
    init(ride: Ride) {
        cities = ride.cityArray
    }
    
    //MARK: - UIViewRepresentable protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.00, longitude: 21.00), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: cities.first!.coordinate)
        let p2 = MKPlacemark(coordinate: cities.last!.coordinate)
        
        let p1Annotation = MKPointAnnotation()
        p1Annotation.coordinate = cities.first!.coordinate
        p1Annotation.title = cities.first!.name
        mapView.addAnnotation(p1Annotation)
        
        let p2Annotation = MKPointAnnotation()
        p2Annotation.coordinate = cities.last!.coordinate
        p2Annotation.title = cities.last!.name
        mapView.addAnnotation(p2Annotation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }
        return mapView
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let rendered = MKPolylineRenderer(overlay: overlay)
            rendered.strokeColor = .systemBlue
            rendered.lineWidth = 5
            return rendered
        }
    }
}
