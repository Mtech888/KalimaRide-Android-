//
//  RoundedCorners.swift
//  KlimaRideApp
//
//  Created by MAC on 17/08/2023.
//

import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 30, height: 80))
        
        return Path(path.cgPath)
    }
}
