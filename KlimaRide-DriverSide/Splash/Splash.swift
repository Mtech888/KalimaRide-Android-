//
//  Splash.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI

struct Splash: View {
    @State var success = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        Text("Klima")
                            .foregroundColor(.black)
                        Text("Ride")
                            .foregroundColor(Color.theme.appColor)
                    }
                    .font(.custom(Font.bold, size: 38))
                    .padding(.top, 30)
                    
                    Text("Tag Line Here")
                        .font(.custom(Font.regular, size: 18))
                }
                .padding(.top)
                
                Spacer()
                
                Image("splash-image")
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Welcome to KlimaRide Ride share service")
                        .font(.custom(Font.medium, size: 31))
                    
                    Text("Addressing Parking Challenges and Promoting Sustainability in Event Transportation and Social cohesion")
                        .font(.custom(Font.light, size: 15))
                }
                .foregroundColor(.primary)
                .padding(.top, 40)
                
                Spacer()
                
                    CustomButton(action: {
                        UserDefaults.standard.splashSaved = true
                        success = true
                    },
                                 title: "Get Started",
                                 background: Color.theme.appColor,
                                 foreground: .white)
                    .disabled(success)
                
                NavigationLink(
                    destination: SignIn(),
                    isActive: $success,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            }
            .padding()
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
