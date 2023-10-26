//
//  SideMenu.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI

struct MenuContent: View {
    @StateObject private var logoutApi = LogoutAPIMethod()
    @State private var userDataApi = LoadUserDataAPIMethod()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
            VStack(alignment: .leading) {
                VStack(spacing: 5) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)
                        WebImage(url: URL(string: "\(userDataApi.image)"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .cornerRadius(50)
                    }
                    
                    Text(userDataApi.firstName + " " + userDataApi.lastName)
                        .font(.custom(Font.medium, size: 18))
                        .padding(.top)
                    Text(userDataApi.email)
                        .foregroundColor(Color(.systemGray))
                        .font(.custom(Font.regular, size: 13))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 40)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Image("search-dark")
                        Text("Search")
                            .font(.custom(Font.medium, size: 16))
                            .padding(.leading, 40)
                        Spacer()
                        Image("rightIcon")
                    }
                    
                    NavigationLink(destination: Booking()) {
                        HStack {
                            Image("doc-icon")
                            Text("My Bookings")
                                .font(.custom(Font.medium, size: 16))
                                .padding(.leading, 40)
                            Spacer()
                            Image("rightIcon")
                        }
                    }
                    
                    NavigationLink(destination: MyRides()) {
                        HStack {
                            Image("car-icon")
                            Text("My Rides")
                                .font(.custom(Font.medium, size: 16))
                                .padding(.leading, 40)
                            Spacer()
                            Image("rightIcon")
                        }
                    }
                    
                    HStack {
                        Image("user-icon")
                        Text("My Profile")
                            .font(.custom(Font.medium, size: 16))
                            .padding(.leading, 40)
                        Spacer()
                        Image("rightIcon")
                    }
                    
                    HStack {
                        Image("starIcon")
                        Text("Rate Us")
                            .font(.custom(Font.medium, size: 16))
                            .padding(.leading, 40)
                        Spacer()
                        Image("rightIcon")
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.medium)
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    logoutApi.logout()
                } label: {
                    HStack {
                        Image("logoutIcon")
                        Text("Logout")
                            .font(.custom(Font.medium, size: 16))
                            .padding(.leading, 40)
                        Spacer()
                        Image("rightIcon")
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                    .fontWeight(.medium)
                }
                .foregroundColor(.black)
                
                NavigationLink(destination: SignIn(), isActive: $logoutApi.navigate) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .onAppear {
                userDataApi.showLoader = true
                userDataApi.loadUserData()
            }
            
            if logoutApi.showloader {
                ActivityIndicatorView(isVisible: $logoutApi.showloader, type: .arcs())
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Color.theme.appColor)
            }
        }
        .ignoresSafeArea()
    }
}

struct SideMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                toggleMenu()
            }
            
            HStack {
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(width: 320, menuOpened: true, toggleMenu: {})
    }
}
