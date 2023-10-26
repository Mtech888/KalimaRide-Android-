//
//  AppleSignInModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 10/10/2023.
//

import Foundation

import Foundation

struct AppleSignInModel: Codable {
    let status: Bool
    let message: String
    let data: AppleToken?
}

struct AppleToken: Codable {
    let token: String?
}
