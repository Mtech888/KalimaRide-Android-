//
//  NotificationCard.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI

struct NotificationCard: View {
    
    @State var cardImage: String?
    @State var userDescription: String?
    @State var driverResponse: String?
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                
                if let cardImage = cardImage {
                    Image(cardImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                }
                
                
                VStack(alignment: .leading, spacing: 5) {
                    if let userDescription = userDescription {
                        Text(userDescription)
                            .font(.custom(Font.medium, size: 15))
                            .foregroundColor(.primary)
                    }
                   
                    if let driverResponse = driverResponse {
                        Text(driverResponse)
                            .foregroundColor(.primary)
                            .font(.custom(Font.regular, size: 12))
                    }
                }
                
                Spacer()
                
                Text("1 min ago")
                    .foregroundColor(Color(.systemGray4))
                    .font(.custom(Font.regular, size: 10))
                    .padding(.horizontal)
                    .padding(.bottom, 40)
            }
            .padding(.vertical, 5)
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)
//        .padding(.horizontal)
        .padding(.top, 5)
    }
}

struct NotificationCard_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCard()
    }
}
