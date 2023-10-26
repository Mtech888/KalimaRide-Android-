//
//  RideDetails.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import SwiftUI

struct RideDetailsReturn: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @StateObject var postDetailsApi = PostDetailsApiMethod()

    
    var body: some View {
        VStack(spacing: 18) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image("user-image")
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
                            Text( "\(postDetailsApi.seatPrice)" + "/ Seat")
                                .foregroundColor(Color.theme.appColor)
                                .font(.custom(Font.bold, fixedSize: 18))
                        }
                        
                        VStack(alignment:.leading, spacing: 24){
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Leaving Date")
                                    .font(.custom(Font.medium, size: 14))
                        
                                HStack(spacing: 16) {
                                    HStack {
                                        Image("calender-icon")
                                        Text(postDetailsApi.leavingDate)
                                            .font(.custom(Font.regular, size: 13))
                                    }
                                    Text("At")
                                        .font(.custom(Font.regular, size: 14))
                                    HStack {
                                        Image("clock-icon")
                                        Text(postDetailsApi.leavingTime)
                                            .font(.custom(Font.regular, size: 13))
                                    }
                                    Spacer()
                                }
                            }
                        
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Returning Date")
                                    .font(.custom(Font.medium, size: 14))
                        
                                HStack(spacing: 16) {
                                    HStack {
                                        Image("calender-icon")
                                        Text(postDetailsApi.returningDate)
                                            .font(.custom(Font.regular, size: 13))
                                    }
                                    Text("At")
                                        .font(.custom(Font.regular, size: 14))
                                    HStack {
                                        Image("clock-icon")
                                        Text(postDetailsApi.returningTime)
                                            .font(.custom(Font.regular, size: 13))
                                    }
                                    Spacer()
                                }
                            }
                        
                            HStack {
                                Image("seats-icon")
                                Text( "\(postDetailsApi.availableSeats)"  + " Seats Booked")
                                    .font(.custom(Font.regular, size: 13))
                            }
                        }
                }
                
                TraverDetails
                    .padding(.top)
                
                VStack(alignment: .leading){
                    Text("Pickup Point")
                        .font(.custom(Font.medium, size: 14))
                    
                    MapView(places: $places)
                        .frame(height: 150)
                        .cornerRadius(10)
                }
                .padding(.top,10)
                
                VStack(alignment: .center, spacing: 16) {
                    NavigationLink(destination: BookRide()) {
                        CustomButton(action: {},
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
//            postDetailsApi.postDetails()
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct RideDetailsReturn_Previews: PreviewProvider {
    static var previews: some View {
        RideDetailsReturn()
    }
}

extension RideDetailsReturn {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Departure")
                        .font(.custom(Font.medium, size: 12))
                    Text(postDetailsApi.departureCity)
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
            
            HStack {
                Image("city-icon")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("City of Arrival ")
                        .font(.custom(Font.medium, size: 12))
                    Text(postDetailsApi.arrivalCity)
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
    }
}




