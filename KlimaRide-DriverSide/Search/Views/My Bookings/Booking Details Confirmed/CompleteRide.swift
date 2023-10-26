//
//  CompleteRide.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 17/08/2023.
//

import SwiftUI
import GoogleMaps

struct CompleteRide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]

    
    var body: some View {
        
        VStack {
            CustomNavbar(action: {presentationMode.wrappedValue.dismiss()} ,title: "", icon: "back-icon")
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Thanks For Riding")
                        .font(.title)
                        .bold()
                    
                    Text("We Hope You Enjoyed Your Ride.")
                        .font(.headline)
                        .fontWeight(.light)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Trip Details")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width * 0.80)
                        .background(Color.theme.appColor)
                        .clipShape(RoundedShape(corners: [.topLeft, .topRight]))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        
                    }
                }
                
                HStack(spacing: 0) {
                    HStack {
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
                    
                    HStack {
                        Image("city-icon")
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("City of Arrival ")
                                .font(.custom(Font.medium, size: 12))
                            Text("San Francisco")
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
                    Text("Payment Details")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .fontWeight(.regular)
                    
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
                    .padding(22)
                }
                .padding()
                
                CustomButton(title: "Back To Home", background: Color.theme.appColor, foreground: .white)
                    .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct CompleteRide_Previews: PreviewProvider {
    static var previews: some View {
        CompleteRide()
    }
}
