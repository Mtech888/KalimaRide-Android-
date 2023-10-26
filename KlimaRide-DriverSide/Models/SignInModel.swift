//
//  SignInModel.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 28/08/2023.
//

import Foundation

struct SignInModel: Codable {
    let status: Bool
    let message: String
    let data: Token?
}

struct Token: Codable {
    let token: String?
}
