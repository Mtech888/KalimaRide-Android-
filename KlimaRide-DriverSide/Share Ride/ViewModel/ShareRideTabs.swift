//
//  ShareRideTabs.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 06/09/2023.
//

import Foundation


enum ShareRideTabs : Int, CaseIterable {
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
