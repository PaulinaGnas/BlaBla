//
//  CitiesSettings.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 21/06/2023.
//

import SwiftUI

struct CitiesSettings: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var cities: FetchedResults<CityData>
    
    func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { cities[$0] }.forEach(moc.delete)
            
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(cities) { city in
                Text(city.name ?? "No name")
            }
            .onDelete(perform: deleteItem)
        }
        
    }
}
