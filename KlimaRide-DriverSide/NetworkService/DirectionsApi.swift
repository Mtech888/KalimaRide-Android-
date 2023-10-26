//
//  DirectionsApi.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 25/10/2023.
//

import Foundation
import GoogleMaps
import SwiftyJSON

struct GoogleMapView: UIViewRepresentable {
    var mapView = GMSMapView()
    var directionsModel: DirectionsModel?
    
    
    func makeUIView(context: Context) ->GMSMapView {
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapView
        
        init(_ parent: GoogleMapView) {
            self.parent = parent
            super.init()
            
            // Fetch and display directions here
            let startLat = 31.4032
            let startLng = 74.2560
            let endLat = 31.4697
            let endLng = 74.2728
            let sourceLocation = "\(startLat),\(startLng)"
            let destinationLocation = "\(endLat),\(endLng)"
            
            let origin = CLLocationCoordinate2D(latitude: 31.4032, longitude: 74.2560)
            let destination = CLLocationCoordinate2D(latitude: 31.4697, longitude: 74.2728)

        }
        
        func fetchDirectionApi() {
//            let startLat = 31.4032
//            let startLng = 74.2560
//            let endLat = 31.4697
//            let endLng = 74.2728
//            let sourceLocation = "\(startLat),\(startLng)"
//            let destinationLocation = "\(endLat),\(endLng)"
//
//            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&sensor=false&units=metric&mode=driving&key=AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk"
//
//            AF.request(url).responseJSON { response in
//                guard let data = response.data else { return }
//
//                do {
//                    let jsonData = try JSON(data: data)
//                    let routes = jsonData["routes"].arrayValue
//
//                    for route in routes {
//                        let overview_polyline = route["overview_polyline"].dictionary
//                        let points = overview_polyline?["points"]?.string
//                        let path = GMSPath.init(fromEncodedPath: points ?? "")
//                        let polyline = GMSPolyline.init(path: path)
//                        polyline.strokeColor = .systemGreen
//                        polyline.map = self.mapView
//                    }
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }
        }
        
    }
}
