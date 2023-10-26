//
//  BookingDetailsPending.swift
//  KlimaRideApp
//
//  Created by MAC on 15/08/2023.
//

import SwiftUI
import GoogleMaps

struct BookingDetailsPending: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]

    
    var body: some View {
        VStack(spacing: 20) {
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
                    TraverDetails
                        .padding(.top)
                    
                
                VStack(alignment: .leading) {
                    Text("Pickup Point")
                        .font(.custom(Font.medium, size: 14))
                    
                    MapView(places: $places)
                    .frame(height: 150)
                    .cornerRadius(10)
                }
                .padding(.top,5)
                
                VStack(alignment: .center, spacing: 8) {
                    Text("Waiting For Driver To Accept Your Booking Request")
                        .bold()
                    Text("If The Driver Does Not Respond Within 5 Hours This Request Will Be Canceled Automatically")
                }
                .font(.custom(Font.regular, size: 13))
                .padding(.top)
                .multilineTextAlignment(.center)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func createCustomMarker(title: String, position: CLLocationCoordinate2D) -> GMSMarker {
            let marker = GMSMarker(position: position)
            
            // Create a custom view for the marker
            let customMarkerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
            
            // Create UIImageView for marker image
            let markerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            markerImageView.image = UIImage(named: "location-marker")
            customMarkerView.addSubview(markerImageView)
            
            // Create Text view for title
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 100, height: 20))
            titleLabel.text = title
            titleLabel.backgroundColor = .white
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            customMarkerView.addSubview(titleLabel)
            
            marker.iconView = customMarkerView
            return marker
        }
}

struct BookingDetailsPending_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailsPending()
    }
}

extension BookingDetailsPending {
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
