//
//  CurrentBooking.swift
//  KlimaRideApp
//
//  Created by MAC on 16/08/2023.
//

import SwiftUI

struct CurrentBooking: View {
    @StateObject var bookRideApi = BookRideApiMethod()
    
    var body: some View {
        ZStack {
            VStack {
                if let bookRideData = bookRideApi.bookRideModel {
                    ForEach(bookRideData.data?.current_bookings ?? [], id: \.id) { rideData in
                        NavigationLink(destination: DetailPage(bookingData: rideData)) {
                            Card(userImage: rideData.user_details?.profile_image ?? "",
                                 name: (rideData.user_details?.first_name ?? "") + " " + (rideData.user_details?.last_name ?? ""),
                                 type: rideData.ride_details?.ride_type ?? "",
                                 description: rideData.ride_details?.ride_title ?? "",
                                 date: rideData.ride_details?.leaving_date ?? "",
                                 time: rideData.ride_details?.leaving_time ?? "",
                                 availableSeats: "\(rideData.ride_details?.number_of_seats ?? 0) Seats Available",
                                 priceLabel: "$\(rideData.ride_details?.per_seat_price ?? 0) / Seat",
                                 status: rideData.status ?? "",
                                 foregroundColor: .white,
                                 backgroundColor: Color.theme.appColor)
                                .padding(.horizontal)
                        }
                        
                    }
                }
//                NavigationLink(destination: BookingDetailsConfirmed()) {
//                    Card(userImage: "user-image", name: "Jhon Smith", type: "Recurring", description: "i'm going to Albuquerque", festival: "Balloon Festival", date: "15 Aug 2023", time: "03: 00 PM", availableSeats: "2 Seats Available", priceLabel: "$500 / Seat", status: "confirmed", foregroundColor: .white, backgroundColor: Color.theme.appColor)
//                        .padding(.horizontal)
//                }
//                
//                NavigationLink(destination: bookingDetailAccepted()) {
//                    Card(userImage: "user-image", name: "Jhon Smith", type: "Return", description: "i'm going to Albuquerque", festival: "Balloon Festival", date: "15 Aug 2023", time: "03: 00 PM", availableSeats: "2 Seats Available", priceLabel: "$500 / Seat", status: "Accepted", foregroundColor: .white, backgroundColor: .green)
//                        .padding(.horizontal)
//                }
//                
//                NavigationLink(destination: BookingDetailsPending()) {
//                    Card(userImage: "user-image", name: "Jhon Smith", type: "One Way", description: "i'm going to Albuquerque", festival: "Balloon Festival", date: "15 Aug 2023", time: "03: 00 PM", availableSeats: "2 Seats Available", priceLabel: "$500 / Seat", status: "Pending", foregroundColor: .white, backgroundColor: .red)
//                        .padding(.horizontal)
//                }
            }
            if bookRideApi.showLoader {
                ActivityIndicatorView(isVisible: $bookRideApi.showLoader, type: .arcs())
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Color.theme.appColor)
            }
        }
        .onAppear {
            bookRideApi.showLoader = true
            bookRideApi.bookRide()
        }
    }
}

struct CurrentBooking_Previews: PreviewProvider {
    static var previews: some View {
        CurrentBooking()
    }
}
