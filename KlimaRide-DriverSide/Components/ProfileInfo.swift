//
//  ProfileInfo.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct ProfileInfo: View {
    @State var image: String = ""
    @State var title: String = ""
    @State var description: String?
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 0) {
                
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                
                VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                        .font(.custom(Font.medium, size: 18))
                            .foregroundColor(.primary)
                   
                    if let description = description {
                        Text(description)
                        .foregroundColor(Color(.systemGray2))
                        .font(.custom(Font.regular, size: 14))
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                Image("rightIcon")
            }
        }
    }
}

struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo()
    }
}
