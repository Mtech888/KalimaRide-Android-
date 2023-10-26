//
//  KlimaRide_DriverSideApp.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct KlimaRide_DriverSideApp: App {
    init() {
        // Initialize Google Maps SDK with your API key
        GMSServices.provideAPIKey("AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk")
        GMSPlacesClient.provideAPIKey("AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk")
        signInConfig = GIDConfiguration.init(clientID: "435739848760-51btpt5agt3choeii8fv79g629sfi5an.apps.googleusercontent.com")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
