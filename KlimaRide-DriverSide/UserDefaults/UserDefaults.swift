//
//  UserDefaults.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 30/08/2023.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case splash
    }
    
    var splashSaved: Bool {
        get {
            (value(forKey: UserDefaultKeys.splash.rawValue) != nil)
        }
        set{
            set(newValue, forKey: UserDefaultKeys.splash.rawValue)
        }
    }
}
