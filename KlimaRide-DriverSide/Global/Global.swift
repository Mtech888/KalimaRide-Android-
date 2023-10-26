//
//  Global.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 30/08/2023.
//

import Foundation

class Global {
    class var shared : Global{
        struct Static{
            static let instance: Global = Global()
        }
        return Static.instance
    }
    var currentLoginUser : UserDataModel?
    var FCM_TOKEN: String?
    var AUTH_TOKEN: String?
    var POST_ID: String?
}

let userDefault = UserDefaults.standard
