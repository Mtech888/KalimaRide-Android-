//
//  TabBar.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab: Tab  = .search
    @State var menuOpened = false
    @StateObject var searchRide = SearchPostAPiMethod()

    
    var body: some View {
        ZStack {
            VStack {
                if selectedTab == .search {
                    VStack {
                            HStack {
                                Button {
                                    menuOpened.toggle()
                                } label: {
                                    Image("sidebar-icon")
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Image("nav-location-icon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                    
                                    Text("Hamburg, Germany")
                                        .foregroundColor(.primary)
                                        .font(.custom(Font.medium, size: 14))
                                    
                                    Image("down-icon")
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                            }
                            .padding()
                        
                        Search(searchRide: searchRide)
                    }
                } else if selectedTab == .shareRide {
                    ShareRide()
                } else if selectedTab == .notifications {
                    Notifications()
                } else if selectedTab == .inbox {
                    Chat()
                } else if selectedTab == .profile {
                    Profile()
                }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 0)
                    )
            }
            
            SideMenu(width: UIScreen.main.bounds.width / 1.3, menuOpened: menuOpened, toggleMenu: toggleMenu)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

