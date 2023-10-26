//
//  CustomNavbar.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct CustomNavbar: View {
    @State var action: () -> Void = {}
    @State var title: String
    @State var icon: String?
    @State var hiddenTitle: String?
    
    var body: some View {
            VStack {
                HStack {
                    if let icon = icon {
                        Button(action: action) {
                            Image(icon)
                        }
                    }
                    Spacer()
                    Text(title)
                        .font(.custom(Font.medium, size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    
                    if let hiddenTitle = hiddenTitle {
                        Text(hiddenTitle)
                            .hidden()
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 35)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.12)
    }
}

struct CustomNavbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavbar(action: {}, title: "Title")
            .previewLayout(.sizeThatFits)
    }
}
