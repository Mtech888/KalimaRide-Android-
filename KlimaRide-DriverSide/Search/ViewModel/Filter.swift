//
//  Filter.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 24/08/2023.
//

import SwiftUI

struct Filter: View {
    @Binding var selectedTabs: BookingTabs
    
    var body: some View {
        HStack {
            ForEach(BookingTabs.allCases, id: \.rawValue) { item in
                Text(item.title)
                    .font(.custom(Font.medium, size: 14))
                    .foregroundColor(selectedTabs == item ? .white : .primary)
                    .padding()
                    .frame(width: 170, height: 50)
                    .background(selectedTabs == item ? Color.theme.appColor : Color.white)
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            self.selectedTabs = item
                            
                        }
                    }
            }
        }
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(radius: 1 )
        .padding(.top)
        
    }
}

enum BookingTabs : Int, CaseIterable {
    case currrentRides
    case rideHistory
    
    var title : String {
        switch self {
        case .currrentRides:
            return "Current Rides"
        case .rideHistory :
            return "Ride History"
        }
    }
}
