//
//  FilterView.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedTab: RideTabs
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(RideTabs.allCases, id: \.rawValue) { item in
                Text(item.title)
                    .font(.custom(Font.medium, size: 13))
                    .foregroundColor(selectedTab == item ? .white : .primary)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(selectedTab == item ? Color.theme.appColor : Color.theme.bgColor)
                    .onTapGesture {
                        withAnimation {
                            self.selectedTab = item
                            
                        }
                    }
            }
        }
        .background(Color.white)
//        .shadow(radius: 1 )
        
    }
}

enum RideTabs : Int, CaseIterable {
    case details
    case bookings
    
    var title : String {
        switch self {
        case .details:
            return "Details"
        case .bookings :
            return "Bookings"
        }
    }
}
