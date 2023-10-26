//
//  CustomButton.swift
//  KlimaRideApp
//
//  Created by MAC on 08/08/2023.
//

import SwiftUI

struct CustomButton: View {
    @State var action: () -> Void = {}
    var title: String = ""
    var icon: String?
    var background: Color
    var foreground: Color
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let icon = icon {
                    Image(icon)
                }
                Text(title)
                    .foregroundColor(foreground)
                    .font(.custom(Font.regular, size: 16))
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: 50, alignment: .center)
        .background(background)
        .cornerRadius(10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(background: Color.theme.appColor, foreground: Color(.white))
    }
}
