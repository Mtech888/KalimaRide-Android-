//
//  UserModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 29/08/2023.
//

import Foundation

struct UpdateProfileModel: Codable {
    let status: Bool?
    let message: String
    let data: DataModel?
}

// MARK: - DataClass
struct DataModel: Codable {
    let id: Int
    let googleID, appleID, firstName, lastName: String
    let email: String
    let profileImage: String
    let countryCode, phone: String
//    let latitude, longitude: Double
//    let licenseFrontImage, licenseBackImage, deviceType, fcmToken: String
//    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case googleID = "google_id"
        case appleID = "apple_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case profileImage = "profile_image"
        case countryCode = "country_code"
        case phone
//        case latitude, longitude
//        case licenseFrontImage = "license_front_image"
//        case licenseBackImage = "license_back_image"
//        case deviceType = "device_type"
//        case fcmToken = "fcm_token"
//        case type
    }
}
