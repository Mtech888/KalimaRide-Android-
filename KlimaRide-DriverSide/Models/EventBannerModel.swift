//
//  EventBannerModel.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 20/09/2023.
//

import Foundation

struct EventBannerModel: Codable {
    let status: Bool?
    let message: String
    let data: [EventDetails]?
}

// MARK: - Datum
struct EventDetails: Codable {
    let id: Int
    let eventTitle: String
    let eventBanner: String
    let latitude, longitude: Double
    let distance: Int

    enum CodingKeys: String, CodingKey {
        case id
        case eventTitle = "event_title"
        case eventBanner = "event_banner"
        case latitude, longitude, distance
    }
}
