//
//  PickupPoint.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 23/08/2023.
//

import SwiftUI
import GoogleMaps

struct AddCity: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var locationManager = CLLocationManager()
    @State private var places = [
        Place(name: "Goole", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843459), adress: "asdfasdczxvsdafjdk", rating: 4.8)
    ]
    @State var search: String = ""
    
    var body: some View {
        ZStack {
            MapView(places: $places)
            
            VStack {
                CustomNavbar(action: {presentationMode.wrappedValue.dismiss()}, title: "Add City", icon: "back-icon", hiddenTitle: "Title")
                    .background(Color.white)
                
                HStack(alignment: .center, spacing: 18) {
                    Image("search-icon")
                    TextField("Search", text: $search)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)
                .padding()
                
                Spacer()
                
                CustomButton(action: {presentationMode.wrappedValue.dismiss()}, title: "Add City", background: Color.theme.appColor, foreground: .white)
                    .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct AddCity_Previews: PreviewProvider {
    static var previews: some View {
        AddCity()
    }
}
