//
//  SearchedPostDetail.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchedPostDetail: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    @State var searchPostData: Detail?
    @State var isButtonEnabled = false
    @State private var selectedFilter: RideTabs = .details
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                    .background(
                        Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Group {
                            
                            HStack {
                                WebImage(url: URL(string: "\(postDetailsApi.image)"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .cornerRadius(50)
                                Text(postDetailsApi.firstName + " " + postDetailsApi.lastName)
                                    .font(.custom(Font.medium, fixedSize: 14))
                                Spacer()
                                Text(postDetailsApi.ridetype)
                                    .padding(6)
                                    .font(.custom(Font.medium, fixedSize: 14))
                                    .foregroundColor(Color.theme.appColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.theme.appColor, lineWidth: 0.8)
                                    )
                            }
                            
                            Text(postDetailsApi.rideTitle)
                                .font(.custom(Font.bold, size: 20))
                            
                            HStack {
                                Text("Price")
                                    .font(.custom(Font.regular, fixedSize: 11))
                                Text("$\(postDetailsApi.seatPrice) / Seat")
                                    .foregroundColor(Color.theme.appColor)
                                    .font(.custom(Font.bold, fixedSize: 18))
                            }
                            
                            if postDetailsApi.ridetype == "Recurring" {
                                RecurringDetailData(rideDate: postDetailsApi.rideDate,
                                                    leavingTime: postDetailsApi.leavingTime,
                                                    returnigTime: postDetailsApi.returningTime,
                                                    numberOfSeats: postDetailsApi.availableSeats,
                                                    duration: postDetailsApi.duration)
                            } else if postDetailsApi.ridetype == "Return" {
                                ReturnDetailData(leavingDate: postDetailsApi.leavingDate,
                                                 leavingTime: postDetailsApi.leavingTime,
                                                 returningDate: postDetailsApi.returningDate,
                                                 returningTime: postDetailsApi.returningTime,
                                                 numberOfSeats: postDetailsApi.availableSeats)
                            } else if postDetailsApi.ridetype == "One Way" {
                                OneWayDetailData(leavingDate: postDetailsApi.leavingDate,
                                                 leavingTime: postDetailsApi.leavingTime,
                                                 numberOfSeats: postDetailsApi.availableSeats)
                            }
                        }
                    }
                    
                    TraverDetails
                        .padding(.top)
                    
                    VStack(alignment:.leading) {
                        Text("Pickup Point")
                            .font(.custom(Font.medium, fixedSize: 14))
                        
                        MapView(places: $places)
                            .frame(height: 150)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .center, spacing: 16) {
                        NavigationLink(destination: BookRide().environmentObject(postDetailsApi)) {
                            CustomButton(action: {
                                postDetailsApi.postDetails(id: searchPostData?.id ?? 0)
                            },
                                         title: "Book Ride",
                                         background: Color.theme.appColor,
                                         foreground: .white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                    }
                }
            }
            .onAppear {
                postDetailsApi.showLoader = true
                postDetailsApi.postDetails(id: searchPostData?.id ?? 0)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SearchedPostDetail_Previews: PreviewProvider {
    static var previews: some View {
        SearchedPostDetail()
    }
}

extension SearchedPostDetail {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Departure")
                    Text(postDetailsApi.departureCity)
                }
                .font(.custom(Font.medium, size: 12))
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
                    Text(postDetailsApi.arrivalCity)
                }
                .font(.custom(Font.medium, size: 12))
            }
            .padding(10)
            .frame(width: UIScreen.main.bounds.width * 0.4, height: 70)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
        }
    }
}
