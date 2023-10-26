//
//  Home.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct MyRides: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var filters: BookingTabs = .currrentRides
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "My Rides", icon: "back-icon", hiddenTitle: "title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            
            Filter(selectedTabs: $filters)
            
            ScrollView{
                if filters == .currrentRides {
                    CurrrentRides()
                } else if filters == .rideHistory {
                    RideHistory()
                }
            }
            .padding(.top)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct MyRides_Previews: PreviewProvider {
    static var previews: some View {
        MyRides()
    }
}



