//
//  CreateDriverView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 19/06/2023.
//

import SwiftUI

struct CreateDriverView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var surename = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var car = ""
    @State private var image = "Adam"
    @State private var showAlert = false
    
    private var photos = ["Adam", "Mateusz", "Włodzimierz", "Jakub", "Beata", "Krystyna"]
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Surename", text: $surename)
                TextField("Phone Number", text: $phoneNumber)
                TextField("Email address", text: $email)
                TextField("Car", text: $car)
                Picker("Photo", selection: $image) {
                    ForEach(photos, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text("Driver data")
            }
            
            Section {
                Button {
                    validate()
                } label: {
                    Text("Save")
                }
            }
        }
        .navigationTitle("Create driver account")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid data"), dismissButton: .cancel())
        }
    }
    
    func validate() {
        let regexName = try! NSRegularExpression(pattern: "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčćšśžŚÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$")
        let regexMail = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        let regexNumber  = try! NSRegularExpression(pattern: "^\\d{3}\\d{3}\\d{3}$", options: [.caseInsensitive])
        
        if (regexName.firstMatch(in: name, options: [], range: NSRange(location: 0, length: name.utf16.count)) != nil) && (regexName.firstMatch(in: surename, options: [], range: NSRange(location: 0, length: surename.utf16.count)) != nil) && (regexMail.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil) && (regexNumber.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.utf16.count)) != nil) {
            
            let newDriver = Driver(context: viewContext)
            newDriver.id = UUID()
            newDriver.name = name
            newDriver.surename = surename
            newDriver.phoneNumber = phoneNumber
            newDriver.email = email
            newDriver.car = car
            newDriver.image = image
            
            try? viewContext.save()
        } else {
            showAlert = true
        }
    }
}

struct CreateDriverView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDriverView()
    }
}
