//
//  constants.swift
//  KlimaRide-DriverSide
//
//  Created by MAC on 27/08/2023.
//

import Foundation

@_exported import SwiftUI
@_exported import UIKit
@_exported import Combine
@_exported import Alamofire
@_exported import PhoneNumberKit
@_exported import GoogleMaps
@_exported import CoreLocation
@_exported import GoogleSignIn
@_exported import SDWebImageSwiftUI
@_exported import ActivityIndicatorView

class APIs {
    static let baseURL = "https://sajjao.com/kalima/public/"
    static let signUp  = "api/v1/auth/signup"
    static let login = "api/v1/auth/login"
    static let logout = "api/v1/auth/logout"
    static let googleLogin = "api/v1/auth/login-with-google"
    static let appleLogin = "api/v1/auth/login-with-apple"
    static let updateProfile = "api/v1/auth/update-profile"
    static let userData = "api/v1/auth/user-data"
    static let forgotPassword = "api/v1/auth/forgot-password/"
    static let changePassword = "api/v1/auth/change-password"
    static let resetPasword = "api/v1/auth/reset-password"
    static let myVehicle = "api/v1/app/user-vehicles"
    static let eventBanner = "api/v1/app/event-banners"
    static let searchPost = "api/v1/app/search-post"
    static let rideDetails = "api/v1/app/post-details/"
    static let ridePost = "api/v1/app/ride-post"
    static let bookRide = "api/v1/app/booking"
    static let bookingStatusChange = "api/v1/app/change-status"
}

var authToken: String?
var FPemail: String?
var signInConfig : GIDConfiguration?
var formattedAddresses: [String] = []

class Font {
    static let medium = "GTWalsheimPro-Medium"
    static let regular = "GTWalsheimPro-Regular"
    static let light = "GTWalsheimPro-Light"
    static let bold = "GTWalsheimPro-Bold"
}

