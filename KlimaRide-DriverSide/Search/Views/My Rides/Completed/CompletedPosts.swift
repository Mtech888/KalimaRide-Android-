//
//  CompletedPosts.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI
import GoogleMaps

struct CompletedPosts: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var selectedFilters: RideTabs = .details
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Post Details", icon: "back-icon", hiddenTitle: "Title")
                .padding(.top)
            FilterView(selectedTab: $selectedFilters)
            
            ScrollView(showsIndicators: false) {
                if selectedFilters == .details {
                    CompletedDetails()
                } else if selectedFilters == .bookings {
                    CompletedBookings()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct CompletedPosts_Previews: PreviewProvider {
    static var previews: some View {
        CompletedPosts()
    }
}

extension CompletedPosts {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack {
                Image("city-icon")
                Text("City of departure New York")
                    .font(.subheadline)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.4)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            
            Text("-------")
                .foregroundColor(Color(.lightGray))
            
            HStack {
                Image("city-icon")
                Text("City of Arrival San Francisco")
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.4)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
        }
    }
}
