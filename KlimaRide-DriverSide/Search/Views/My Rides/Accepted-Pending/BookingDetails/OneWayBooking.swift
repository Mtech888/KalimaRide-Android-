//
//  OneWayBooking.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 07/09/2023.
//

import SwiftUI

struct OneWayBooking: View {
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    var ridePostData: PostRideData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
//            if let postDetail = postDetailsApi.postDetailsModel {
//                if postDetail.status {
//                    ForEach(postDetail.data?.bookings ?? [], id: \.id) { detail in
//                        if detail.status == "accepted" {
//                            DetailsCard(userImage: detail.userDetail?.profileImage ?? "",
//                                        name: "\(detail.userDetail?.firstName ?? "") \(detail.userDetail?.lastName ?? "")",
//                                        date: postDetail.data?.leavingDate ?? "",
//                                        time: postDetail.data?.leavingTime ?? "",
//                                        availableSeats: "\(postDetail.data?.numberOfSeats ?? 0) Seat Booked",
//                                        status: detail.status,
//                                        foregroundColor: .white,
//                                        backgroundColor: Color.theme.appColor,
//                                        isPendig: false)
//                        } else if detail.status == "pending" {
//                            DetailsCard(userImage: detail.userDetail?.profileImage ?? "",
//                                        name: "\(detail.userDetail?.firstName ?? "") \(detail.userDetail?.lastName ?? "")",
//                                        date: postDetail.data?.leavingDate ?? "",
//                                        time: postDetail.data?.leavingTime ?? "",
//                                        availableSeats: "\(detail.numberOfSeats) Seat Booked",
//                                        status: detail.status, foregroundColor: .white,
//                                        backgroundColor: Color.theme.appColor,
//                                        isPendig: true)
//                        }
//                    }
//                } 
//            }
        }
//        .onAppear {
//            postDetailsApi.showLoader = true
//            postDetailsApi.postDetails(id: 41)
//        }
    }
}

struct OneWayBooking_Previews: PreviewProvider {
    static var previews: some View {
        OneWayBooking()
    }
}
