//
//  TrackMapVC.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 25/10/2023.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class TrackMapVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var buttonPlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let startLat = 31.4032
        let startLng = 74.2560
        let endLat = 31.4697
        let endLng = 74.2728
        let sourceLocation = "\(startLat),\(startLng)"
        let destinationLocation = "\(endLat),\(endLng)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&sensor=false&units=metric&mode=driving&key=AIzaSyD3u-mlMOBQ8d2zSuqE7ifFxpNxh7VqZQk"
        
        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let jsonData = try JSON(data: data)
                let routes = jsonData["routes"].arrayValue
                
                for route in routes {
                    let overview_polyline = route["overview_polyline"].dictionary
                    let points = overview_polyline?["points"]?.string
                    let path = GMSPath.init(fromEncodedPath: points ?? "")
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeColor = .systemGreen
                    polyline.strokeWidth = 5
                    polyline.map = self.mapView
                    
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        // MARK: Marker for source location
                let sourceMarker = GMSMarker()
                sourceMarker.position = CLLocationCoordinate2D(latitude: startLat, longitude: startLng)
                sourceMarker.title = "Delhi"
                sourceMarker.snippet = "The Capital of INDIA"
                sourceMarker.map = self.mapView
                
                
                // MARK: Marker for destination location
                let destinationMarker = GMSMarker()
                destinationMarker.position = CLLocationCoordinate2D(latitude: endLat, longitude: endLng)
                destinationMarker.title = "Gurugram"
                destinationMarker.snippet = "The hub of industries"
                destinationMarker.map = self.mapView
        
        
        let camera = GMSCameraPosition(target: sourceMarker.position, zoom: 15)
        mapView.animate(to: camera)
    }
}
