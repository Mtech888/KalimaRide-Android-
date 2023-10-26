//
//  CustomTextFeild.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 21/08/2023.
//

import SwiftUI

struct CustomTextFeild: View {
    @Binding var fieldBinding: String
    var title: String
    var placeholder: String
    var icon: String?
    var textFieldSeats: String?
    @State var showPriceLabel = false
    @State var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom(Font.regular, size: 13))
                .foregroundColor(.primary)
            
            HStack {
                TextField(placeholder, text: $fieldBinding)
                    .font(.custom(Font.regular, size: 15))
                
                if let icon = icon {
                    Button(action: action) {
                        Image (icon)
                    }
                }
                if let textFieldSeats = textFieldSeats {
                    Text(textFieldSeats)
                        .foregroundColor(.black)
                        .font(.custom(Font.medium, size: 13))
                }
            }
            .padding()
            .background(Color.white)
            .foregroundColor(.secondary)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.primary, lineWidth: 0.1)
        )
            
            if showPriceLabel {
                HStack(spacing: 0) {
                    Text("Recommended: ")
                    Text("$22")
                        .foregroundColor(.black)
                    Text(" or less per seat")
                }
                .padding(.top, 8)
                .foregroundColor(Color.theme.appColor)
                .font(.custom(Font.medium, size: 13))
            }
        }
    }
}

struct CustomTextFeild_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFeild(fieldBinding: .constant(""), title: "Title", placeholder: "")
    }
}
