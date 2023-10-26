//
//  StartRide.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 23/08/2023.
//

import SwiftUI
import GoogleMaps

struct StartRide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @State var showPassengers: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topLeading) {
                MapView(places: $places)
                    .onUserMarkersUpdated { markers in
                        print(" User Markers count: \(markers.count)")
                        markers.first!
                        
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
            
            if showPassengers {
                VStack {
                    Button {
                        withAnimation {
                            showPassengers = false
                        }
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: "chevron.left")
                            Text("Passengers")
                                .font(.custom(Font.medium, size: 16))
                            Spacer()
                        }
                        .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.top)
                    
                    Divider()
                    
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
                    
                    CustomButton(action: {}, title: "Arrived", background: Color.theme.appColor, foreground: .white)
                        .padding(.bottom, 30)
                }
                .background(Color.white.clipShape(RoundedShape(corners: [.topLeft, .topRight])))
            } else {
                VStack {
                    HStack {
                        Text("Arriving at Pickup Point in 8 min")
                            .font(.custom(Font.regular, size: 16))
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top)

                    Divider()

                    Button {
                        withAnimation {
                            showPassengers.toggle()
                        }
                    } label: {
                        HStack {
                            Text("See Passengers")
                                .font(.custom(Font.medium, size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                    }
                    .padding()

                    Button {
                        
                    } label: {
                        Text("Arrived")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 50, alignment: .center)
                    .background(Color.theme.appColor)
                    .cornerRadius(10)
                    .padding(.bottom, 30)

                }
                .background(Color.white.clipShape(RoundedShape(corners: [.topLeft, .topRight])))
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct StartRide_Previews: PreviewProvider {
    static var previews: some View {
        StartRide()
    }
}
