//
//  BookingDetailsCompleted.swift
//  KlimaRideApp
//
//  Created by MAC on 15/08/2023.
//

import SwiftUI
import GoogleMaps

struct BookingDetailsCompleted: View {
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
                   VStack(alignment: .leading, spacing: 23) {
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
                           
                           VStack(alignment:.leading, spacing: 26){
                               Text("Leaving Date")
                                   .font(.custom(Font.medium, size: 14))
                               
                               HStack(spacing: 18) {
                                   HStack {
                                       Image("calender-icon")
                                       Text("13 Aug 2023")
                                           .font(.caption)
                                   }
                                   Spacer()
                                   HStack {
                                       Image("time-icon")
                                       Text("03: 00 PM")
                                           .font(.caption)
                                   }
                                   Spacer()
                               }
                               
                               HStack {
                                   Image("seats-icon")
                                   Text("2 Seats Booked")
                                       .font(.caption)
                               }
                           }
                       }
                   }
                   TravelDetails
                           .padding(.top)
                   
                   VStack(alignment:.leading) {
                       Text("Pickup Point")
                           .font(.custom(Font.medium, size: 14))
                   
                       MapView(places: $places)
                       .frame(height: 150)
                       .cornerRadius(10)
                   }
                   .padding(.top)
                       
                   
                   
                       
               }
           }
           .padding()
           .navigationBarHidden(true)
           .ignoresSafeArea()
           
       }
}

struct BookingDetailsCompleted_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailsCompleted()
    }
}

extension BookingDetailsCompleted {
    private var TravelDetails: some View {
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
