//
//  DriverView.swift
//  BlaBlaCar
//
//  Created by Paulina Gnas on 29/05/2023.
//

import SwiftUI

struct DriverView: View {
    let driver: Driver
    
    var body: some View {
        VStack{
            Text(driver.name!)
            Text(driver.surename!)
            Text(driver.phoneNumber!)
            Text(driver.email!)
            Text(driver.car!)
            Image(driver.image!)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
        }
    }
}

//struct DriverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DriverView()
//    }
//}
