//
//  BookingTabs.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 09/08/2023.
//

import Foundation
import SwiftUI

enum UserBookingTabs : Int, CaseIterable {
    case currrentBooking
    case pastBookings
    
    var title : String {
        switch self {
        case .currrentBooking:
            return "Current Booking"
        case .pastBookings :
            return "Past Bookings"
        }
    }
}
