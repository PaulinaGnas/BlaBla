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
    
    //MARK: - PROPERTIES
    
    private var moc = PersistenceController.shared.container.viewContext
    var cities: [CityData] = []
    
    //MARK: - FUNCTIONS
    
    init(ride: Ride) {
        fetchData(ride: ride)
    }
    
    mutating func fetchData(ride: Ride) {
        let request = NSFetchRequest<CityData>(entityName: "CityData")
        request.predicate = NSPredicate(format: "cityRide == %@", ride)
        
        do {
            cities = try moc.fetch(request)
        } catch {
            print("")
        }
    }
    
    
    //MARK: - UIViewRepresentable protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.00, longitude: 21.00), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: cities.first!.latitude, longitude: cities.first!.longitude))
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: cities.last!.latitude, longitude: cities.last!.longitude))
        
        let p1name = MKPointAnnotation()
        let p2name = MKPointAnnotation()
        
        p1name.title = cities.first!.name
        p1name.coordinate = CLLocationCoordinate2D(latitude: cities.first!.latitude, longitude:  cities.first!.longitude)
        mapView.addAnnotation(p1name)
        
        p2name.title = cities.last!.name
        p2name.coordinate = CLLocationCoordinate2D(latitude: cities.last!.latitude, longitude:  cities.last!.longitude)
        mapView.addAnnotation(p2name)
        
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
