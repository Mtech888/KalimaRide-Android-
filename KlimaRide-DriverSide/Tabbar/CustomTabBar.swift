//
//  CustomTabBar.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

enum  Tab: String, CaseIterable {
    case search
    case shareRide
    case notifications
    case inbox
    case profile
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var selectedImage: String {
        selectedTab.rawValue + "Selected"
    }
    
    private let selectedColor = Color.black
    private let unselectedColor = Color.gray
    
    var body: some View {
        VStack{
            HStack{
                ForEach (Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack {
                        Image(selectedTab == tab ? selectedImage : tab.rawValue)
                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        
                        Text(tab.rawValue.capitalized)
                            .font(.caption)
                            .foregroundColor(selectedTab == tab ? Color.theme.appColor : unselectedColor)
                    }
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
            .cornerRadius(10)
            .padding()
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.search))
    }
}

