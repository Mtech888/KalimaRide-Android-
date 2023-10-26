//
//  UserDataModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 30/08/2023.
//

import Foundation

struct UserDataModel: Codable {
    let status: Bool
    let message: String
    let data: ModelData?
}

// MARK: - DataClass
struct ModelData: Codable {
    let id: Int
    let googleID, appleID, firstName, lastName: String
    let email: String
    let profileImage: String
    let countryCode: String
    let phone: String
    let latitude, longitude: Double
//    let licenseFrontImage, licenseBackImage, deviceType: String?
//    let type: String?
    
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
        case latitude, longitude
//        case licenseFrontImage = "license_front_image"
//        case licenseBackImage = "license_back_image"
//        case deviceType = "device_type"
//        case type
    }
}
