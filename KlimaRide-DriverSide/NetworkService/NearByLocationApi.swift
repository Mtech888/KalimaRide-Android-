//
//  NearByLocationApi.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 24/10/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
        }
    }
}

class HotelViewModel: ObservableObject {
    @Published var hotels: [Hotel] = []
    var model: NearByModel? = nil
    
    func fetchNearbyHotels(location: String, apiKey: String) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let parameters: Parameters = [
            "keyword": "cruise",
            "location": location,
            "radius": 1000,
            "type": "hotels",
            "key": apiKey
        ]
        
        AF.request(baseUrl, parameters: parameters)
            .response { response in
                if let data = response.data {
                    do {
                        let nearbyModel = try JSONDecoder().decode(NearByModel.self, from: data)
                        if nearbyModel.status == "OK" {
                            // Update the restaurants array
                            if let results = nearbyModel.results {
                                let mappedHotels = results.compactMap { result in
                                    print(result.name ?? "")
                                    return Hotel(
                                        name: result.name ?? "",
                                        address: result.vicinity ?? "",
                                        rating: result.rating ?? 0.0,
                                        photoReference: result.photos?.first?.photo_reference
                                    )
                                }
                                self.hotels = mappedHotels
                            }
                        } else {
                            print("Error: \(nearbyModel.status ?? "Unknown Error")")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
    }
}

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    var model: NearByModel? = nil
    
    func fetchNearbyRestaurants(location: String, apiKey: String) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let parameters: Parameters = [
            //            "keyword": "cruise",
            "location": location,
            "radius": 1000,
            "type": "restaurants",
            "key": apiKey
        ]
        
        AF.request(baseUrl, parameters: parameters)
            .response { response in
                if let data = response.data {
                    do {
                        let nearbyModel = try JSONDecoder().decode(NearByModel.self, from: data)
                        if nearbyModel.status == "OK" {
                            // Update the restaurants array
                            if let results = nearbyModel.results {
                                let mappedRestaurants = results.compactMap { result in
                                    print(result.name ?? "")
                                    return Restaurant(
                                        name: result.name ?? "",
                                        address: result.vicinity ?? "",
                                        rating: result.rating ?? 0.0,
                                        photoReference: result.photos?.first?.photo_reference
                                    )
                                }
                                self.restaurants = mappedRestaurants
                            }
                        } else {
                            print("Error: \(nearbyModel.status ?? "Unknown Error")")
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
    }
}

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let rating: Double
    let photoReference: String?
}

struct Hotel: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let rating: Double
    let photoReference: String?
}

struct PhotoView: View {
    let photoReference: String
    
    var body: some View {
        WebImage(url: URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk"))
            .aspectRatio(contentMode: .fit)
            .frame(width: 266, height: 130) // Adjust the size as needed
            .cornerRadius(10)
    }
}
