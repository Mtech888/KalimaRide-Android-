//
//  RidePostModel.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/09/2023.
//

import Foundation

struct RidePostModel: Codable {
    let status: Bool
    let message: String
    let data: DataContainer?
}

struct DataContainer: Codable {
    let currentPosts: [PostData]
    let oldPosts: [PostData]
}

struct PostData: Codable {
    let id: Int?
    let user_id: Int?
    let ride_type: String?
    let ride_title: String?
    let per_seat_price: Int?
    let number_of_seats: Int?
    let departure_city: String?
    let arrival_city: String?
    let ride_date: String?
    let leaving_date: String?
    let leaving_time: String?
    let returning_date: String?
    let returning_time: String?
    let duration: String?
    let pickup_latitude: String?
    let pickup_longitude: String?
    let bookings_count: Int?
}
