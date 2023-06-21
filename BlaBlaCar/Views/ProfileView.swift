//
//  ProfileView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 09/06/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var userName = UserDefaults.standard.string(forKey: "Name") ?? "John"
    @State var userSurname = UserDefaults.standard.string(forKey: "Surname") ?? "Doe"
    @State var userEmail = UserDefaults.standard.string(forKey: "Email") ?? "John123@gmail.com"
    @State var userPhoneNumber = UserDefaults.standard.string(forKey: "Number") ?? "123456789"
    
    @AppStorage("UserTheme") var theme = false
    
    @State var showAlert = false
    @State var message = ""
    
    func update() {
        userName = UserDefaults.standard.string(forKey: "Name") ?? ""
        userSurname = UserDefaults.standard.string(forKey: "Surname") ?? ""
        userEmail = UserDefaults.standard.string(forKey: "Email") ?? ""
        userPhoneNumber = UserDefaults.standard.string(forKey: "Number") ?? ""
    }
    
    func validate() {
        message = ""
        let regexName = try! NSRegularExpression(pattern: "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčćšśžŚÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$")
        let regexMail = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        let regexNumber  = try! NSRegularExpression(pattern: "^\\d{3}\\d{3}\\d{3}$", options: [.caseInsensitive])
        
        if regexName.firstMatch(in: userName, options: [], range: NSRange(location: 0, length: userName.utf16.count)) != nil {
            UserDefaults.standard.set(userName, forKey: "Name")
            
        } else {
            message += "\n Name"
            showAlert = true
        }
        
        if regexName.firstMatch(in: userSurname, options: [], range: NSRange(location: 0, length: userSurname.utf16.count)) != nil {
            UserDefaults.standard.set(userSurname, forKey: "Surname")
            
        } else {
            message +=  "\n Surname"
            showAlert = true
        }
        
        if regexMail.firstMatch(in: userEmail, options: [], range: NSRange(location: 0, length: userEmail.utf16.count)) != nil {
            UserDefaults.standard.set(userEmail, forKey: "Email")
            
        } else {
            message +=  "\n Email"
            showAlert = true
        }
        
        if regexNumber.firstMatch(in: userPhoneNumber, options: [], range: NSRange(location: 0, length: userPhoneNumber.utf16.count)) != nil {
            UserDefaults.standard.set(userPhoneNumber, forKey: "Number")
            
        } else {
            message +=  "\n Phone number"
            showAlert = true
        }
    }
    
    var body: some View {
        VStack{
            Form {
                Section{
                    TextField("Name", text: $userName)
                    TextField("Surename", text: $userSurname)
                    TextField("Phone Number", text: $userPhoneNumber)
                    TextField("email", text: $userEmail)
                } header: {
                    Text("User data")
                }
                
                Button("Save") {
                    validate()
                }
                
                Section {
                    NavigationLink(destination: CitiesSettings()) {
                        Text("City Settings")
                    }
                    NavigationLink(destination: DriversSettings()) {
                        Text("Driver Settings")
                    }
                    Toggle("Dark theme", isOn: $theme)
                } header: {
                    Text("App settings")
                }
            }
        }
        .navigationTitle("Your profile")
        .onAppear {
            update()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid data:"), message: Text(message), dismissButton: .cancel())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

