//
//  ContentView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var rides: FetchedResults<Ride>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", "Adam")) private var driver: FetchedResults<Driver>
    @State private var userName = UserDefaults.standard.string(forKey: "Name") ?? "John"
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { rides[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    if rides.count != 0 {
                        List {
                            ForEach(rides) { ride in
                                NavigationLink(destination: RideInfo(ride: ride)) {
                                    RideView(ride)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    } else {
                        Text("\(userName) dodaj swoje przejazdy!")
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            ZStack {
                                Circle()
                                    .stroke(.blue, lineWidth: 2)
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding()
                        
                        NavigationLink(destination: CreateDriverView()) {
                            ZStack {
                                Circle()
                                    .stroke(.blue, lineWidth: 2)
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "person.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        NavigationLink(destination: RideCreator()) {
                            ZStack {
                                Circle()
                                    .stroke(.blue, lineWidth: 2)
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(Text("Choose your ride"))
        }
    }
}
