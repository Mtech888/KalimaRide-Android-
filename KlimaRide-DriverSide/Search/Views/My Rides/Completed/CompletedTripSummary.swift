//
//  TripSummary.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 23/08/2023.
//

import SwiftUI
import GoogleMaps

struct CompletedTripSummary: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]

    
    var body: some View {
        ScrollView {
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Trip Summary", icon: "back-icon", hiddenTitle: "Title")
                
                VStack {
                    ZStack(alignment: .topLeading) {
                        MapView(places: $places)
                            .frame(height: 240)
                            .padding(.top)
                        
                        HStack {
                            Text("26 Jun 2021")
                            Text("09:00 Pm")
                                .padding(.leading)
                            Spacer()
                            Text("2.54 Km | 24 Min")
                        }
                        .font(.custom(Font.medium, size: 12))
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width * 0.80)
                        .background(Color.theme.appColor)
                        .clipShape(RoundedShape(corners: [.topLeft, .topRight]))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        
                    }
                }
                
                HStack(spacing: 0) {
                    HStack(spacing: 12) {
                        Image("city-icon")
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("City of Departure")
                                .font(.custom(Font.medium, size: 12))
                            Text("New York")
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
                            Text("City of Departure")
                                .font(.custom(Font.medium, size: 12))
                            Text("New York")
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
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Passengers")
                        .font(.custom(Font.medium, size: 15))
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 8) {
                        HStack{
                            Image("user-image")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("William")
                                .font(.custom(Font.medium, size: 14))
                            Spacer()
                            Image("message")
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Payment Details")
                        .font(.custom(Font.medium, size: 15))
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 18) {
                        HStack{
                            Text("Seat price")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("$500")
                                .foregroundColor(.primary)
                        }
                        
                        HStack{
                            Text("No Of Seats")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("1")
                                .foregroundColor(.primary)
                        }
                        
                        HStack{
                            Text("Sub Total")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("$500")
                                .foregroundColor(.primary)
                        }
                    }
                    .font(.custom(Font.regular, size: 14))
                    .padding()
                }
                .padding()
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct CompletedTripSummary_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTripSummary()
    }
}
