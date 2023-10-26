//
//  Booking.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 09/08/2023.
//

import SwiftUI

struct Booking: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedFilter: UserBookingTabs = .currrentBooking
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "My Booking", icon: "back-icon")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            
            BookingFilterView(selectedTab: $selectedFilter)
            
            ScrollView {
                if selectedFilter == .currrentBooking {
                    CurrentBooking()
                        .padding(.top)
                } else if selectedFilter == .pastBookings {
                    PastBooking()
                    .padding(.top)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Booking_Previews: PreviewProvider {
    static var previews: some View {
        Booking()
    }
}


struct BookingFilterView: View {
    @Binding var selectedTab: UserBookingTabs
    
    var body: some View {
        HStack {
            ForEach(UserBookingTabs.allCases, id: \.rawValue) { item in
                Text(item.title)
                    .font(.custom(Font.medium, size: 14))
                    .foregroundColor(selectedTab == item ? .white : .primary)
                    .padding()
                    .frame(width: 170, height: 50)
                    .background(selectedTab == item ? Color.theme.appColor : Color.white)
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            self.selectedTab = item
                            
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
