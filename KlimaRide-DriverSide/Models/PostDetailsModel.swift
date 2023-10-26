//
//  RideDetailsModel.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/09/2023.
//

import Foundation

struct PostDetailsModel: Codable {
    let status: Bool
    let message: String
    let data: PostRideData?
}

struct PostRideData: Codable {
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
//    let pickup_latitude: Double?
//    let pickup_longitude: Double?
    let status: String?
    let pickup_points: [PickupLatLong]?
    let user_details: DriverData?
    let bookingUser: [BookingPassengers]?
    let bookings: BookingStatus?
}
struct PickupLatLong: Codable {
    let id: Int?
    let city: String?
    let location: String?
    let latitude: Double?
    let longitude: Double?
    let price: Int?
    let price_currency: String?
}
struct DriverData: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}

struct BookingPassengers: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}
struct BookingStatus: Codable {
    let accepted: [Accepted]?
    let pending: [Pending]?
    
}

struct Accepted: Codable {
    let id: Int?
    let ride_post_id: Int?
    let pickup_point_id: Int?
    let user_id: Int?
    let number_of_seats: Int?
    let per_seat_price: Int?
    let total_seats_price: Int?
    let price_currency: String?
    let transaction_id: String?
    let receipt_url: String?
    let status: String?
    let paid: Int?
    let user_details: AcceptedPassengerDetails?
    let pickup_points: AcceptedPassengerLocation?
}
struct AcceptedPassengerDetails: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}

struct AcceptedPassengerLocation: Codable {
    let id: Int?
    let post_id: Int?
    let city: String?
    let location: String?
    let latitude: Double?
    let longitude: Double?
    let price: Int?
    let price_currency: String?
}

struct Pending: Codable {
    let id: Int?
    let ride_post_id: Int?
    let pickup_point_id: Int?
    let user_id: Int?
    let number_of_seats: Int?
    let per_seat_price: Int?
    let total_seats_price: Int?
    let price_currency: String?
    let transaction_id: String?
    let receipt_url: String?
    let status: String?
    let paid: Int?
    let user_details: PendingPassengerDetails?
    let pickup_points: PendingPassengerLocation?
}

struct PendingPassengerDetails: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let profile_image: String?
}

struct PendingPassengerLocation: Codable {
    let id: Int?
    let post_id: Int?
    let city: String?
    let location: String?
    let latitude: Double?
    let longitude: Double?
    let price: Int?
    let price_currency: String?
}
//struct PostDetailsModel: Codable {
//    let status: Bool
//    let message: String
//    let data: PostRideData?
//}
//
//// MARK: - DataClass
//struct PostRideData: Codable {
//    let id, userID: Int
//    let vehicleID: Int?
//    let rideType, rideTitle: String
//    let description: String?
//    let perSeatPrice: Int
//    let priceCurrency: String
//    let numberOfSeats: Int
//    let departureCity, arrivalCity, leavingDate: String?
//    let rideDate: String?
//    let leavingTime, returningDate, returningTime: String?
//    let duration: String?
//    let pickupLatitude, pickupLongitude: String
//    let userDetails: DriverData
//    let bookings: [RideBooking]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case vehicleID = "vehicle_id"
//        case rideType = "ride_type"
//        case rideTitle = "ride_title"
//        case description
//        case perSeatPrice = "per_seat_price"
//        case priceCurrency = "price_currency"
//        case numberOfSeats = "number_of_seats"
//        case departureCity = "departure_city"
//        case arrivalCity = "arrival_city"
//        case rideDate = "ride_date"
//        case leavingDate = "leaving_date"
//        case leavingTime = "leaving_time"
//        case returningDate = "returning_date"
//        case returningTime = "returning_time"
//        case duration
//        case pickupLatitude = "pickup_latitude"
//        case pickupLongitude = "pickup_longitude"
//        case userDetails = "user_details"
//        case bookings
//    }
//}
//
//// MARK: - Booking
//struct RideBooking: Codable {
//    let id, ridePostID, pickupPointID, userID: Int
//    let numberOfSeats, perSeatPrice, totalSeatsPrice: Int
//    let priceCurrency, status: String
//    let paid: Int
//    let createdAt, updatedAt: String
//    let userDetail: DriverData?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ridePostID = "ride_post_id"
//        case pickupPointID = "pickup_point_id"
//        case userID = "user_id"
//        case numberOfSeats = "number_of_seats"
//        case perSeatPrice = "per_seat_price"
//        case totalSeatsPrice = "total_seats_price"
//        case priceCurrency = "price_currency"
//        case status, paid
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case userDetail = "user_detail"
//    }
//}
//
//// MARK: - DriverDetails
//struct DriverData: Codable {
//    let id: Int
//    let firstName, lastName: String
//    let profileImage: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case profileImage = "profile_image"
//    }
//}
