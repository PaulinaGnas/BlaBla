//
//  DriverView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 29/05/2023.
//

import SwiftUI

struct DriverView: View {
    
    let driver: Driver
    @State private var showSheet = false
    
    var body: some View {
        VStack{
            Image(driver.image!)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 9)
                .onLongPressGesture {
                    showSheet = true
                }
            Text("\(driver.name!) \(driver.surename!)")
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack{
                    Image(systemName: "phone.fill")
                    Text(driver.phoneNumber!)
                        .font(.title2)
                }
                HStack{
                    Image(systemName: "envelope.fill")
                    Text(driver.email!)
                        .font(.title2)
                }
                HStack{
                    Image(systemName: "car.fill")
                    Text(driver.car!)
                        .font(.title2)
                }
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            PictureView(driver: driver)
        }
    }
}
