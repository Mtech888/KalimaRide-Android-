//
//  NearByModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 23/10/2023.
//

import Foundation

struct NearByModel: Codable {
    let results: [Result]?
    let status: String?
}

struct Result: Codable {
    let geometry: Geometry?
    let icon: String?
    let icon_mask_base_uri: String?
    let name: String?
    let photos: [Photos]?
    let rating: Double?
    let vicinity: String?
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Photos: Codable {
    let height: Int?
    let html_attributions: [String]?
    let photo_reference: String?
    let width: Int?
}
