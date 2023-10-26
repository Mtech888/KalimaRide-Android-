
//
//  BookingTabs.swift
//  KlimaRideApp
//
//  Created by Mtechsoft on 09/08/2023.
//

import Foundation
import SwiftUI

enum SearchBookingTabs : Int, CaseIterable {
    case oneWay
    case returns
    case recurring
    
    var title : String {
        switch self {
        case .oneWay:
            return "One Way"
        case .returns:
            return "Return"
        case .recurring:
            return "Recurring"
            
        }
    }
}
