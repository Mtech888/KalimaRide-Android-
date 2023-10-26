//
//  Chat.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct Chat: View {
    var body: some View {
        VStack {
            CustomNavbar(title: "Chat")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            
            ScrollView {
                VStack{
                    NavigationLink(destination: UsersChats()) {
                        NotificationCard(cardImage: "navProfileIcon", userDescription: "Jhon Smith", driverResponse: "You: Hello how are you?")
                    }
                    
                    NotificationCard(cardImage: "navProfileIcon", userDescription: "Jhon Smith", driverResponse: "You: Hello how are you?")
                }
                .padding()
                
            }
            
        }
        .ignoresSafeArea()
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
