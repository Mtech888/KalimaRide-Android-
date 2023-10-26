//
//  ForgotPasswordModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 01/09/2023.
//

import Foundation

struct ForgotPasswordModel: Codable {
    let status: Bool
    let message: String
    let data: ForgotPasswordData
}

// MARK: - DataClass
struct ForgotPasswordData: Codable {
    let email: String
    let code: Int
}
