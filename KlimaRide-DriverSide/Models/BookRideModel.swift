//
//  BookRideModel.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 26/09/2023.
//

import Foundation

struct BookRideModel: Codable {
    let status: Bool
    let message: String
    let data: BookRideData?
}

struct BookRideData: Codable {
    let current_bookings: [BookingData]?
    let past_bookings: [BookingData]?
}

struct BookingData: Codable {
    let id: Int?
    let ride_post_id: Int?
    let pickup_point_id: Int?
    let user_id: Int?
    let number_of_seats: Int?
    let per_seat_price: Int?
    let total_seats_price: Int?
    let price_currency: String?
    let status: String?
    let paid: Int?
    let created_at: String?
    let updated_at: String?
    let user_details: UserData?
    let ride_details: RideData?
}

struct UserData: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}

struct RideData: Codable {
    let id: Int?
    let user_id: Int?
    let vehicle_id: Int?
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
}
