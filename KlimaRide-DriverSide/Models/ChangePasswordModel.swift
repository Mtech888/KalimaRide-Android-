//
//  ChangePasswordModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 15/09/2023.
//

import Foundation

struct ChangePasswordModel: Codable {
    let status: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let googleID, appleID, firstName, lastName: String
    let email: String
    let profileImage: String
    let countryCode, phone: Int
    let latitude, longitude: Int
    let licenseFrontImage, licenseBackImage, deviceType: String
    let type: Int

    enum CodingKeys: String, CodingKey {
        case id
        case googleID = "google_id"
        case appleID = "apple_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case profileImage = "profile_image"
        case countryCode = "country_code"
        case phone, latitude, longitude
        case licenseFrontImage = "license_front_image"
        case licenseBackImage = "license_back_image"
        case deviceType = "device_type"
        case type
    }
}
