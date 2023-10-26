//
//  CurrrentRides.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct CurrrentRides: View {
    @StateObject var ridePostApi = RidePostApiMethod()
    
    var body: some View {
        ZStack {
            VStack {
                    if let ridePostData = ridePostApi.ridePostModel {
                        ForEach(ridePostData.data?.currentPosts ?? [], id: \.id) { data in
                            NavigationLink(destination: MyRidesDetailPage(ridePostData: data)) {
                                MyRidesCard(type: data.ride_type ?? "",
                                            description: data.ride_title ?? "",
                                            date: data.leaving_date ?? "",
                                            time: data.leaving_time ?? "",
                                            availableSeats: "\(data.number_of_seats ?? 0) Seats Available",
                                            priceLabel: "$\(data.per_seat_price ?? 0) / Seat",
                                            status: "\(data.bookings_count ?? 0) Bookings",
                                            foregroundColor: .white,
                                            backgroundColor: data.bookings_count == 0 ? Color.red : Color.theme.appColor)
                                        .padding(.horizontal)
                            }
                            
                            }
                    }
                
    //            NavigationLink(destination: PostsReturn()) {
    //                MyRidesCard(type: "return", description: "I'm going to Albuquerque", date: "15 Aug 2023", time: "03: 00 PM", availableSeats: "2 Seats Available", priceLabel: "$500 / Seat", status: "No Bookings", foregroundColor: .white, backgroundColor: .red)
    //                    .padding(.horizontal)
    //            }
    //
    //            NavigationLink(destination: PostsRecurring()) {
    //                Card(userImage: "user-image", name: "Jhon Smith", type: "Recurring", description: "I'm going to Albuquerque", festival: "Balloon Festival", date: "15 Aug 2023", time: "03: 00 PM", availableSeats: "2 Seats Available", priceLabel: "$500 / Seat", status: "No Bookings", foregroundColor: .white, backgroundColor: .red)
    //                    .padding(.horizontal)
    //            }
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
}

struct CurrrentRides_Previews: PreviewProvider {
    static var previews: some View {
        CurrrentRides()
    }
}
