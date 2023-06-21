//
//  AddCityNameView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 21/06/2023.
//

import SwiftUI

struct AddCityNameView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var cities: FetchedResults<CityData>
    @Binding var isAddTownActive: Bool
    @State private var name = ""
    
    @State var longitude: Double
    @State var latitude: Double
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                    Button {
                        validateAndSaveTown()
                        isAddTownActive = false
                    } label: {
                        Text("Save")
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(9)
            }
            .padding()
            .shadow(radius: 24)
        }
    }
    
    func validateAndSaveTown() {
        if !name.isEmpty && !cities.contains(where: { $0.name == name }) {
            let newTown = CityData(context: moc)
            newTown.name = name
            newTown.latitude = latitude
            newTown.longitude = longitude
            newTown.id = UUID()
            
            do {
                try moc.save()
            } catch {
                print("Error occured while saving town.")
            }
        }
    }
}
