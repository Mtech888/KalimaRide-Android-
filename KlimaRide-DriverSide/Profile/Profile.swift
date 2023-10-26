//
//  Profile.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct Profile: View {
    @StateObject var userDataApi = LoadUserDataAPIMethod()
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavbar(title: "My Profile")
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1),
                                           radius: 5,
                                           x: 0,
                                           y: 5)
                    )
                    .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: Color.black.opacity(0.2),
                                            radius: 5,
                                            y: 5)
                                WebImage(url: URL(string: "\(userDataApi.image)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(50)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(userDataApi.firstName + " " + userDataApi.lastName)
                                    .font(.custom(Font.medium, size: 25))
                                
                                HStack {
                                    Image("phone-icon")
                                    
                                    Text(userDataApi.phoneNumber)
                                        .font(.custom(Font.medium, size: 13))
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .background(Color(.systemGray6))
                                .cornerRadius(5)
                            }
                        }
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 30) {
                            NavigationLink(destination: Booking()) {
                                ProfileInfo(image: "calendar-dark",
                                            title: "My Bookings",
                                            description: "Manage your bookings")
                            }
                            
                            NavigationLink(destination: MyRides()) {
                                ProfileInfo(image: "location-dark",
                                            title: "My Rides",
                                            description: "Manage your rides")
                            }
                            NavigationLink(destination: MyVehicles()) {
                                ProfileInfo(image: "vehicle-icon",
                                            title: "My Vehicle",
                                            description: "Add your Vehicles")
                            }
                            
                            NavigationLink(destination: Wallet()) {
                                ProfileInfo(image: "wallet-icon",
                                            title: "Wallet",
                                            description: "Withdraw your earnings")
                            }
                            
                            NavigationLink(destination: EditProfile().environmentObject(userDataApi)) {
                                ProfileInfo(image: "personIcon",
                                            title: "Profile Information",
                                            description: "Change your account info")
                            }
                            
                            NavigationLink(destination: ChangePassword()) {
                                ProfileInfo(image: "lockIcon",
                                            title: "Change Password",
                                            description: "Change your password")
                            }
                            
                            NavigationLink(destination: ChangePassword()) {
                                ProfileInfo(image: "globe",
                                            title: "Language",
                                            description: "Change language")
                            }
                        }
                        .padding()
                    }
                    .onAppear {
                        userDataApi.showLoader = true
                        userDataApi.loadUserData()
                    }
                }
            }
            
            if userDataApi.showLoader {
                ActivityIndicatorView(isVisible: $userDataApi.showLoader, type: .arcs())
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Color.theme.appColor)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
