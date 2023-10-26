//
//  SearchPostModel.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 20/09/2023.
//

import Foundation

struct SearchPostModel: Codable {
    let status: Bool?
    let message: String
    let data: SearchPostDetails?
}

struct SearchPostDetails: Codable {
    let post: [Detail]?
    let otherPosts: [OtherPostDetail]?
}

struct Detail: Codable {
    let id: Int?
    let user_id: Int?
    let vehicle_id: Int?
    let ride_type: String?
    let ride_title: String?
    let description: String?
    let per_seat_price: Int?
    let price_currency: String?
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
    let status: String?
    let driver_details: SearchModelDriverDetails?
    let pickup_points: [SearchModelPickupPoints]?
}
struct SearchModelDriverDetails: Codable {
    let id: Int
    let first_name: String?
    let last_name: String?
    let profile_image: String?
    
}

struct SearchModelPickupPoints: Codable {
    let id: Int?
    let post_id: Int?
    let city: String?
    let location: String?
    let latitude: Double?
    let longitude: Double?
    let price: Int?
    let price_currency: String?
}

struct OtherPostDetail: Codable {
    let id: Int?
    let user_id: Int?
    let vehicle_id: Int?
    let ride_type: String?
    let ride_title: String?
    let description: String?
    let per_seat_price: Int?
    let price_currency: String?
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
    let status: String?
    let other_driver_details: OtherDriverDetails?
    let other_pickup_points: [OtherPickupPoints]?

    
}

struct OtherDriverDetails: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}

struct OtherPickupPoints: Codable {
    let id: Int?
    let post_id: Int?
    let city: String?
    let location: String?
    let latitude: Double?
    let longitude: Double?
    let price: Int?
    let price_currency: String?
}



