//
//  CompletedDetails.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI

import SDWebImageSwiftUI
import GoogleMaps

struct CompletedDetails: View {
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    var ridePostData: PostRideData?
    
    var body: some View {
        ZStack {
            if let postDetail = postDetailsApi.postDetailsModel {
                if postDetail.status {
                    VStack {
                        
                        
                        VStack(alignment: .leading, spacing: 15) {
                            //                        Group {
                            HStack {
                                WebImage(url: URL(string: "\(postDetail.data?.user_details?.profile_image ?? "")"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .cornerRadius(50)
                                Text((postDetail.data?.user_details?.first_name ?? "") + " " + (postDetail.data?.user_details?.last_name ?? ""))
                                    .font(.custom(Font.medium, size: 14))
                                Spacer()
                                Text(postDetail.data?.ride_type ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(Color.theme.appColor)
                            }
                            
                            Text(postDetail.data?.ride_title ?? "")
                                .font(.custom(Font.bold, size: 20))
                            
                            HStack {
                                Text("Price")
                                    .font(.custom(Font.regular, size: 11))
                                Text("$\(postDetail.data?.per_seat_price ?? 0) / Seat")
                                    .foregroundColor(Color.theme.appColor)
                                    .font(.custom(Font.bold, size: 18))
                            }
                            
                            Text("Leaving Date")
                                .font(.custom(Font.medium, size: 14))
                                .padding(.top)
                            
                            HStack(spacing: 18) {
                                HStack {
                                    Image("calender-icon")
                                    Text(postDetail.data?.leaving_date ?? "")
                                }
                                Spacer()
                                HStack {
                                    Image("time-icon")
                                    Text(postDetail.data?.leaving_time ?? "")
                                }
                                Spacer()
                            }
                            .font(.custom(Font.regular, size: 13))
                            
                            HStack {
                                Image("seats-icon")
                                Text("\(postDetail.data?.number_of_seats ?? 0) Seats Available")
                                    .font(.custom(Font.regular, size: 13))
                            }
                            //                        }
                        }
                        
                        HStack(spacing: 0) {
                            HStack(spacing: 12) {
                                Image("city-icon")
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("City of Departure")
                                        .font(.custom(Font.medium, size: 12))
                                    Text(postDetail.data?.departure_city ?? "")
                                        .font(.custom(Font.regular, size: 11))
                                }
                                
                            }
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 0.1)
                            }
                            
                            Text("-----")
                                .foregroundColor(Color(.lightGray))
                            
                            HStack(spacing: 12) {
                                Image("city-icon")
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("City of Arrival ")
                                        .font(.custom(Font.medium, size: 12))
                                    Text(postDetail.data?.arrival_city ?? "")
                                        .font(.custom(Font.regular, size: 11))
                                }
                            }
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 0.1)
                            }
                        }
                        .padding(.top)
                        
                        VStack(spacing: 40) {
                            VStack(alignment: .leading) {
                                Text("Pickup Point")
                                    .font(.custom(Font.medium, size: 14))
                                    .padding(.top)
                                
                                MapView(places: $places)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: CompletedTripSummary()) {
                                CustomButton(action: {},
                                             title: "Ride Summary",
                                             background: .white,
                                             foreground: Color.theme.appColor)
                            }
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.appColor, lineWidth: 1.5)
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
                        }
                        .navigationBarHidden(true)
                    }
                    if postDetailsApi.showLoader {
                        ProgressView()
                            .foregroundColor(.gray)
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

struct CompletedDetails_Previews: PreviewProvider {
    static var previews: some View {
        CompletedDetails()
    }
}

//extension CompletedDetails {
//    private var TraverDetails: some View {
//        HStack(spacing: 0) {
//            HStack(spacing: 12) {
//                Image("city-icon")
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("City of Departure")
//                        .font(.custom(Font.medium, size: 12))
//                    Text(postDetail.data.departureCity)
//                        .font(.custom(Font.regular, size: 11))
//                }
//                
//            }
//            .padding(10)
//            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.primary, lineWidth: 0.1)
//            }
//            
//            Text("-----")
//                .foregroundColor(Color(.lightGray))
//            
//            HStack(spacing: 12) {
//                Image("city-icon")
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("City of Arrival ")
//                        .font(.custom(Font.medium, size: 12))
//                    Text(postDetail.data.arrivalCity)
//                        .font(.custom(Font.regular, size: 11))
//                }
//            }
//            .padding(10)
//            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.primary, lineWidth: 0.1)
//            }
//        }
//    }
//}
