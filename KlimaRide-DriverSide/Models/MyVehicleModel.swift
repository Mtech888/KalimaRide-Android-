// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MyVehicleModel: Codable {
    let status: Bool
    let message: String
    let data: [VehicleData]?
}

// MARK: - Datum
struct VehicleData: Codable {
    let id, userID: Int
    let brandName: String
    let modelName: Int
    let numberPlate: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case brandName = "brand_name"
        case modelName = "model_name"
        case numberPlate = "number_plate"
    }
}
