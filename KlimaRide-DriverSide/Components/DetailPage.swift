//
//  DetailPage.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 28/09/2023.
//

import SwiftUI
import GoogleMaps
import SDWebImageSwiftUI

struct DetailPage: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @StateObject var postDetailsApi = PostDetailsApiMethod()
    @State var bookingData: BookingData?
    
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
                                WebImage(url: URL(string: "\(bookingData?.user_details?.profile_image ?? "")"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .cornerRadius(50)
                                Text((bookingData?.user_details?.first_name ?? "") + " " + (bookingData?.user_details?.last_name ?? ""))
                                    .font(.custom(Font.medium, fixedSize: 14))
                                Spacer()
                                Text(bookingData?.ride_details?.ride_type ?? "")
                                    .padding(6)
                                    .font(.custom(Font.medium, fixedSize: 14))
                                    .foregroundColor(Color.theme.appColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.theme.appColor, lineWidth: 0.8)
                                    )
                            }
                            
                            Text(bookingData?.ride_details?.ride_title ?? "")
                                .font(.custom(Font.bold, size: 20))
                            
                            HStack {
                                Text("Price")
                                    .font(.custom(Font.regular, fixedSize: 11))
                                Text("$\(bookingData?.ride_details?.per_seat_price ?? 0) / Seat")
                                    .foregroundColor(Color.theme.appColor)
                                    .font(.custom(Font.bold, fixedSize: 18))
                            }
                            
                            //                            if bookingData?.ride_details.ride_type == "Recurring" {
                            RecurringDetailData(rideDate: bookingData?.ride_details?.ride_date ?? "",
                                                leavingTime: bookingData?.ride_details?.leaving_time ?? "",
                                                returnigTime: bookingData?.ride_details?.returning_time ?? "",
                                                numberOfSeats: bookingData?.ride_details?.number_of_seats ?? 0,
                                                duration: bookingData?.ride_details?.duration ?? "")
                            //                            } else if bookingData?.ride_details.ride_type == "Return" {
                            ReturnDetailData(leavingDate: bookingData?.ride_details?.leaving_date ?? "",
                                             leavingTime: bookingData?.ride_details?.leaving_time ?? "",
                                             returningDate: bookingData?.ride_details?.returning_date ?? "",
                                             returningTime: bookingData?.ride_details?.returning_time ?? "",
                                             numberOfSeats: bookingData?.ride_details?.number_of_seats ?? 0)
                            //                            } else if bookingData?.ride_details.ride_type == "One Way" {
                            OneWayDetailData(leavingDate: bookingData?.ride_details?.leaving_date ?? "",
                                             leavingTime: bookingData?.ride_details?.leaving_time ?? "",
                                             numberOfSeats: bookingData?.ride_details?.number_of_seats ?? 0)
                            //                            }
                        }
                    }
                    
                    TraverDetails
                        .padding(.top)
                    
                    VStack(alignment:.leading) {
                        Text("Pickup Point")
                            .font(.custom(Font.medium, fixedSize: 14))
                        
                        MapView(places: $places)
                            .onUserMarkersUpdated { markers in
                                print(" User Markers count: \(markers.count)")
                                
                            }
                            .frame(height: 150)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                    
                    if bookingData?.status == "confirmed" {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nearby Restaurants")
                                .font(.custom(Font.medium, fixedSize: 14))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
//                                    NavigationLink(destination: RestaurantDetails()) {
                                        ConfirmedBookCard(image: "restaurant-image", rating: "4.5", title: "Mcdonalds", distance: "1.2 Km Away")
//                                    }
                                    ConfirmedBookCard(image: "restaurant-image", rating: "4.5", title: "Mcdonalds", distance: "1.2 Km Away")
                                }
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Need A Place To Stay In")
                                    .font(.subheadline)
                                Text("Hamburg")
                                    .font(.subheadline)
                                    .foregroundColor(Color.theme.appColor)
                            }
                            .font(.custom(Font.medium, fixedSize: 14))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
//                                    NavigationLink(destination: HotelsDetails()) {
                                        ConfirmedBookCard(image: "hotel-image", rating: "4.5", title: "The Aston Vill Hotel", description: "Alice Springs NT 0870, Australia", distance: "1.2 Km Away")
//                                    }
                                    ConfirmedBookCard(image: "hotel-image", rating: "4.5", title: "The Aston Vill Hotel", description: "Alice Springs NT 0870, Australia", distance: "1.2 Km Away")
                                }
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment:.leading) {
                            HStack {
                                Text("Find the best deals in")
                                    .font(.subheadline)
                                Text("Booking.com")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                            .padding(.top)
                            .font(.custom(Font.medium, fixedSize: 14))
                            
                            VStack(alignment: .center, spacing: 16) {
                                NavigationLink(destination: TrackRide()) {
                                    CustomButton(action: {},
                                                 title: "Track Ride",
                                                 icon: "track-icon",
                                                 background: Color.theme.appColor,
                                                 foreground: .white)
                                }
                                .frame(maxWidth: .infinity)
                                
                                NavigationLink(destination: UsersChats()) {
                                    CustomButton(action: {},
                                                 title: "Chat With Driver",
                                                 icon: "chat-icon",
                                                 background: Color.white,
                                                 foreground: Color.theme.appColor)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.theme.appColor, lineWidth: 2)
                                )
                                
                                .padding(.bottom)
                            }
                        }
                        
                    } else if bookingData?.status == "pending" {
                        VStack(alignment: .center, spacing: 8) {
                            Text("Waiting For Driver To Accept Your Booking Request")
                                .bold()
                            Text("If The Driver Does Not Respond Within 5 Hours This Request Will Be Canceled Automatically")
                        }
                        .font(.custom(Font.regular, size: 13))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    } else if bookingData?.status == "accepted" {
                        VStack(alignment: .center) {
                            Text("Your Booking is Accepted By Driver")
                            HStack {
                                Text("Click On")
                                Text("Pay Now")
                                    .fontWeight(.semibold)
                                Text("Button To Confirm Your Booking")
                            }
                        }
                        .font(.custom(Font.regular, size: 13))
                        .padding(.vertical, 5)
                        
                        VStack(alignment: .center, spacing: 16) {
                            NavigationLink(destination: Payment()) {
                                CustomButton(action: {},
                                             title: "Pay Now",
                                             background: Color.theme.appColor,
                                             foreground: .white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top)
                            
                            NavigationLink(destination: Text("")) {
                                CustomButton(action: {},
                                             title: "Cancel Booking",
                                             background: Color.white,
                                             foreground: Color.theme.appColor)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.appColor, lineWidth: 2)
                            )
                            .padding(.bottom)
                        }
                    } else if bookingData?.status == "completed" {
                        Group {
                            NavigationLink(destination: RideSummary()) {
                                CustomButton(action: {},
                                             title: "Ride Summary",
                                             background: Color.white,
                                             foreground: Color.theme.appColor)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.appColor, lineWidth: 2)
                            )
                        }
                        .padding(.top,30)
                    }
                    
                    
                }
            }
            .onAppear {
                postDetailsApi.showLoader = true
                postDetailsApi.postDetails(id: bookingData?.id ?? 0)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage()
    }
}

extension DetailPage {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Departure")
                    Text(bookingData?.ride_details?.departure_city ?? "")
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
                    Text(bookingData?.ride_details?.arrival_city ?? "")
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
