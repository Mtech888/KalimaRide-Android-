//
//  GoogleMap.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 22/08/2023.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @Binding var places: [Place]
    
    @State private var userMarkers: [GMSMarker] = []
    let mutatingWrapper = MutatingWrapper()
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(latitude: -23.5899619, longitude: -46.66747, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator

        places.forEach { place in
            let marker = GMSMarker()
            marker.position = place.latLng
            marker.title = place.name
            marker.snippet = place.adress
            marker.icon = UIImage(named: "location-marker")
            marker.map = mapView
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
//        context.coordinator.addMarkers(mapView: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator($userMarkers, parent: self)
    }
    
    typealias UIViewType = GMSMapView
    
    func onUserMarkersUpdated(_ action: @escaping (([GMSMarker]) -> Void)) -> Self {
        self.mutatingWrapper.userMarkersUpdated = action
        return self
    }
}

class Coordinator: NSObject, GMSMapViewDelegate {
    @Binding var markers: [GMSMarker]
    private let parent: MapView
    init(_ userMarkers: Binding<[GMSMarker]>, parent: MapView) {
        self._markers = userMarkers
        self.parent = parent
    }
    
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        
        let decoder = CLGeocoder()
        
        //This method is used to get location details from coordinates
        decoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, err in
            if let placeMark = placemarks?.first {
                
                let placeName = placeMark.name ?? placeMark.subThoroughfare ?? placeMark.thoroughfare!   ///Title of Marker
                //Formatting for Marker Snippet/Subtitle
                var address : String! = ""
                if let subLocality = placeMark.subLocality ?? placeMark.name {
                    address.append(subLocality)
                    address.append(", ")
                }
                if let city = placeMark.locality ?? placeMark.subAdministrativeArea {
                    address.append(city)
                    address.append(", ")
                }
                if let state = placeMark.administrativeArea, let country = placeMark.country {
                    address.append(state)
                    address.append(", ")
                    address.append(country)
                }
                
                // Adding Marker Details
                marker.title = placeName
                marker.snippet = address
                marker.appearAnimation = .pop
                marker.map = mapView
                self.markers.append(marker)
                self.parent.mutatingWrapper.userMarkersUpdated?(self.markers)
            }
        }
    }
}

extension MapView {
    class MutatingWrapper {
        var userMarkersUpdated: (([GMSMarker]) -> Void)? = nil
    }
}

struct Place {
    let name: String
    let latLng: CLLocationCoordinate2D
    let adress: String
    let rating: Float
}
