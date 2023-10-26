//
//  PickupPointVC.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 09/10/2023.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class PickupPointVC: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var pinIcon: UIImageView!
    
    let locationManager = CLLocationManager()
    var ridePostApi: RidePostApiMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        locationManager.delegate = self
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func seachBtnPressed(_ sender: Any) {
        goToPlaces()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
//        ridePostApi.ridePostOneWay()
//        ridePostApi?.ridePostOneWay()
        let vc = UIHostingController(rootView: AddStopover().environmentObject(ridePostApi ?? RidePostApiMethod()))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPlaces() {
        searchTxt.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func getAddressFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?, String?, String?, Error?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                completion(nil, nil, nil, error)
                return
            }
            
            if let placemark = placemarks?.first {
                let address = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                print("address -> \(address)")
                print("city -> \(city)")
                print("country -> \(country)")
                
                let item = PickupPoints(city: city, location: address, latitude: "\(latitude)", longitude: "\(longitude)", price: "")
                self.ridePostApi?.pickupPoint.append(item)
//                self.ridePostApi.pickupPoint = [
//                                "city": city,
//                                "location": address,
//                                "latitude": latitude, // You can add latitude and longitude here.
//                                "longitude": longitude,
//                        ]
                
                completion(address, city, country, nil)
            } else {
                completion(nil, nil, nil, NSError(domain: "Geocoder", code: 0, userInfo: [NSLocalizedDescriptionKey: "No placemarks found."]))
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}

extension PickupPointVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Places Name: \(place.name ?? "")")
                print("full address: \(place.formattedAddress ?? "")")
                print("lat: \(place.coordinate.latitude)")
                print("long: \(place.coordinate.longitude)")
                dismiss(animated: true, completion: nil)
        formattedAddresses.append("\(place.name ?? "") \(place.formattedAddress ?? "")")

                // Call the getAddressFromCoordinates function to get the address, city, and country
                getAddressFromCoordinates(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude) { (address, city, country, error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("Address = \(address ?? "")")
                        print("City = \(city ?? "")")
                        print("Country = \(country ?? "")")

                        // Move to the selected location on the map
                        let cord2D = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                        let marker = GMSMarker()
                        marker.position = cord2D
                        marker.title = place.name
                        marker.snippet = place.formattedAddress
//                        let markerImage = UIImage(named: "pin-icon")
//                        let markerView = UIImageView(image: markerImage
                        marker.iconView = self.pinIcon
                        marker.map = self.mapView

                        self.mapView.camera = GMSCameraPosition(target: cord2D, zoom: 15)

                        // Update the search text field with the selected address
                        self.searchTxt.text = place.formattedAddress
                    }
                }
            }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
}

extension PickupPointVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

