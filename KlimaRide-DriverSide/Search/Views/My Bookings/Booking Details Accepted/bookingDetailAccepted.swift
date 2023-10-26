//
//  BookingDetailAccepted.swift
//  KlimaRideApp
//
//  Created by MAC on 10/08/2023.
//

import SwiftUI
import GoogleMaps

struct bookingDetailAccepted: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    
    var body: some View {
        VStack(spacing: 18) {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "Details", icon: "back-icon", hiddenTitle: "Title")
                .background(
                    Color.white.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        HStack {
                            Image("user-image")
                            Text("Jhone Smith")
                                .font(.custom(Font.medium, fixedSize: 14))
                            Spacer()
                            Text("Recurring")
                                .padding(6)
                                .font(.custom(Font.medium, fixedSize: 14))
                                .foregroundColor(Color.theme.appColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.theme.appColor, lineWidth: 0.8)
                            )
                        }
                        
                        Text("I'm Going To Albuquerque Balloon Festival")
                            .font(.custom(Font.bold, size: 20))
                        
                        HStack {
                            Text("Price")
                                .font(.custom(Font.regular, fixedSize: 11))
                            Text("$500 / Seat")
                                .foregroundColor(Color.theme.appColor)
                                .font(.custom(Font.bold, fixedSize: 18))
                        }
                        
                        VStack(alignment: .leading, spacing: 26) {
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Returning Date")
                                    .font(.custom(Font.medium, size: 14))
                                
                                HStack(spacing: 18) {
                                    HStack {
                                        Image("calender-icon")
                                        Text("13 Aug 2023")
                                            .font(.caption)
                                    }
                                    .font(.custom(Font.regular, size: 13))
                                    Text("At")
                                        .font(.custom(Font.medium, size: 14))
                                    HStack {
                                        Image("clock-icon")
                                        Text("03: 00 PM")
                                            .font(.caption)
                                    }
                                    Spacer()
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Returning Date")
                                    .font(.custom(Font.medium, size: 14))
                                
                                HStack(spacing: 18) {
                                    HStack {
                                        Image("calender-icon")
                                        Text("13 Aug 2023")
                                            .font(.caption)
                                    }
                                    .font(.custom(Font.regular, size: 13))
                                    Text("At")
                                        .font(.custom(Font.medium, size: 14))
                                    HStack {
                                        Image("clock-icon")
                                        Text("03: 00 PM")
                                            .font(.caption)
                                    }
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                Image("seats-icon")
                                Text("2 Seats Booked")
                            }
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
            }
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct bookingDetailAccepted_Previews: PreviewProvider {
    static var previews: some View {
        bookingDetailAccepted()
    }
}

extension bookingDetailAccepted {
    private var TraverDetails: some View {
        HStack(spacing: 0) {
            HStack {
                Image("city-icon")
                Text("City of departure New York")
                    .font(.custom(Font.medium, size: 12))
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.4)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            
            Text("-------")
                .foregroundColor(Color(.lightGray))
            
            HStack {
                Image("city-icon")
                Text("City of Arrival San Francisco")
                    .font(.custom(Font.medium, size: 12))
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.4)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
        }
    }
}
