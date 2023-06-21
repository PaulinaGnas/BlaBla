//
//  DriversSettings.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 21/06/2023.
//

import SwiftUI

struct DriversSettings: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var drivers: FetchedResults<Driver>
    
    func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { drivers[$0] }.forEach(moc.delete)
            
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
            ForEach(drivers) { driver in
                HStack {
                    Image(driver.image ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("\(driver.name ?? "No name") \(driver.surename ?? "No surename")")
                }
            }
            .onDelete(perform: deleteItem)
        }
    }
}
