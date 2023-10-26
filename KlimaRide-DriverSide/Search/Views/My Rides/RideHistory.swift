//
//  RideHistory.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct RideHistory: View {
    @StateObject var ridePostApi = RidePostApiMethod()
    
    var body: some View {
        ZStack {
            VStack {
                if let ridePostData = ridePostApi.ridePostModel {
                    ForEach(ridePostData.data?.oldPosts ?? [], id: \.id) { data in
                        NavigationLink(destination: CompletedPosts()) {
                            MyRidesCard(type: data.ride_type ?? "", description: data.ride_title ?? "", date: data.leaving_date ?? "", time: data.leaving_time ?? "", availableSeats: "\(data.number_of_seats ?? 0) Seats Available", priceLabel: "$\(data.per_seat_price ?? 0) / Seat", status: "Completed", foregroundColor: .white, backgroundColor: Color.theme.appColor)
                                .padding(.horizontal)
                        }
                        
                    }
                }
            }
            
        }
        .onAppear {
            ridePostApi.showLoader = true
            ridePostApi.ridePostData()
        }
        if ridePostApi.showLoader {
            ProgressView()
                .foregroundColor(Color.gray)
        }
    }
}

struct RideHistory_Previews: PreviewProvider {
    static var previews: some View {
        RideHistory()
    }
}
