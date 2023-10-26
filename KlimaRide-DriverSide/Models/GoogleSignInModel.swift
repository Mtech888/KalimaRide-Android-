//
//  GoogleSignInModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 29/08/2023.
//

import Foundation

struct GoogleSignInModel: Codable {
    let status: Bool
    let message: String
    let data: GoogleToken?
}

struct GoogleToken: Codable {
    let token: String?
}
