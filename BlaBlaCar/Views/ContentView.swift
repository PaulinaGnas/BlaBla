//
//  ContentView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var rides: FetchedResults<Ride>
    let cities: [City] = Bundle.main.decode("Cities.json")
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", "Adam")) private var driver: FetchedResults<Driver>
    //MARK: - FUNCTIONS
    
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
    
    
    //MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    if rides.count != 0 {
                        List{
                            ForEach(rides) { ride in
                                NavigationLink(destination: RideInfo(ride: ride)) {
                                    RideView(filterOne: ride.startCity ?? "", filterTwo: ride.endCity ?? "",filerThree: ride)
                                }
                                //image magnification gesture
                                //walidajca
                                //profil edit getture
                                //poprawic UI
                                //dark theme
                                //tworzenie proilu przy wlaczeniu
                                //edycja tego profilu przy przytrzymaniu ikony z profilu
                            }
                            .onDelete(perform: deleteItems)
                        }
                    } else {
                        Text("Imie uzytkownika dodja swoje przejazdy")
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: RideCreator()) {
                            ZStack {
                                Circle()
                                    .stroke(.blue, lineWidth: 2)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
