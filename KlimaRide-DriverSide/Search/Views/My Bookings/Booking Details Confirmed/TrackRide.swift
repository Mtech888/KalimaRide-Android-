//
//  TrackRide.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 17/08/2023.
//

import SwiftUI
import GoogleMaps

struct TrackRide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var places = [
        Place(name: "Goooole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topLeading) {
                MapView(places: $places)
                    .onUserMarkersUpdated { markers in
                        print(" User Markers count: \(markers.count)")
                        
                    }
                    .frame(height: .infinity)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back-icon")
                }
                .padding()
                .padding(.top, 40)
            }
            .edgesIgnoringSafeArea(.vertical)
            
            VStack(alignment: .leading) {
                VStack {
                        Text("Your Driver is Ariving at Pickup Point in 8 min")
                        .font(.custom(Font.regular, size: 16))
                        .padding()
                        .padding(.top)
                    
                    Divider()
                    
                    HStack {
                        Image("profilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("John Doe")
                                .font(.custom(Font.medium, size: 17))
                            Text("Honda Civic")
                                .foregroundColor(.gray)
                                .font(.custom(Font.regular, size: 13))
                            
                            Text("Mn 02 Ub 1234")
                                .padding(8)
                                .font(.custom(Font.regular, size: 12))
                                .background(Color(.systemGray6))
                        }
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Image("message")
                            
                            Image("call")
                        }
                        
                    }
                    .padding()
                }
                .padding(.bottom, 30)
            }
            .background(Color.white.clipShape(RoundedShape(corners: [.topLeft, .topRight])))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct TrackRide_Previews: PreviewProvider {
    static var previews: some View {
        TrackRide()
    }
}
