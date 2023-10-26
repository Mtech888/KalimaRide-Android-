
//  DirectionsModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 25/10/2023.
//

import Foundation

struct DirectionsModel: Codable {
    let routes: [Routes]?
    let status: String?
}

struct Routes: Codable {
    let legs: [Legs]?
    let overview_polyline: OverViewPolyline?
    let summary: String?
}

struct Legs: Codable {
    let distance: Distance?
    let duration: Duration?
    let end_address: String?
    let end_location: EndLocation?
    let start_address: String?
    let start_location: StartLocation?
    let steps: [Steps]?
}

struct Distance: Codable {
    let text: String?
    let value: Int?
}

struct Duration: Codable {
    let text: String?
    let value: Int?
}

struct EndLocation: Codable {
    let lat: Double?
    let lng: Double?
}

struct StartLocation: Codable {
    let lat: Double?
    let lng: Double?
}

struct Steps: Codable {
    let polyline: Polyline?
}

struct Polyline: Codable {
    let points: String?
    let travel_mode: String?
}

struct OverViewPolyline: Codable {
    let points: String?
}
