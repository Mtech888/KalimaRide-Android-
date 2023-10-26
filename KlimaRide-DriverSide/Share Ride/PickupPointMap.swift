//
//  PickupPointMap.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 19/10/2023.
//

import SwiftUI
import GoogleMaps
import GooglePlaces
import CoreLocation

struct PickupMapView: UIViewRepresentable {
    @Binding var locationData: LocationData
    @Binding var searchText: String
    private let googleMapView = GMSMapView()
    var marker: GMSMarker?

    func makeUIView(context: Context) -> GMSMapView {
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = true
        googleMapView.delegate = context.coordinator
        
        return googleMapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update the map's center coordinates
        if let newCenter = locationData.center {
            uiView.camera = GMSCameraPosition(target: newCenter, zoom: uiView.camera.zoom)
//            marker?.position = newCenter
//            let markerImage = UIImage(named: "pin-icon")
//            let markerView = UIImageView(image: markerImage)
//            marker?.iconView = markerView
//            marker?.map = uiView
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: PickupMapView

        init(_ parent: PickupMapView) {
            self.parent = parent
        }

        // Handle map view events, such as camera position changes
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            // When the map's center is moved, fetch location information
            parent.fetchLocationInfo(for: position.target)
        }
    }

    func fetchLocationInfo(for coordinate: CLLocationCoordinate2D) {
        // Use the Core Location framework to reverse geocode the coordinates
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        var marker = GMSMarker()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? ""
                let address = placemark.name ?? ""
                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                searchText = placemark.locality ?? ""
                
                marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                marker.icon = UIImage(named: "pin-icon")
//                marker.map = googleMapView
                // Update the location data
                locationData = LocationData(city: city, location: address, latitude: latitude, longitude: longitude)
            }
        }
    }
}

struct LocationData {
    var city: String
    var location: String
    var latitude: Double
    var longitude: Double
    var center: CLLocationCoordinate2D?
}

struct PickupView: View {
    @State private var locationData = LocationData(city: "", location: "", latitude: 0.0, longitude: 0.0, center: nil)
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            PickupMapView(locationData: $locationData, searchText: $searchText)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            TextField("Location", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("City: \(locationData.city)")
            Text("Location: \(locationData.location)")
            Text("Latitude: \(locationData.latitude)")
            Text("Longitude: \(locationData.longitude)")
        }
    }
}
