//
//  Posts.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI
import GoogleMaps

struct PostsOneWay: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var selectedFilter: RideTabs = .details
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Post Details", icon: "back-icon", hiddenTitle: "Title")
                .padding(.top)
            
            FilterView(selectedTab: $selectedFilter)
            
            ScrollView(showsIndicators: false) {
                if selectedFilter == .details {
//                    OneWay()
                } else if selectedFilter == .bookings {
                    OneWayBooking()
                }
            }
            .padding()
            
            if selectedFilter == .details {
                
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct PostsOneWay_Previews: PreviewProvider {
    static var previews: some View {
        PostsOneWay()
    }
}

