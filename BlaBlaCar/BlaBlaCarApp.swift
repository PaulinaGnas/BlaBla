//
//  BlaBlaCarApp.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 28/05/2023.
//

import SwiftUI

@main
struct BlaBlaCarApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("UserTheme") var th = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(th ? .dark : .light)
        }
    }
}
