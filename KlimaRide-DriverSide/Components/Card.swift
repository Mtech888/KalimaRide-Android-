//
//  Card.swift
//  KlimaRide-DriverSide
//
//  Created by Mtechsoft on 22/08/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct Card: View {
    @State var userImage: String = ""
    @State var name: String = ""
    @State var type: String = ""
    @State var description: String = ""
    @State var date: String = ""
    @State var time: String = ""
    @State var availableSeats: String = ""
    @State var priceLabel: String = ""
    @State var status: String?
    @State var foregroundColor: Color?
    @State var backgroundColor: Color?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        WebImage(url: URL(string: "\(userImage)"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .cornerRadius(50)
                        Text(name)
                            .font(.custom(Font.regular, size: 11))
                            .foregroundColor(.primary)
                        Spacer()
                        Text(type)
                            .font(.custom(Font.medium, size: 12))
                            .foregroundColor(Color.theme.appColor)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(description)
                        .font(.custom(Font.medium, size: 15))
                        .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                }
                
                
                
                
                HStack(spacing: 18) {
                    HStack {
                        Image("calender-icon")
                        Text(date)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Image("time-icon")
                        Text(time)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Image("seats-icon")
                        Text(availableSeats)
                            .foregroundColor(.primary)
                    }
                }
                .font(.custom(Font.regular, size: 11))
                
                HStack {
                    HStack {
                        Text("Price")
                            .font(.custom(Font.regular, size: 11))
                            .foregroundColor(.primary)
                        Text(priceLabel)
                            .font(.custom(Font.medium, size: 16))
                            .foregroundColor(Color.theme.appColor)
                    }
                    Spacer()
                    if let status = status {
                        Text(status)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 12)
                            .font(.custom(Font.medium, size: 11))
                            .foregroundColor(foregroundColor)
                            .background(backgroundColor)
                            .cornerRadius(30)
                    }
                }
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, y: 5)

    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(foregroundColor: .white, backgroundColor: .green)
    }
}

