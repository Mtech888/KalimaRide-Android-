//
//  CompletedBookings.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI

struct CompletedBookings: View {
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    var ridePostData: PostRideData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let postDetail = postDetailsApi.postDetailsModel {
                if postDetail.status {
                    ForEach(postDetail.data?.bookingUser ?? [], id: \.id) { detail in
                            DetailsCard(userImage: detail.profile_image ?? "",
                                        name: "\(detail.first_name ?? "") \(detail.last_name ?? "")",
                                        date: postDetail.data?.leaving_date ?? "",
                                        time: postDetail.data?.leaving_time ?? "",
                                        availableSeats: "\(postDetail.data?.number_of_seats ?? 0) Seat Booked",
                                        status: "detail.status",
                                        foregroundColor: .white,
                                        backgroundColor: Color.theme.appColor,
                                        isPendig: false)
                    }
                } else {
                    VStack(spacing: 40) {
                        Spacer()
                        Image("no-bookings-image")
                        Text("No Bookings Yet!")
                            .font(.custom(Font.regular, size: 20))
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            postDetailsApi.showLoader = true
            postDetailsApi.postDetails(id: ridePostData?.id ?? 0)
        }
    }
}

struct CompletedBookings_Previews: PreviewProvider {
    static var previews: some View {
        CompletedBookings()
    }
}
