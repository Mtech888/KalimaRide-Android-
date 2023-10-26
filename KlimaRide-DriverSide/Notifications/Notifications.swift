//
//  Notifications.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct Notifications: View {
    var body: some View {
        VStack {
            CustomNavbar(title: "Notifications")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
            
            ScrollView {
                VStack {
                    NotificationCard(cardImage: "navProfileIcon", userDescription: "Message Form", driverResponse: "James: Sure")
                }
                .padding(.horizontal)
            }
        }
//        .padding()
        .ignoresSafeArea()
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
