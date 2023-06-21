//
//  AddCityView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 18/06/2023.
//

import SwiftUI
import MapKit

struct AddCityView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CityData>
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.6836, longitude: 18.7297), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State var isAddTownActive = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "car.circle")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 30, height: 30)
                            .background(.white)
                            .clipShape(Circle())

                        Text(location.name ?? "no name")
                            .fixedSize()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        isAddTownActive = true
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
            
            if isAddTownActive {
                BlankView()
                    .onTapGesture {
                        isAddTownActive = false
                    }
                AddCityNameView(isAddTownActive: $isAddTownActive, longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
            }
        }
    }
}
