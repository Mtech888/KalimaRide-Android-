//
//  Application.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/09/2023.
//

import Foundation
import UIKit

final class ApplicationUtility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
