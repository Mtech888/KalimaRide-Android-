//
//  CustomSecureField.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 17/10/2023.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var fieldBinding: String
    var title: String = ""
    var icon: String = ""
    var placeholder: String = ""
    @State var action: () -> Void = {}
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.custom(Font.regular, size: 13))
                .foregroundColor(.primary)
            
            HStack {
                SecureField(placeholder, text: $fieldBinding)
                    .font(.custom(Font.regular, size: 15))
                
                Button(action: action) {
                    Image(icon)
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
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(fieldBinding: .constant(""))
    }
}
