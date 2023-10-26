//
//  SearchDetails.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchDetails: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var searchDetails: SearchPostAPiMethod
    @State var searchPostModel: SearchPostModel?
    
    var body: some View {
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Search", icon: "back-icon", hiddenTitle: "title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .padding(.top)
            ScrollView {
                VStack {
                    if let searchPostModel = searchDetails.myPostModel {
                        if searchPostModel.status ?? false {
                            ForEach(searchPostModel.data?.post ?? [], id: \.id) { data in
                                    NavigationLink(destination: SearchedPostDetail(searchPostData: data)) {
                                        Card(userImage: data.driver_details?.profile_image ?? "",
                                             name: data.driver_details?.first_name ?? "",
                                             type: data.ride_type ?? "",
                                             description: data.ride_title ?? "",
                                             date: data.leaving_date ?? "",
                                             time: data.leaving_time ?? "",
                                             availableSeats: "\(data.number_of_seats ?? 0)",
                                             priceLabel: "$\(data.per_seat_price ?? 0)/ Seat")
                                        .padding(.horizontal)
                                    }
                                }
                        }
                    }
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Other Events In That City")
                        .padding()
                        .font(.custom(Font.medium, size: 17))
                    
                    if let searchPostModel = searchDetails.myPostModel {
                        if searchPostModel.status ?? false {
                            ForEach(searchPostModel.data?.otherPosts ?? [], id: \.id) { otherData in
//                                NavigationLink(destination: SearchedPostDetail(searchPostData: otherData)) {
                                    Card(userImage: otherData.other_driver_details?.profile_image ?? "",
                                         name: otherData.other_driver_details?.first_name ?? "",
                                         type: otherData.ride_type ?? "",
                                         description: otherData.description ?? "",
                                         date: otherData.ride_date ?? "",
                                         time: otherData.leaving_time ?? "",
                                         availableSeats: "\(otherData.number_of_seats ?? 0)",
                                         priceLabel: "$\(otherData.per_seat_price ?? 0)/ Seat")
                                    .padding(.horizontal)
//                                }
                            }
                        }
                    }
                }
            }
            .onAppear{
                if searchDetails.oneWayRideStatus {
                    searchDetails.oneWayData()
                    print(searchDetails.rideType)
                } else if searchDetails.twoWayRideStatus {
                    searchDetails.twoWayData()
                    print(searchDetails.rideType)
                } else if searchDetails.recurringStatus {
                    searchDetails.recurringData()
                }
            }
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SearchDetails_Previews: PreviewProvider {
    static var previews: some View {
        let mockSearchPost = SearchPostAPiMethod()
        return SearchDetails(searchDetails: mockSearchPost)
            .environmentObject(mockSearchPost)
    }
}

