//
//  GooglePlacesManager.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 06/10/2023.
//

import Foundation
import GooglePlaces

final class GooglePlacesManger {
    static let shared = GooglePlacesManger()
    private let client = GMSPlacesClient.shared()
    private init() {}
    public func setup() {
        GMSPlacesClient.provideAPIKey("AIzaSyByEvO85mYUlyQcSBcej1sqVgFdjrhj-rY")
    }
}
